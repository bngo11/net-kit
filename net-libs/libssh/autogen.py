#!/usr/bin/env python3

from bs4 import BeautifulSoup

async def generate(hub, **pkginfo):
	html_data = await hub.pkgtools.fetch.get_page("https://git.libssh.org/projects/libssh.git/refs/tags")
	soup = BeautifulSoup(html_data, "html.parser")
	links = soup.find_all("a")
	version = None

	for link in links:
		href = link.get("href")
		if href and href.endswith(".xz"):
			parts, final_name = href.rsplit("/", 1)
			version = final_name.split("-")[-1].rsplit(".", 2)[0]

			try:
				list(map(int, version.split(".")))
				break

			except ValueError:
				continue

	if version:
		url = f"https://git.libssh.org/projects/libssh.git/snapshot/{final_name}"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
		)

		ebuild.push()


# vim: ts=4 sw=4 noet
