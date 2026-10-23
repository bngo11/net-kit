# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/a6fde3fe339c6ec848447e11cc9796be8c97b4e0 -> coredns-1.15.0-a6fde3f.tar.gz
https://direct.funtoo.org/6a/19/95/6a1995865b84aa12d64b563f68a223a9ec9459102de61ef5572a8d67d533375e34a735aaf18a3c747818c75de45900fd3844c14ebd1f4939d1a18120644b621b -> coredns-1.15.0-funtoo-go-bundle-79af8927890f45a7edea503ecc71871f92423aa27db3f650ec89ad1a6cd108f29c910cf0a1254b9d43d32db3eb59b83955e426a58defd629781a14e67861f81c.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-a6fde3f"

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