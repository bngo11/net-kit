# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils user xdg-utils


DESCRIPTION="A fast, easy, and free BitTorrent client"
HOMEPAGE="https://transmissionbt.com/"
SRC_URI="https://github.com/transmission/transmission-releases/raw/master/transmission-3.00.tar.xz -> transmission-3.00.tar.xz"

# web/LICENSE is always GPL-2 whereas COPYING allows either GPL-2 or GPL-3 for the rest
# transmission in licenses/ is for mentioning OpenSSL linking exception
# MIT is in several libtransmission/ headers
LICENSE="|| ( GPL-2 GPL-3 Transmission-OpenSSL-exception ) GPL-2 MIT"
SLOT="0"
KEYWORDS="*"
IUSE="ayatana gtk libressl lightweight nls mbedtls qt5 test"
RESTRICT="!test? ( test )"

BDEPEND="
	virtual/pkgconfig
	nls? (
		gtk? (
			dev-util/intltool
			sys-devel/gettext
		)
		qt5? (
			dev-qt/linguist-tools:5
		)
	)
"
RDEPEND="
	dev-libs/libb64:0=
	>=dev-libs/libevent-2.0.10:=
	!mbedtls? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:0= )
	)
	mbedtls? ( net-libs/mbedtls:0= )
	net-libs/libnatpmp
	>=net-libs/miniupnpc-1.7:=
	>=net-misc/curl-7.16.3[ssl]
	sys-libs/zlib:=
	nls? ( virtual/libintl )
	gtk? (
		>=dev-libs/dbus-glib-0.100
		>=dev-libs/glib-2.32:2
		>=x11-libs/gtk+-3.4:3
		ayatana? ( >=dev-libs/libappindicator-0.4.30:3 )
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtnetwork:5
		dev-qt/qtdbus:5
	)
"
DEPEND="${RDEPEND}
	nls? (
		virtual/libintl
		gtk? (
			dev-util/intltool
			sys-devel/gettext
		)
		qt5? (
			dev-qt/linguist-tools:5
		)
	)
"


# Need the following to fix linguas issue shipped with Transmission.
# Removes invalid pt_PT from CMakeLists.txt as pt_PT.po does not 
# exist but pt.po does and causes build failure.

src_prepare() {
	sed -i -e '/pt_PT/d' po/CMakeLists.txt
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR=share/doc/${PF}

		-DENABLE_GTK=$(usex gtk ON OFF)
		-DENABLE_LIGHTWEIGHT=$(usex lightweight ON OFF)
		-DENABLE_NLS=$(usex nls ON OFF)
		-DENABLE_QT=$(usex qt5 ON OFF)
		-DENABLE_TESTS=$(usex test ON OFF)

		-DUSE_SYSTEM_EVENT2=ON
		-DUSE_SYSTEM_DHT=OFF
		-DUSE_SYSTEM_MINIUPNPC=ON
		-DUSE_SYSTEM_NATPMP=ON
		-DUSE_SYSTEM_UTP=OFF
		-DUSE_SYSTEM_B64=ON

		-DWITH_CRYPTO=$(usex mbedtls polarssl openssl)
		-DWITH_INOTIFY=ON
		-DWITH_LIBAPPINDICATOR=$(usex ayatana ON OFF)
		-DWITH_SYSTEMD=OFF
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newinitd "${FILESDIR}"/transmission-daemon.initd.10 transmission-daemon
	newconfd "${FILESDIR}"/transmission-daemon.confd.4 transmission-daemon

	insinto /usr/lib/sysctl.d
	doins "${FILESDIR}"/60-transmission.conf
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update

	enewgroup transmission
	enewuser transmission -1 -1 /var/lib/transmission transmission

	if [[ ! -e "${EROOT%/}"/var/lib/transmission ]]; then
		mkdir -p "${EROOT%/}"/var/lib/transmission || die
		chown transmission:transmission "${EROOT%/}"/var/lib/transmission || die
    fi
}

pkg_postrm() {
	if use gtk || use qt5; then
		xdg_desktop_database_update
		xdg_icon_cache_update
	fi
}

# vim: ts=4 sw=4 noet