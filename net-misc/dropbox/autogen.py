#!/usr/bin/env python3

from bs4 import BeautifulSoup

async def generate(hub, **pkginfo):
	urlamd64 = await hub.pkgtools.fetch.get_url_from_redirect("https://www.dropbox.com/download?plat=lnx.x86_64")
	version = urlamd64.split("/")[-1].rsplit("-", 1)[-1].rstrip(".tar.gz")
	html_data = await hub.pkgtools.fetch.get_page("https://linux.dropbox.com/packages/")
	soup = BeautifulSoup(html_data, "html.parser")
	links = soup.find_all("a")
	links.reverse()

	for link in links:
		final_naut_name = link.get("href")
		if final_naut_name and final_naut_name.endswith(".tar.bz2"):
			naut_url = f"https://linux.dropbox.com/packages/{final_naut_name}"
			break

	github_repo = "dropbox-python-setup"
	github_user = "funtoo"
	github_tag = "1.1"

	if version:
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[
				hub.pkgtools.ebuild.Artifact(url=urlamd64, final_name=urlamd64.rsplit("/", 1)[-1]),
				hub.pkgtools.ebuild.Artifact(url=naut_url, final_name=final_naut_name),
				hub.pkgtools.ebuild.Artifact(
					url = f"https://www.github.com/{github_user}/{github_repo}/tarball/{github_tag}",
					final_name = f"{github_repo}-{github_tag}.tar.gz")]
		)

		ebuild.push()


# vim: ts=4 sw=4 noet
