# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod-r1

DESCRIPTION="AmneziaWG Linux kernel module"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-linux-kernel-module"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-linux-kernel-module/tarball/ae0924ca700520ca34c5bdbcfd05b2f683ea9353 -> amneziawg-linux-kernel-module-1.0.20260725-ae0924c.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-linux-kernel-module-* ${S} || die
}

src_compile() {
    ln -s ${KV_DIR} src/kernel

    local modlist=(amneziawg=kernel/drivers/net:src:src:all)

    linux-mod-r1_src_compile
}