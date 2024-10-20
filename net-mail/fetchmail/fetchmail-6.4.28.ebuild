# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2+ )
PYTHON_REQ_USE="tk"

inherit python-single-r1 systemd toolchain-funcs user autotools

DESCRIPTION="the legendary remote-mail retrieval and forwarding utility"
HOMEPAGE="http://www.fetchmail.info/"
SRC_URI="https://gitlab.com/fetchmail/fetchmail/-/archive/RELEASE_6-4-28/fetchmail-RELEASE_6-4-28.tar.gz -> fetchmail-6.4.28.tar.gz"

LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="*"
IUSE="ssl nls kerberos tk socks libressl"
REQUIRED_USE="tk? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	ssl? (
		!libressl? ( >=dev-libs/openssl-1.0.2:= )
		libressl?  ( dev-libs/libressl:= )
	)
	kerberos? (
		virtual/krb5
		!libressl? ( >=dev-libs/openssl-1.0.2:= )
		libressl?  ( dev-libs/libressl:= )
	)
	nls? ( virtual/libintl )
	!elibc_glibc? ( sys-libs/e2fsprogs-libs )
	socks? ( net-proxy/dante )
	tk? (
		${PYTHON_DEPS}
		dev-python/future
	)"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	sys-devel/flex
	nls? ( sys-devel/gettext )"

DOCS="NEWS README README.NTLM README.SSL*"
HTML_DOCS="*.html"
PATCHES=(
	"${FILESDIR}"/${PN}-6.3.26-python-optional.patch
)
S="${WORKDIR}/fetchmail-RELEASE_6-4-28"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
	use tk && python-single-r1_pkg_setup
}

src_prepare() {
	default
	# don't compile during src_install
	use tk && : > "${S}"/py-compile
	eautoreconf
}

src_configure() {
	use tk || export PYTHON=:

	econf \
		--enable-RPA \
		--enable-NTLM \
		--enable-SDPS \
		$(use_enable nls) \
		$(use_with ssl ssl "${EPREFIX}/usr") \
		$(use kerberos && echo "--with-ssl=${EPREFIX}/usr") \
		$(use_with kerberos gssapi) \
		$(use_with kerberos kerberos5) \
		--without-hesiod \
		$(use_with socks)
}

src_compile() {
	emake AR="$(tc-getAR)"
}

src_install() {
	keepdir /var/lib/${PN}
	fowners ${PN}:${PN} /var/lib/${PN}
	fperms 700 /var/lib/${PN}

	default

	newinitd "${FILESDIR}"/fetchmail.initd fetchmail
	newconfd "${FILESDIR}"/fetchmail.confd fetchmail

	systemd_dotmpfilesd "${FILESDIR}"/${PN}.conf

	docinto contrib
	local f
	for f in contrib/* ; do
		[ -f "${f}" ] && dodoc "${f}"
	done

	use tk && python_optimize
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "Please see /etc/conf.d/fetchmail if you want to adjust"
		elog "the polling delay used by the fetchmail init script."
	fi
}