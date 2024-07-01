# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION=" Private front-end for Reddit "
HOMEPAGE="https://github.com/redlib-org/redlib"
SRC_URI="https://github.com/redlib-org/redlib/tarball/d9e768100460dabb8016288ca17f22bdbada3a53 -> redlib-0.35.1-d9e7681.tar.gz
https://direct.funtoo.org/82/6c/c3/826cc30f0a85d581741fa5563ef82dcbf03893c821f3b56dd51ef537aa91178bceff46ea70aee039b523c7803eaac8873fb503b68203adca4b0c44640f7b6541 -> redlib-0.35.1-funtoo-crates-bundle-a0220ca28de114ce617047a7c2ece23f8cefdb71eea8d86db203e640113acb6c1fcbbf4cf700d4ac11f8cf342029a9e7f1e15e194a386a25d5b11cd6b0a08431.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="*"

DOCS=( README.md )

QA_FLAGS_IGNORED="/usr/bin/redlib"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/redlib-org-redlib-* ${S} || die
}