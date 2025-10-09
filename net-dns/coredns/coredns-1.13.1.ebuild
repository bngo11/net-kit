# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/1db4568df6aaacda6ebbce87717156bd855f8103 -> coredns-1.13.1-1db4568.tar.gz
https://direct.funtoo.org/77/c8/00/77c800a301969f9798f2ff57e55ce5067103cdd951f6c118121d110a40a30df954804744d157466ab2b03bd5db69ca4260eaa487b81acecba0c11925da8f26e5 -> coredns-1.13.1-funtoo-go-bundle-aacac665a7c9490d645b460889571035603183d085f84ee17e52dda25aa02407a049093c3386fe49e8d00c186867ef57a087ae03cc43a9b7f90fefc33d503dbf.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-1db4568"

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