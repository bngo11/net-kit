# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.92.2"
VERSION_LONG="1.92.2-td792049c0"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/d792049c0a92aa5cb480beed6f589f1a40822e55 -> tailscale-1.92.2-d792049.tar.gz
https://direct.funtoo.org/c0/7d/74/c07d749ba1d0f6fc20b42249e8136a454525b9bc50d222ec1361d4c0aaf88ea3550e98077297012350b6d76e3c22ef249819d57db437c4c62874ba972ad02994 -> tailscale-1.92.2-funtoo-go-bundle-7576760e851ac8841d9c6713729879005059463672f0eb88a825e5b99631abb69701f3e2327792ec0b8a2efc76e28aecf1aa713fbae8fddfe9265bbbf7abbcc6.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-d792049"

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