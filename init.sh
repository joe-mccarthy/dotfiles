#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="$HOME"
install_deps=1
run_stow=1
package_file="$dotfiles_dir/packages/debian.txt"

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

  mapfile -t packages < <(read_packages)
  missing=()

  for package in "${packages[@]}"; do
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
