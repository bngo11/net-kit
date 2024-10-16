# Distributed under the terms of the GNU General Public License v2

EAPI=7
GNOME_ORG_MODULE="${P/networkmanager/NetworkManager}"
GNOME3_EAUTORECONF="yes"

inherit gnome3 user

DESCRIPTION="NetworkManager OpenVPN plugin"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"
SRC_URI="https://gitlab.gnome.org/GNOME/NetworkManager-openvpn/-/archive/1.8.16/NetworkManager-openvpn-1.8.16.tar.gz -> networkmanager-openvpn-1.8.16.tar.gz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="test gnome"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/glib-2.32:2
	>=net-misc/networkmanager-1.7.0:=
	>=net-vpn/openvpn-2.1
	gnome? (
		>=net-libs/libnma-1.7.0
		>=x11-libs/gtk+-3.4:3
		>=app-crypt/libsecret-0.18
	)
"

DEPEND="${RDEPEND}
	dev-libs/libxml2:2
	sys-devel/gettext
	>=dev-util/intltool-0.35
	virtual/pkgconfig
"

pkg_setup() {
	enewgroup nm-openvpn
	enewuser nm-openvpn -1 -1 -1 nm-openvpn
}

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/$GNOME_ORG_MODULE* ${S} || die
}

src_prepare() {
	# Test will fail if the machine doesn't have a particular locale installed
	# FAIL: (tls-import-data) unexpected 'ca' secret value, upstream bug #742708
	sed '/test_non_utf8_import (plugin, test_dir)/ d' \
		-i properties/tests/test-import-export.c || die "sed failed"
	gnome3_src_prepare
}

src_configure() {
	# --localstatedir=/var needed per bug #536248
	gnome3_src_configure \
		--localstatedir=/var \
		--disable-more-warnings \
		--disable-static \
		--with-dist-version=Funtoo \
		--without-libnm-glib \
		$(use_with gnome gnome)
}