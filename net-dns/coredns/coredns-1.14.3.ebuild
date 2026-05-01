# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/17fceec6d93fd1dde5ba6888c363f131ff6d647f -> coredns-1.14.3-17fceec.tar.gz
https://direct.funtoo.org/9f/2a/02/9f2a02e2c7828f0fefcae187544aebfea1877c22eb7fa0544246975faeacf4dc7686b418d0a419c92cba6c2eab8253dc25a2d6318478ede1d0dd8a094d2d708c -> coredns-1.14.3-funtoo-go-bundle-55c16da0ab96be15a278a19b8868c794ee7ccf38664deaf85335d0842e2f1967737fae1f372d083b95b825318b87d59fedd6c156527ef6ce3fed8c1e4c1f3395.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-17fceec"

src_compile() {
	FORCE_HOST_GO=yes
	emake
}

src_install() {
	dobin ${PN}
	insinto /etc/"${PN}"
	doins "${FILESDIR}"/Corefile
	dodoc README.md
	doman man/*

	newinitd "${FILESDIR}"/"${PN}".initd ${PN}
	newconfd "${FILESDIR}"/"${PN}".confd ${PN}
	keepdir /var/log/"${PN}"
}