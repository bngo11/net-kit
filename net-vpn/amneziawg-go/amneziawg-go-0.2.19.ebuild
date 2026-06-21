# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/tarball/1cc94272ca8e9e223a5fe76382f5880f09d3c12d -> amneziawg-go-0.2.19-1cc9427.tar.gz
https://direct.funtoo.org/81/6d/c7/816dc7b7a20c0980a818c82d97e476b40346e22de2934c3559ae0cc037febd441bf058cb9db42c4439f62185a9bab07573773d3f6713b9e0152c7e046b82e497 -> amneziawg-go-0.2.19-funtoo-go-bundle-99c1d5c1c21d33e7cef36a4c81f738d58234a139bfc266761f377e000ee7fda6d9280e59329edd1d1d9d73ed33d4f2b28bf910bbdf2a4af06436e2dfc9ea0c92.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-go-* ${S} || die
}