# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.62.1"
VERSION_LONG="1.62.1-t8ee5801a3"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/8ee5801a3d6b669620e38ee4fbe8b93d3b73af96 -> tailscale-1.62.1-8ee5801.tar.gz
https://direct.funtoo.org/fc/e9/f6/fce9f6a27a5a6d770aefd6ee7a075b5050f75b79891fd86b9f00abb2a69fea5d47f84307a32215f9ba67949ad4e67e40efa08f6825940d34f7420eb7f5a391c7 -> tailscale-1.62.1-funtoo-go-bundle-4bd980c4729c692e8f8a1a8e5b4ccf1518b010fe904e1b27e856c166eab8e95e36aa8451bca9456e618fb936aada8b1537dbe6550cd3b80b1d43cee285053fff.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-8ee5801"

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