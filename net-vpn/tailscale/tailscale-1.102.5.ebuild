# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module tmpfiles

DESCRIPTION="Tailscale VPN client"
SRC_URI="https://github.com/tailscale/tailscale/archive/v1.102.5.tar.gz -> tailscale-1.102.5.tar.gz"
HOMEPAGE="https://www.tailscale.com/"
KEYWORDS="*"
SLOT="0"
LICENSE="MIT"
IUSE=""
RESTRICT="network-sandbox"

RDEPEND="|| ( net-firewall/iptables net-firewall/nftables )"
BDEPEND=">=dev-lang/go-1.26.5"

src_compile() {
	export GOPATH=${S}
	go install ./cmd/tailscale ./cmd/tailscaled
}

src_install() {
	dosbin bin/tailscaled
	dobin bin/tailscale

	newtmpfiles "${FILESDIR}/${PN}.tmpfiles" ${PN}.conf
	newinitd "${FILESDIR}/${PN}d.initd" ${PN}
	newconfd "${FILESDIR}/${PN}d.confd" ${PN}
}