# Copyfight 2025 Fletch Hasues (J.G)
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Flashforge FlashPrint 5"
HOMEPAGE="https://enterprise.flashforge.com/pages/flashprint"

DEB_FILE="6f64d485b9145f2bc1dfca2d8afb7e7d.deb"
SRC_URI="https://en.fss.flashforge.com/10000/software/${DEB_FILE}"

LICENSE="flashprint"
SLOT="0"
KEYWORDS="~amd64"
INHERIT="udev"

# No source operations as it comes from a Debian file.
RESTRICT="mirror strip bindist"
PV="5.8.7"

# We need tar for this to work.
DEPEND="
  app-alternatives/tar
"

# We need qtopengl 5 here.  We need to keep this ebuild out separately in case
#  Gentoo drops this version of Qt from portage.
RDEPEND="
  =dev-qt/qtopengl-5.15.17
  sys-libs/glibc
"

QA_PREBUILT="
  usr/lib64/libOCCTWrapper.so*
"

# Just shortcut the workdirectory.
S="${WORKDIR}"

src_unpack() {

  # Unpack the .deb file.
  mkdir "${S}/deb-extract" || die
  cd  "${S}/deb-extract" || die

  # Extract the .deb file.
  ar x "${DISTDIR}/${DEB_FILE}" || die

  # This should be `data.tar.xz` but let's test:
  if [[ -f data.tar.xz ]]; then
      tar -xf data.tar.xz || die
  elif [[ -f data.tar.zst ]]; then
      zstd -d data.tar.zst | tar -xf - || die
  elif [[ -f data.tar.gz ]]; then
      tar -xf data.tar.gz || die
  else
      die "Unsupported data.tar.* compression in .deb"
  fi

}

src_install() {

  # All needed is to copy files from the paths created from the deb file.
  cp -a "${S}/deb-extract/usr/share" "${D}/usr" || die
  mkdir -p "${D}/lib/udev/rules.d" || die
  cp -a "${S}/deb-extract/etc/udev/rules.d/99-flashforge5.rules" "${D}/lib/udev/rules.d" || die
  
  # Grab the library.
  insinto /usr/$(get_libdir)
  doins "${S}/deb-extract/usr/lib/libOCCTWrapper.so.1" || die
  dosym libOCCTWrapper.so.1 /usr/$(get_libdir)/libOCCTWrapper.so
  
  # Manage the documentaion
  if [[ -d "${S}/deb-extract/usr/share/doc/flashprint5" ]]
  then
    dodoc -r "${S}/deb-extract/usr/share/doc/flashprint5/"* || die
  fi
  
}
