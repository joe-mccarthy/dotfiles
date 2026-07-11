#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="$HOME"
install_deps=1
install_catppuccin=1
run_stow=1
package_file="$dotfiles_dir/packages/debian.txt"
apt_updated=0
catppuccin_only=0

microsoft_keyring="/usr/share/keyrings/microsoft.gpg"
microsoft_source="/etc/apt/sources.list.d/vscode.list"
microsoft_repo="deb [arch=amd64 signed-by=$microsoft_keyring] https://packages.microsoft.com/repos/code stable main"
qutebrowser_desktop="org.qutebrowser.qutebrowser.desktop"
thunar_desktop="thunar.desktop"
kitty_desktop="kitty.desktop"
loupe_desktop="org.gnome.Loupe.desktop"
evince_desktop="org.gnome.Evince.desktop"
code_desktop="code.desktop"
file_roller_desktop="org.gnome.FileRoller.desktop"
logind_i3_policy="/etc/systemd/logind.conf.d/90-i3-dotfiles.conf"

catppuccin_flavor="frappe"
catppuccin_accent="mauve"
catppuccin_gtk_release="v1.0.3"
catppuccin_gtk_theme="catppuccin-${catppuccin_flavor}-${catppuccin_accent}-standard+default"
catppuccin_gtk_legacy_theme="${catppuccin_gtk_theme}-dark"
catppuccin_gtk_installer_url="https://raw.githubusercontent.com/catppuccin/gtk/${catppuccin_gtk_release}/install.py"
catppuccin_qt5ct_repo="https://github.com/catppuccin/qt5ct.git"
catppuccin_kvantum_repo="https://github.com/catppuccin/Kvantum.git"

usage() {
  cat <<USAGE
usage: $0 [options]

Options:
  --no-install, --skip-deps   Do not install apt packages
  --no-catppuccin             Do not download/install Catppuccin GTK/Qt themes
  --catppuccin-only           Only install/apply Catppuccin GTK/Qt themes and restow config
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

remove_installed_packages() {
  label="$1"
  shift

  installed=()

  for package in "$@"; do
    if package_installed "$package"; then
      installed+=("$package")
    fi
  done

  if [ "${#installed[@]}" -eq 0 ]; then
    printf '%s packages are already removed.\n' "$label"
    return
  fi

  printf 'Removing %s packages: %s\n' "$label" "${installed[*]}"
  run_as_root apt-get remove -y "${installed[@]}"
}

desktop_file_exists() {
  [ -r "/usr/share/applications/$1" ] || [ -r "$HOME/.local/share/applications/$1" ]
}

set_xdg_mime_defaults() {
  desktop_file="$1"
  label="$2"
  shift 2

  if ! desktop_file_exists "$desktop_file"; then
    printf '%s desktop file not found; skipping default app setup: %s\n' "$label" "$desktop_file"
    return
  fi

  if command -v xdg-mime >/dev/null 2>&1; then
    for mime_type in "$@"; do
      xdg-mime default "$desktop_file" "$mime_type"
    done
  fi
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
    --no-catppuccin)
      install_catppuccin=0
      ;;
    --catppuccin-only)
      catppuccin_only=1
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
  remove_installed_packages "Firefox" firefox firefox-esr

  mapfile -t packages < <(read_packages)
  install_missing_packages "apt dependency" "${packages[@]}"
}

install_catppuccin_apt_dependencies() {
  if ! command -v apt-get >/dev/null 2>&1; then
    printf 'apt-get not found; skipping Catppuccin GTK/Qt dependency installation.\n'
    return
  fi

  install_missing_packages "Catppuccin GTK/Qt" \
    git \
    curl \
    python3 \
    qt5ct \
    qt6ct \
    qt5-style-kvantum \
    qt6-style-kvantum \
    papirus-icon-theme \
    bibata-cursor-theme
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

configure_logind_power_policy() {
  if ! command -v systemctl >/dev/null 2>&1 || [ ! -d /etc/systemd ]; then
    return
  fi

  policy_file=$(mktemp)
  cat > "$policy_file" <<LOGIND
[Login]
HandleLidSwitch=)
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
HoldoffTimeoutSec=30s
LOGIND

  run_as_root install -d -m 0755 "$(dirname "$logind_i3_policy")"
  run_as_root install -m 0644 "$policy_file" "$logind_i3_policy"
  rm -f "$policy_file"

  printf 'Installed i3 logind lid policy: %s\n' "$logind_i3_policy"
  printf 'Reboot or run sudo systemctl restart systemd-logind to apply it.\n'
}

