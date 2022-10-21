# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="A tool for building, changing, and combining infrastructure safely"
HOMEPAGE="https://www.terraform.io/"
SRC_URI="https://github.com/hashicorp/terraform/archive/v1.3.3.tar.gz -> terraform-1.3.3.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="*"

RESTRICT="test network-sandbox"

DOCS=( {README,CHANGELOG}.md )

src_compile() {
	go build -work -o "bin/${PN}" ./ || die
}

src_install() {
	dobin bin/terraform
	einstalldocs
}

pkg_postinst() {
	elog "If you would like to install shell completions please run:"
	elog "    terraform -install-autocomplete"
}