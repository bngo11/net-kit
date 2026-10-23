# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION=" Private front-end for Reddit "
HOMEPAGE="https://github.com/redlib-org/redlib"
SRC_URI="https://github.com/redlib-org/redlib/tarball/ba116c1186f6b0f9d45f0ae50c827e13eb2f5ea2 -> redlib-0.40.0-ba116c1.tar.gz
https://direct.funtoo.org/69/84/22/698422cb56476f7bc7cfa9e053073fd7dfdc58bca1b8cded147b8ca9554b9cd8d28461af09537ba69e5e3084d0d54acf1a432df4bf3ccd4f5b6224ac5c66171d -> redlib-0.40.0-funtoo-crates-bundle-6bfe9ad102563de69ba8d61e2c270caa03fc6089df7d797dfaf86bfa79e6f2a864f92803043ea91acb62458e9d96dffc1f34e7a102955878f026d1aa22d7afb5.tar.gz"

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