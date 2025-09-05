# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/tarball/f6542209f40f3f8f9e3dc9403d331ad2881fd7e3 -> amneziawg-go-0.2.15-f654220.tar.gz
https://direct.funtoo.org/ed/13/6f/ed136f5aae8700e8156f659037518336e7ca229b67da13b266a82bf2290415e9d3fb2a39a79271d2b814419f7a34665cbc39045a4fe86c6303f6cefc987248f0 -> amneziawg-go-0.2.15-funtoo-go-bundle-936935e0bc43d13d5eddba6fc2c80f9b5ad5ba16660d03b324e9b751ba41ac561c2af5fcb44703ddd36465489ca38258571d38d2a0155ae96fd52498440f5b08.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-go-* ${S} || die
}