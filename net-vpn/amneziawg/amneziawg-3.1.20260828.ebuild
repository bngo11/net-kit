# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod-r1

DESCRIPTION="AmneziaWG Linux kernel module"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-linux-kernel-module"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-linux-kernel-module/tarball/3c38e168beb7c60dec41dfe423d41555205a3dac -> amneziawg-linux-kernel-module-3.1.20260828-3c38e16.tar.gz"

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