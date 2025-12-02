# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/tarball/730d6c39d0c4e348a3d080bebe496664215e5c99 -> amneziawg-go-0.2.16-730d6c3.tar.gz
https://direct.funtoo.org/58/4a/3f/584a3f1e4da670fb3554771a3df2d156a5cba5ed8ee90662b0f9c8e80383ac41b33baebe18b999bda96663fdf7d547648cc024beaa48b7f66be296fedc36f441 -> amneziawg-go-0.2.16-funtoo-go-bundle-936935e0bc43d13d5eddba6fc2c80f9b5ad5ba16660d03b324e9b751ba41ac561c2af5fcb44703ddd36465489ca38258571d38d2a0155ae96fd52498440f5b08.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-go-* ${S} || die
}