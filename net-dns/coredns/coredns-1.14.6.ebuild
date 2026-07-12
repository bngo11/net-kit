# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/424d125775cd70fa90dfc80bf0e52cc9a9aeb574 -> coredns-1.14.6-424d125.tar.gz
https://direct.funtoo.org/c0/97/29/c09729bf6ca7086fdba623b0019630472873afc21b9634cd1cf8c499e90b64ef27736e921ad22d4be09d0483f8827e26a78b94de07cec1c4b6ccfabd3a7d7593 -> coredns-1.14.6-funtoo-go-bundle-2fe7c16be9e296ef51c7a0a2cf6e2f2be806a8e1efe8f8efeaee83141a4fc6183f59737702030bb427ea38a4b63dd09c94fc2a1c108dedea58452dbc2d5b112f.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-424d125"

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