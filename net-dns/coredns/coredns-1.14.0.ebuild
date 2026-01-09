# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/1c964f2f68bd04a875a41479822ec3da1f1e76ef -> coredns-1.14.0-1c964f2.tar.gz
https://direct.funtoo.org/f9/54/a3/f954a376259c47b9b931c13a3b82acdbd07e385fcb8c4c82b67090e93fec0790198ebedada0176de54883da7ec9ad57b629e0f26b4775cbc6209e7d2db21d7fd -> coredns-1.14.0-funtoo-go-bundle-652f763844fd30c775c9fac2fe34dbef485e830b5499d93c29476c6d7c56df42e47e03727787c506945b72bf21260d08ad7a410ca5c7bb4c4319a1e6acddd675.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-1c964f2"

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