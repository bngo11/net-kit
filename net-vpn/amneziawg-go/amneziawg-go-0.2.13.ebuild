# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/tarball/1abd24b5b9ca89609d26af1f43743d8a9dc940da -> amneziawg-go-0.2.13-1abd24b.tar.gz
https://direct.funtoo.org/8e/9b/b1/8e9bb185f3c2b4fdfb5868c5cff8fd791377e880933148470d671259266e99b89414b577706ab788c828a8906c7f45ea397db818bf3fbdd2fde899b833c1ee71 -> amneziawg-go-0.2.13-funtoo-go-bundle-e447dc0d580d5768a23c7b7e08a91205e8e051a56e945e5a6bd75271f8ce2180d6f64c89a257465ca24d95ef009bc881a4430bfb7f4e140f858918b9d6b3d73b.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-go-* ${S} || die
}