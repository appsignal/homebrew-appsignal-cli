#!/bin/sh

set -eu

REPO="appsignal/homebrew-appsignal-cli"
BIN_NAME="appsignal-cli"
DEFAULT_INSTALL_DIR="/usr/local/bin"

log() {
  printf '%s\n' "$*"
}

fail() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || fail "Missing required command: $1"
}

detect_platform() {
  os="$(uname -s)"
  arch="$(uname -m)"

  case "$os" in
    Darwin)
      os_target="apple-darwin"
      ;;
    Linux)
      os_target="unknown-linux-gnu"
      ;;
    *)
      fail "Unsupported operating system: $os"
      ;;
  esac

  case "$arch" in
    arm64|aarch64)
      arch_target="aarch64"
      ;;
    x86_64|amd64)
      arch_target="x86_64"
      ;;
    *)
      fail "Unsupported architecture: $arch"
      ;;
  esac

  printf '%s-%s\n' "$arch_target" "$os_target"
}

resolve_version() {
  if [ -n "${VERSION:-}" ]; then
    printf '%s\n' "${VERSION#v}"
    return
  fi

  version="$({
    curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" |
      sed -n 's/^[[:space:]]*"tag_name":[[:space:]]*"v\{0,1\}\([^"]*\)".*/\1/p'
  } || true)"

  [ -n "$version" ] || fail "Could not determine the latest release version"
  printf '%s\n' "$version"
}

resolve_install_dir() {
  if [ -n "${INSTALL_DIR:-}" ]; then
    printf '%s\n' "$INSTALL_DIR"
    return
  fi

  if [ -d "$DEFAULT_INSTALL_DIR" ] && [ -w "$DEFAULT_INSTALL_DIR" ]; then
    printf '%s\n' "$DEFAULT_INSTALL_DIR"
    return
  fi

  if [ ! -e "$DEFAULT_INSTALL_DIR" ] && [ -w "$(dirname "$DEFAULT_INSTALL_DIR")" ]; then
    printf '%s\n' "$DEFAULT_INSTALL_DIR"
    return
  fi

  printf '%s\n' "$HOME/.local/bin"
}

install_binary() {
  source_path="$1"
  target_dir="$2"
  target_path="$target_dir/$BIN_NAME"

  if mkdir -p "$target_dir" 2>/dev/null && [ -w "$target_dir" ]; then
    install -m 0755 "$source_path" "$target_path"
    return
  fi

  if command -v sudo >/dev/null 2>&1; then
    sudo mkdir -p "$target_dir"
    sudo install -m 0755 "$source_path" "$target_path"
    return
  fi

  fail "No permission to write to $target_dir. Set INSTALL_DIR to a writable directory."
}

need_cmd curl
need_cmd tar
need_cmd install
need_cmd uname
need_cmd mktemp

target="$(detect_platform)"
version="$(resolve_version)"
install_dir="$(resolve_install_dir)"
archive_url="https://github.com/$REPO/releases/download/v$version/$target.tar.gz"
tmp_dir="$(mktemp -d)"

cleanup() {
  rm -rf "$tmp_dir"
}

trap cleanup EXIT INT TERM

log "Installing $BIN_NAME v$version for $target"
curl -fsSL "$archive_url" -o "$tmp_dir/$target.tar.gz"
tar -xzf "$tmp_dir/$target.tar.gz" -C "$tmp_dir"

[ -f "$tmp_dir/$BIN_NAME" ] || fail "Archive did not contain $BIN_NAME"

install_binary "$tmp_dir/$BIN_NAME" "$install_dir"

log "Installed to $install_dir/$BIN_NAME"

case ":$PATH:" in
  *":$install_dir:"*)
    ;;
  *)
    log "Add $install_dir to your PATH if it is not already available in new shells."
    ;;
esac
