#!/usr/bin/env python3

import json

async def generate(hub, **pkginfo):
	json_data = await hub.pkgtools.fetch.get_page(f"https://gitlab.com/api/v4/projects/7898047/repository/tags", is_json=True)
	version = None
	basever = "4.4"

	for item in json_data:
		try:
			version = item['name'].rsplit('-', 1)[-1]
			verlist = version.split(".")
			list(map(int, verlist))
			if len(verlist) > 1:
				if int(verlist[1]) >= 89 and int(verlist[0]) != 0:
					continue

			if basever:
				baselist = basever.split('.')
				baselen = len(baselist)
				if verlist[:baselen] != baselist:
					continue

			if version:
				break

		except (IndexError, ValueError, KeyError):
			continue
	else:
		version = None

	if version:
		pkginfo['version'] = version
		url = f'https://www.wireshark.org/download/src/all-versions/wireshark-{version}.tar.xz'
		final_name = f"{url.rsplit('/', 1)[-1]}"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]
		)
		ebuild.push()
# vim: ts=4 sw=4 noet
