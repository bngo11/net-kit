#!/usr/bin/env python3

from bs4 import BeautifulSoup

async def generate(hub, **pkginfo):
	base_url = pkginfo['dir']['url']
	html_data = await hub.pkgtools.fetch.get_page(base_url)
	soup = BeautifulSoup(html_data, "html.parser")
	links = soup.find_all("a")
	all_files = {k: v[0] for k, v in pkginfo['dir']['files'].items()}
	fmt = pkginfo['dir']['format']
	releases = {}
	artifacts = {}

	for k, v in all_files.items():
		for link in links:
			href = link.get("href")
			if href and href.startswith(f'./{v}') and href.endswith(fmt):
				releases[k] = (v, href.strip('./'))
				break

	for k, v in releases.items():
		artifacts[k] = hub.Artifact(url=f"{base_url}{v[1]}")

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		artifacts=artifacts,
	)

	ebuild.push()


# vim: ts=4 sw=4 noet
