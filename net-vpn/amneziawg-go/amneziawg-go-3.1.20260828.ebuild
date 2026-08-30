# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/tarball/b5928efb6ca19f0153958460c3d141f04abc5c2e -> amneziawg-go-3.1.20260828-b5928ef.tar.gz
https://direct.funtoo.org/f5/78/fc/f578fc1f9dd955ccb02918aa7126163a4f27cbbd6f4bece78766a8561c9aa2a438504b1b6afebb2fbe6434098e43c9accf9d816b8ed0ef1bb1b88da4ea480431 -> amneziawg-go-3.1.20260828-funtoo-go-bundle-87d2e780d7a1f43637dfd35dafae8c628d374d60575af8e0d2356b8792a94022fac4e2bc41fc143c261b8759e27a386fd559dc00fd1b4d6c25e4d167a3c28ad6.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-go-* ${S} || die
}