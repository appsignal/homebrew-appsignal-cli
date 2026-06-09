#!/bin/sh

set -eu

REPO="appsignal/homebrew-appsignal-cli"
BIN_NAME="appsignal-cli"
DEFAULT_INSTALL_DIR="/usr/local/bin"
RAW_BASE_URL="${RAW_BASE_URL:-https://raw.githubusercontent.com/$REPO/main}"
RELEASE_BASE_URL="${RELEASE_BASE_URL:-https://github.com/$REPO/releases/download}"

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

sha256_file() {
  file_path="$1"

  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$file_path" | cut -d' ' -f1
    return
  fi

  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$file_path" | cut -d' ' -f1
    return
  fi

  if command -v openssl >/dev/null 2>&1; then
    openssl dgst -sha256 "$file_path" | sed 's/^.*= //'
    return
  fi

  fail "Missing required command: sha256sum, shasum, or openssl"
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
need_cmd sed
need_cmd cut

target="$(detect_platform)"
version="$(resolve_version)"
install_dir="$(resolve_install_dir)"
archive_name="$target.tar.gz"
archive_url="$RELEASE_BASE_URL/v$version/$archive_name"
checksums_url="$RAW_BASE_URL/checksums/v$version.txt"
tmp_dir="$(mktemp -d)"

cleanup() {
  rm -rf "$tmp_dir"
}

trap cleanup EXIT INT TERM

log "Installing $BIN_NAME v$version for $target"
curl -fsSL "$checksums_url" -o "$tmp_dir/checksums.txt"
expected_sha="$(sed -n "s/^\([0-9a-f][0-9a-f]*\)  $archive_name$/\1/p" "$tmp_dir/checksums.txt")"
[ -n "$expected_sha" ] || fail "Could not find checksum for $archive_name"

curl -fsSL "$archive_url" -o "$tmp_dir/$archive_name"
actual_sha="$(sha256_file "$tmp_dir/$archive_name")"
[ "$actual_sha" = "$expected_sha" ] || fail "Checksum verification failed for $archive_name"

tar -xzf "$tmp_dir/$archive_name" -C "$tmp_dir"

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
