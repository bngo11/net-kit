# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.90.3"
VERSION_LONG="1.90.3-tca8f3d049"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/ca8f3d0495d72459735eef76f58f3ebe3112d3d1 -> tailscale-1.90.3-ca8f3d0.tar.gz
https://direct.funtoo.org/76/16/ff/7616ffaf4c50005b6b51b782da16c72a88f7015579831e0fe6e78035a7c22049cff9d7d05a5b4604ba6982a01b02f831e3a17263190cac9e27ee3e7855d2eae6 -> tailscale-1.90.3-funtoo-go-bundle-25c6481383b507fad08b41d133b87ef2e466d58f65e0c3a341e46c32251d8e15dfdd875459e53eec70fb1d64cd098539dea554039134bb94f83e107092c9c348.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-ca8f3d0"

# This translates the build command from upstream's build_dist.sh to an
# ebuild equivalent.
build_dist() {
	go build -tags xversion -ldflags "
		-X tailscale.com/version.longStamp=${VERSION_LONG}
		-X tailscale.com/version.shortStamp=${VERSION_SHORT}" "$@"
}

src_compile() {
	build_dist ./cmd/tailscale
	build_dist ./cmd/tailscaled
}

src_install() {
	dosbin tailscaled
	dobin tailscale

	insinto /etc/default
	newins cmd/tailscaled/tailscaled.defaults tailscaled
	keepdir /var/lib/${PN}
	fperms 0750 /var/lib/${PN}

	newtmpfiles "${FILESDIR}/${PN}.tmpfiles" ${PN}.conf

	newinitd "${FILESDIR}/${PN}d.initd" ${PN}
	newconfd "${FILESDIR}/${PN}d.confd" ${PN}
}

pkg_postinst() {
	tmpfiles_process ${PN}.conf
}