# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/0eb55420350647a788e96282d03978e8a782d478 -> coredns-1.12.2-0eb5542.tar.gz
https://direct.funtoo.org/55/31/44/553144477433c0c026f653e2718444ff2de5d8a2c3e56358830b8da4a03960dee1e40fd629c835bd88b782fcace9e447952e695071c2fb746f0e680ea42edfb9 -> coredns-1.12.2-funtoo-go-bundle-d6cfae8cb05d77c40dc57005f474541c65598a63fda44f10516beb2d60659517defbea82edac4b03732d8226eb25311ce5793cd7f5ff0e3667578530a673d696.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-0eb5542"

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