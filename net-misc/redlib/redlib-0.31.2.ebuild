# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION=" Private front-end for Reddit "
HOMEPAGE="https://github.com/redlib-org/redlib"
SRC_URI="https://github.com/redlib-org/redlib/tarball/e79242c9e7aefa4ec5d1281385beab2faa7447ce -> redlib-0.31.2-e79242c.tar.gz
https://direct.funtoo.org/2a/61/3e/2a613e73ca70cc274a7253ee254cf537957ac3b19b30025b5930b2274555478ec2438e8c1021209f1535a0ed88c03c241670cb3bca063909d42a468b80dfbd2f -> redlib-0.31.2-funtoo-crates-bundle-bf9df7ad3467c78c0321a2c08ab4853e17017988656bd14890ea43d8eec024bf9ee95839847f6efe4e6024a344b7ca4212929d5525e6ab893ea3f38f91eedcfc.tar.gz"

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