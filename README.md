# Haz Gen2 Overlay

This is a repository for my use to replace the aging "gentoo-overlay" that I created.  This will contain ebuilds I create for tools that I use lacking an ebuild or Gentoo's portage tree is in need of maintenance.

Currently includes:

- FlashPrint5: 3D Printing utility for older FlashForge3D 3D Printers.  Has a reliance on qtopengl v5.
- qlipper: multiplatform clipboard utility.
- unifont: GNU unifont

## Gentoo Configuration

Simply add the following:

```text
[hazgen2-overlay]
location = /var/db/repos/hazgen2-overlay
sync-type = git
sync-uri = https://github.com/hasues/hazgen2-overlay
```

in `/etc/portage/repos.conf/hazgen2.conf` (or whatever you wish to name the configuration file).

Then use the `emaint` command:

```shell
emaint sync -r hazgen2-overlay
```
