# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/232d7cac38fbb8baeb900150d683e61da288ae75 -> coredns-1.14.4-232d7ca.tar.gz
https://direct.funtoo.org/8c/6d/8c/8c6d8ceb75b31f416679564efd17de5f47b1b33dc639be57e6c2220b857e2177a58aa2e8f9c40ce06efa049523ec42b2a1692629848b7f6742f2563153534152 -> coredns-1.14.4-funtoo-go-bundle-891756078eb11f14004277e539ae8694342208ae4c2202fda708d3aae6f62dad823c44d43d75a17984bf1956d921d3741d735392dcb347ae65996c5aa612c1f2.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-232d7ca"

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