#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
install_deps=1

apt_packages=(
  dex
  dunst
  feh
  ffmpeg
  fontconfig
  fonts-dejavu-core
  i3-wm
  i3lock
  i3status
  jq
  kitty
  libnotify-bin
  maim
  network-manager-gnome
  picom
  rofi
  stow
  suckless-tools
  wireplumber
  x11-xkb-utils
  x11-xserver-utils
  xclip
  xdg-utils
  xss-lock
)

usage() {
  printf 'usage: %s [--no-install]\n' "$0"
}

for arg in "$@"; do
  case "$arg" in
    --no-install|--skip-deps)
      install_deps=0
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage >&2
      exit 2
      ;;
  esac
done

install_apt_dependencies() {
  if ! command -v apt-get >/dev/null 2>&1; then
    printf 'apt-get not found; skipping dependency installation.\n'
    return
  fi

  missing=()
  for package in "${apt_packages[@]}"; do
    if ! dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q 'install ok installed'; then
      missing+=("$package")
    fi
  done

  if [ "${#missing[@]}" -eq 0 ]; then
    printf 'All apt dependencies are already installed.\n'
    return
  fi

  printf 'Installing apt dependencies: %s\n' "${missing[*]}"

  if [ "$EUID" -eq 0 ]; then
    apt-get update
    apt-get install -y "${missing[@]}"
    return
  fi

  if ! command -v sudo >/dev/null 2>&1; then
    printf 'sudo not found. Install these packages as root: %s\n' "${missing[*]}" >&2
    exit 1
  fi

  sudo apt-get update
  sudo apt-get install -y "${missing[@]}"
}

if [ "$install_deps" -eq 1 ]; then
  install_apt_dependencies
fi

stow -d "$dotfiles_dir" -t "$HOME" --restow .