replace_symlink() {
  source_path="$1"
  link_path="$2"

  if [ ! -e "$source_path" ]; then
    printf 'Warning: Catppuccin source path not found: %s\n' "$source_path" >&2
    return
  fi

  mkdir -p "$(dirname "$link_path")"
  if [ -e "$link_path" ] || [ -L "$link_path" ]; then
    rm -rf "$link_path"
  fi

  ln -s "$source_path" "$link_path"
}

write_qtct_config() {
  config_path="$1"
  color_scheme_path="$2"

  mkdir -p "$(dirname "$config_path")"
  cat > "$config_path" <<QTCT
[Appearance]
color_scheme_path=$color_scheme_path
custom_palette=true
icon_theme=Papirus-Dark
standard_dialogs=default
style=kvantum

[Fonts]
fixed="JetBrains Mono,10,-1,5,50,0,0,0,0,0"
general="JetBrains Mono,10,-1,5,50,0,0,0,0,0"
QTCT
}

install_catppuccin_user_themes() {
  missing_tools=()

  for tool in curl git python3; do
    if ! command -v "$tool" >/dev/null 2>&1; then
      missing_tools+=("$tool")
    fi
  done

  if [ "${#missing_tools[@]}" -gt 0 ]; then
    printf 'Missing Catppuccin installer tools: %s\n' "${missing_tools[*]}" >&2
    printf 'Run %s --catppuccin-only after installing those packages.\n' "$0" >&2
    return 1
  fi

  printf 'Installing Catppuccin %s GTK/Qt themes with %s accent.\n' "$catppuccin_flavor" "$catppuccin_accent"

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' RETURN

  gtk_theme_dir="$HOME/.local/share/themes/$catppuccin_gtk_theme"
  if [ ! -d "$gtk_theme_dir" ]; then
    curl -fsSL "$catppuccin_gtk_installer_url" -o "$tmp_dir/catppuccin-gtk-install.py"
    python3 "$tmp_dir/catppuccin-gtk-install.py" "$catppuccin_flavor" "$catppuccin_accent"
  fi

  if [ -d "$gtk_theme_dir" ]; then
    replace_symlink "$gtk_theme_dir" "$HOME/.local/share/themes/$catppuccin_gtk_legacy_theme"
  fi

  if [ -d "$gtk_theme_dir/gtk-4.0" ]; then
    replace_symlink "$gtk_theme_dir/gtk-4.0/assets" "$HOME/.config/gtk-4.0/assets"
    replace_symlink "$gtk_theme_dir/gtk-4.0/gtk.css" "$HOME/.config/gtk-4.0/gtk.css"
    replace_symlink "$gtk_theme_dir/gtk-4.0/gtk-dark.css" "$HOME/.config/gtk-4.0/gtk-dark.css"
  else
    printf 'Warning: GTK theme directory not found after install: %s\n' "$gtk_theme_dir" >&2
  fi

  git clone --depth 1 "$catppuccin_qt5ct_repo" "$tmp_dir/qt5ct" >/dev/null 2>&1
  qt_scheme_source="$(find "$tmp_dir/qt5ct/themes" -type f -iname "*${catppuccin_flavor}*${catppuccin_accent}*.conf" | head -n 1)"

  if [ -n "$qt_scheme_source" ]; then
    qt_scheme_name="$(basename "$qt_scheme_source")"
    mkdir -p "$HOME/.config/qt5ct/colors" "$HOME/.config/qt6ct/colors"
    install -m 0644 "$qt_scheme_source" "$HOME/.config/qt5ct/colors/$qt_scheme_name"
    install -m 0644 "$qt_scheme_source" "$HOME/.config/qt6ct/colors/$qt_scheme_name"
    write_qtct_config "$HOME/.config/qt5ct/qt5ct.conf" "$HOME/.config/qt5ct/colors/$qt_scheme_name"
    write_qtct_config "$HOME/.config/qt6ct/qt6ct.conf" "$HOME/.config/qt6ct/colors/$qt_scheme_name"
  else
    printf 'Warning: Catppuccin qt5ct scheme not found for %s/%s.\n' "$catppuccin_flavor" "$catppuccin_accent" >&2
  fi

  git clone --depth 1 "$catppuccin_kvantum_repo" "$tmp_dir/kvantum" >/dev/null 2>&1
  kvconfig_source="$(find "$tmp_dir/kvantum/themes" -type f -iname "*${catppuccin_flavor}*${catppuccin_accent}*.kvconfig" | head -n 1)"

  if [ -n "$kvconfig_source" ]; then
    kvantum_theme_dir="$(dirname "$kvconfig_source")"
    kvantum_theme_name="$(basename "$kvantum_theme_dir")"
    mkdir -p "$HOME/.config/Kvantum/$kvantum_theme_name"
    cp "$kvantum_theme_dir"/* "$HOME/.config/Kvantum/$kvantum_theme_name/"
    cat > "$HOME/.config/Kvantum/kvantum.kvconfig" <<KVANTUM
[General]
theme=$kvantum_theme_name
KVANTUM
  else
    printf 'Warning: Catppuccin Kvantum theme not found for %s/%s.\n' "$catppuccin_flavor" "$catppuccin_accent" >&2
  fi
}

configure_default_browser() {
  if ! desktop_file_exists "$qutebrowser_desktop"; then
    printf 'qutebrowser desktop file not found; skipping default browser setup.\n'
    return
  fi

  if command -v xdg-mime >/dev/null 2>&1; then
    xdg-mime default "$qutebrowser_desktop" \
      text/html \
      application/xhtml+xml \
      x-scheme-handler/http \
      x-scheme-handler/https
  fi

  if command -v xdg-settings >/dev/null 2>&1; then
    xdg-settings set default-web-browser "$qutebrowser_desktop" >/dev/null 2>&1 || true
  fi
}

configure_default_file_manager() {
  set_xdg_mime_defaults "$thunar_desktop" "Thunar" \
    inode/directory \
    application/x-gnome-saved-search
}

configure_default_terminal() {
  set_xdg_mime_defaults "$kitty_desktop" "kitty" \
    x-scheme-handler/terminal
}

configure_default_image_viewer() {
  set_xdg_mime_defaults "$loupe_desktop" "Loupe" \
    image/avif \
    image/bmp \
    image/gif \
    image/heic \
    image/jpeg \
    image/jxl \
    image/png \
    image/svg+xml \
    image/svg+xml-compressed \
    image/tiff \
    image/webp
}

configure_default_pdf_viewer() {
  set_xdg_mime_defaults "$evince_desktop" "Evince" \
    application/pdf
}

configure_default_text_editor() {
  set_xdg_mime_defaults "$code_desktop" "VS Code" \
    application/json \
    inode/x-empty \
    text/markdown \
    text/plain \
    text/x-shellscript
}

configure_default_archive_manager() {
  set_xdg_mime_defaults "$file_roller_desktop" "File Roller" \
    application/gzip \
    application/x-7z-compressed \
    application/x-bzip \
    application/x-bzip-compressed-tar \
    application/x-compressed-tar \
    application/x-gzip \
    application/x-rar \
    application/x-rar-compressed \
    application/x-tar \
    application/x-xz \
    application/x-xz-compressed-tar \
    application/zip \
    application/zstd
}

configure_default_apps() {
  configure_default_browser
  configure_default_file_manager
  configure_default_terminal
  configure_default_image_viewer
  configure_default_pdf_viewer
  configure_default_text_editor
  configure_default_archive_manager
}

prepare_stow_targets() {
  qutebrowser_target="$target_dir/.config/qutebrowser"
  qutebrowser_source="$dotfiles_dir/.config/qutebrowser"

  if [ -L "$qutebrowser_target" ]; then
    if [ "$(readlink -f "$qutebrowser_target")" = "$qutebrowser_source" ]; then
      unlink "$qutebrowser_target"
    else
      printf 'Warning: %s is a symlink not managed by this repo; leaving it alone.\n' "$qutebrowser_target" >&2
      return
    fi
  fi

  mkdir -p "$qutebrowser_target"
}

print_system_info

if [ "$catppuccin_only" -eq 1 ]; then
  install_catppuccin_apt_dependencies
  if [ "$run_stow" -eq 1 ]; then
    prepare_stow_targets
    stow -d "$dotfiles_dir" -t "$target_dir" --restow .
  fi
  install_catppuccin_user_themes
  if [ -x "$HOME/.local/bin/i3-apply-theme" ]; then
    "$HOME/.local/bin/i3-apply-theme"
  fi
  exit 0
fi

if [ "$install_deps" -eq 1 ]; then
  install_apt_dependencies
  configure_logind_power_policy
fi

if [ "$run_stow" -eq 1 ]; then
  prepare_stow_targets
  stow -d "$dotfiles_dir" -t "$target_dir" --restow .
fi

if [ "$install_catppuccin" -eq 1 ]; then
  install_catppuccin_user_themes
fi

if [ -x "$HOME/.local/bin/i3-apply-theme" ]; then
  "$HOME/.local/bin/i3-apply-theme"
fi

configure_default_apps

cat <<POST_INSTALL

Done.

Post-install notes:
- Log out and back into i3 after a first restore.
- Run ./init.sh --catppuccin-only to refresh Catppuccin GTK/Qt themes.
- Put local secrets in ~/.config/secrets/env; do not commit that file.
- Run ~/.local/bin/dots-backup check before committing or pushing.
POST_INSTALL
