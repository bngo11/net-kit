# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Ncurses SIP Messages flow viewer"
HOMEPAGE="https://github.com/irontec/sngrep"
SRC_URI="https://github.com/irontec/sngrep/tarball/9c370866afaf5ccb258bf03848b2d22f30cf61bd -> sngrep-1.8.4-9c37086.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="eep gnutls pcre ssl zlib"

DEPEND="
	net-libs/libpcap
	sys-libs/ncurses:=
	ssl? (
		!gnutls? ( dev-libs/openssl:= )
		gnutls? ( net-libs/gnutls:= )
	)
	pcre? ( dev-libs/libpcre2 )
	zlib? ( sys-libs/zlib )
"
RDEPEND="${DEPEND}"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv irontec-sngrep* "${S}" || die
	fi
}

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--enable-ipv6
		--enable-unicode
		--without-pcre
		$(use_enable eep)
		$(use_with pcre pcre2)
		$(use_with ssl $(usex gnutls gnutls openssl))
		$(use_with zlib)
	)

	econf "${myeconfargs[@]}"
}