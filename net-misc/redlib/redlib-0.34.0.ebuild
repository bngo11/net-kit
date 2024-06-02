# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION=" Private front-end for Reddit "
HOMEPAGE="https://github.com/redlib-org/redlib"
SRC_URI="https://github.com/redlib-org/redlib/tarball/7a099f259fb5839cd0b5928876c2d22841d505dc -> redlib-0.34.0-7a099f2.tar.gz
https://direct.funtoo.org/0e/c6/51/0ec651b9f5ab9bf6006718ce6cd5a7893a245d8fb82fff8ce8434d65a8395a8495cddd728e6418ca577321a0895ff908c1c80b415849d0116513a06de0bf075c -> redlib-0.34.0-funtoo-crates-bundle-ddbde766dd5e299ff32ec1bd5ba01183891d7eaed53a40091af81fb6de9adb174f2703337bd5f6bba2c053351d9c9499a5cad350c358bfae3a7667cc7601c152.tar.gz"

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