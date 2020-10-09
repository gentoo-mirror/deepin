# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit ecm

DESCRIPTION="KWin configures on DDE"
HOMEPAGE="https://github.com/linuxdeepin/dde-kwin"

SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/gsettings-qt
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtdbus:5
		dev-qt/qtx11extras:5
		kde-frameworks/kconfig:5
		kde-frameworks/kcoreaddons:5
		kde-frameworks/kwindowsystem:5
		kde-frameworks/kglobalaccel:5
		x11-libs/libxcb
		media-libs/fontconfig
		media-libs/freetype
		dev-libs/glib
		x11-libs/libXrender
		sys-libs/mtdev
		kde-plasma/kwin:5
		dde-base/dde-qt5integration
		>=dde-base/dtkcore-2.0.9
		"
DEPEND="${RDEPEND}
		"

PATCHES=(
    "${FILESDIR}"/${PN}-5.0.14.1-kwin-5.18-override-error.patch
	"${FILESDIR}"/dde-kwin-5.1.0-build-with-qt5.15.patch
	"${FILESDIR}"/dde-kwin-5.1.0.3-tabbox-rename.patch
#	"${FILESDIR}"/dde-kwin-5.1.0.20-kwaylandserver-5.19.patch
)

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" deepin-wm-dbus/deepinwmfaker.cpp || die
	ecm_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DPROJECT_VERSION=${PV}
	)

	ecm_src_configure
}

src_install() {
	ecm_src_install
	fperms 755 /usr/bin/kwin_no_scale
}
