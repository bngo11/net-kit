# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.80.3"
VERSION_LONG="1.80.3-tb107adf2b"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/b107adf2b69868e710d109a0a6992c00790b6e8e -> tailscale-1.80.3-b107adf.tar.gz
https://direct.funtoo.org/97/63/68/976368044dc793ab1f3ffa0ce5e33a10999dca4f96bd95c699f1b38e3be46d889b2a23b6412161485260e38e64d3f4feea46f0b642718935b02b013e69618d0f -> tailscale-1.80.3-funtoo-go-bundle-8385c1170bf5d5ffb4cab67a4f9d6f57ae9986877e5537c27579837f18b584026a8f14b8af01427293902741fe82110076904630cb58a6653d3c9b6313a181f5.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-b107adf"

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