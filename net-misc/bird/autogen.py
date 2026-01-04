#!/usr/bin/env python3

import json

async def generate(hub, **pkginfo):
	gitlabid = "6"
	gitlaburl = "gitlab.nic.cz"
	json_data = await hub.pkgtools.fetch.get_page(f"https://{gitlaburl}/api/v4/projects/{gitlabid}/repository/tags", is_json=True)
	version = None
	url = None
	basever = "3"

	for item in json_data:
		try:
			version = item['name'].lstrip('v').split(' ')[-1]
			verlist = version.split(".")
			list(map(int, verlist))
			if verlist[0] != basever:
				continue
			break

		except (IndexError, ValueError, KeyError):
			continue
	else:
		version = None

	if version:
		url=f"https://gitlab.nic.cz/labs/bird/-/archive/v{version}/bird-v{version}.tar.gz"
		pkginfo['version'] = version
		final_name = f'{pkginfo["name"]}-{version}.{".".join(url.split(".")[-2:])}'
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]
		)
		ebuild.push()
# vim: ts=4 sw=4 noet
