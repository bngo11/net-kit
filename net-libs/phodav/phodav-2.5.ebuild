# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
GNOME2_LA_PUNT="yes"

inherit gnome3 udev meson

DESCRIPTION="WebDav server implementation using libsoup"
HOMEPAGE="https://wiki.gnome.org/phodav"

LICENSE="LGPL-2.1+"
SLOT="2.0"
KEYWORDS="*"
IUSE="spice zeroconf"

# It included g_uuid_* symbols of its own from an unapplied patch to glib; now that they
# were merged, it conflicts and crashes. Ensure glib versions from >2.51 are used, so it
# doesn't break badly when phodav-2.2 is upgraded to before glib to 2.52
RDEPEND="
	>=dev-libs/glib-2.51:2
	>=net-libs/libsoup-2.48:2.4
	dev-libs/libxml2
	zeroconf? ( net-dns/avahi )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.10
	>=dev-util/intltool-0.40.0
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		$(meson_feature zeroconf avahi)
		-Dsystemd=disabled
		-Dudev=enabled
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	if use spice ; then
		newinitd "${FILESDIR}/spice-webdavd.initd" spice-webdavd
		udev_dorules "${FILESDIR}/70-spice-webdavd.rules"
	fi
}
