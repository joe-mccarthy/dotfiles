#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="$HOME"
install_deps=1
run_stow=1
package_file="$dotfiles_dir/packages/debian.txt"
apt_updated=0

microsoft_keyring="/usr/share/keyrings/microsoft.gpg"
microsoft_source="/etc/apt/sources.list.d/vscode.list"
microsoft_repo="deb [arch=amd64 signed-by=$microsoft_keyring] https://packages.microsoft.com/repos/code stable main"

usage() {
  cat <<USAGE
usage: $0 [options]

Options:
  --no-install, --skip-deps   Do not install apt packages
  --no-stow                   Do not run stow
  --packages FILE             Read apt packages from FILE
  --list-packages             Print packages and exit
  -h, --help                  Show this help
USAGE
}

read_packages() {
  awk '
    /^[[:space:]]*#/ { next }
    /^[[:space:]]*$/ { next }
    { print $1 }
  ' "$package_file"
}

run_as_root() {
  if [ "$EUID" -eq 0 ]; then
    "$@"
    return
  fi

  if ! command -v sudo >/dev/null 2>&1; then
    printf 'sudo not found. Run this as root or install sudo.\n' >&2
    exit 1
  fi

  sudo "$@"
}

apt_update_once() {
  if [ "$apt_updated" -eq 0 ]; then
    run_as_root apt-get update
    apt_updated=1
  fi
}

package_installed() {
  dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -q 'install ok installed'
}

install_missing_packages() {
  label="$1"
  shift

  missing=()

  for package in "$@"; do
    if ! package_installed "$package"; then
      missing+=("$package")
    fi
  done

  if [ "${#missing[@]}" -eq 0 ]; then
    printf '%s packages are already installed.\n' "$label"
    return
  fi

  printf 'Installing %s packages: %s\n' "$label" "${missing[*]}"

  apt_update_once
  run_as_root apt-get install -y "${missing[@]}"
}

print_system_info() {
  if [ -r /etc/os-release ]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    printf 'System: %s\n' "${PRETTY_NAME:-unknown Linux}"
  fi
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --no-install|--skip-deps)
      install_deps=0
      ;;
    --no-stow)
      run_stow=0
      ;;
    --packages)
      shift || {
        usage >&2
        exit 2
      }
      if [ "$#" -eq 0 ]; then
        usage >&2
        exit 2
      fi
      package_file="${1:-}"
      ;;
    --list-packages)
      read_packages
      exit 0
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
  shift || true
done

install_apt_dependencies() {
  if [ ! -r "$package_file" ]; then
    printf 'Package manifest not found: %s\n' "$package_file" >&2
    exit 1
  fi

  if ! command -v apt-get >/dev/null 2>&1; then
    printf 'apt-get not found; skipping dependency installation.\n'
    return
  fi

  ensure_i3_desktop
  ensure_microsoft_code_repo

  mapfile -t packages < <(read_packages)
  install_missing_packages "apt dependency" "${packages[@]}"
}

manifest_contains_package() {
  read_packages | grep -qx "$1"
}

ensure_i3_desktop() {
  # A fresh GNOME install has a display manager already, but i3 still needs
  # the i3 session package and Xorg session support for GDM's session chooser.
  install_missing_packages "i3 desktop" i3 xserver-xorg xinit

  if [ ! -e /usr/share/xsessions/i3.desktop ]; then
    printf 'Warning: /usr/share/xsessions/i3.desktop was not found after installing i3.\n' >&2
    printf 'You may need to reinstall the i3 package or check your display manager.\n' >&2
  fi
}

ensure_microsoft_code_repo() {
  if ! manifest_contains_package code; then
    return
  fi

  prereqs=(ca-certificates curl gpg)
  missing_prereqs=()

  for package in "${prereqs[@]}"; do
    if ! package_installed "$package"; then
      missing_prereqs+=("$package")
    fi
  done

  if [ "${#missing_prereqs[@]}" -gt 0 ]; then
    printf 'Installing Microsoft repo prerequisites: %s\n' "${missing_prereqs[*]}"
    install_missing_packages "Microsoft repo prerequisite" "${missing_prereqs[@]}"
  fi

  repo_changed=0

  if [ ! -s "$microsoft_keyring" ]; then
    ascii_key=$(mktemp)
    gpg_key=$(mktemp)

    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc -o "$ascii_key"
    gpg --batch --yes --dearmor --output "$gpg_key" "$ascii_key"
    run_as_root install -m 0644 "$gpg_key" "$microsoft_keyring"

    rm -f "$ascii_key" "$gpg_key"
    repo_changed=1
  fi

  if [ ! -r "$microsoft_source" ] || ! grep -Fxq "$microsoft_repo" "$microsoft_source"; then
    source_file=$(mktemp)
    printf '%s\n' "$microsoft_repo" > "$source_file"
    run_as_root install -m 0644 "$source_file" "$microsoft_source"
    rm -f "$source_file"
    repo_changed=1
  fi

  if [ "$repo_changed" -eq 1 ]; then
    apt_updated=0
    apt_update_once
  fi
}

print_system_info

if [ "$install_deps" -eq 1 ]; then
  install_apt_dependencies
fi

if [ "$run_stow" -eq 1 ]; then
  stow -d "$dotfiles_dir" -t "$target_dir" --restow .
fi

cat <<POST_INSTALL

Done.

Post-install notes:
- Log out and back into i3 after a first restore.
- Put local secrets in ~/.config/secrets/env; do not commit that file.
- Run ~/.local/bin/dots-backup check before committing or pushing.
POST_INSTALL
