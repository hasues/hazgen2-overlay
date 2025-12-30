# Copyright 2025 F.H.
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT=19a577d6e0f2a12ef3087e409891fd1c9164d8a5
inherit cmake xdg

DESCRIPTION="Lightweight and cross-platform clipboard history applet"
HOMEPAGE="https://github.com/pvanek/qlipper"
SRC_URI="https://github.com/pvanek/${PN}/archive/${COMMIT}.tar.gz -> ${P}-${COMMIT:0:8}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# TODO: still accurate? bundles x11-libs/libqxt but no qt6 system version is available yet
RDEPEND="
	dev-qt/qtbase:6[gui,widgets]
	x11-libs/libX11
"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qttools:6[linguist]"
