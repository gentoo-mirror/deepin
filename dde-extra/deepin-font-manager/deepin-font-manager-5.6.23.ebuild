# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Install and Uninstall Font File for Users"
HOMEPAGE="https://github.com/linuxdeepin/deepin-font-manager"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtsvg:5
		 dev-qt/qtcore:5
		 dev-qt/qtgui:5
		 dev-qt/qtwidgets:5
		 media-libs/freetype:2
		 media-libs/fontconfig
		 dde-base/dde-file-manager:=
		 !dde-extra/deepin-font-installer
	     "
DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-5.1.2:=
	    "

src_prepare() {
	sed -i "/<QPainter>/a\#include\ <QPainterPath>" \
		deepin-font-manager/interfaces/dfontpreviewitemdelegate.cpp \
		deepin-font-manager/interfaces/dfontpreviewer.cpp \
		deepin-font-manager/views/dsplitlistwidget.cpp \
		deepin-font-manager/views/dfontspinner.cpp \
		deepin-font-manager/views/dfinstallerrorlistview.cpp || die

	export QT_SELECT=qt5 
	eqmake5	PREFIX=/usr DEFINES+="VERSION=${PV}"
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

