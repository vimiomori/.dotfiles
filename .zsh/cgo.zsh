# ── CGO flags for Homebrew native dependencies ───────────────────────────────

_cgo_include_dirs=(
  "$HOME/tmp/dtflib/include"
  "${HOMEBREW_PREFIX}/include"
  "${HOMEBREW_PREFIX}/opt/libarchive/include"
  "${HOMEBREW_PREFIX}/opt/libmagic/include"
  "${HOMEBREW_PREFIX}/opt/libiconv/include"
  "${HOMEBREW_PREFIX}/opt/uchardet/include"
)

_cgo_lib_dirs=(
  "${HOMEBREW_PREFIX}/lib"
  "${HOMEBREW_PREFIX}/opt/libarchive/lib"
  "${HOMEBREW_PREFIX}/opt/libmagic/lib"
  "${HOMEBREW_PREFIX}/opt/libiconv/lib"
)

export CGO_CFLAGS="${CGO_CFLAGS} ${(j: :)${_cgo_include_dirs/#/-I}}"
export CGO_LDFLAGS="${CGO_LDFLAGS} ${(j: :)${_cgo_lib_dirs/#/-L}}"

unset _cgo_include_dirs _cgo_lib_dirs
