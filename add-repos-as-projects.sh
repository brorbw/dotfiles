#!/usr/bin/env bash
rm ~/.emacs.d/.local/cache/projectile.projects

emacsclient --eval "(projectile-add-known-project \"~/.config\")" >/dev/null

find ~/clearhaus -type d -name ".git" -maxdepth 4 |
	xargs dirname |
	xargs -L 1 -I{} emacsclient --eval "(projectile-add-known-project \"{}\")" >/dev/null

find ~/Projects -type d -name ".git" -maxdepth 4 |
	xargs dirname |
	xargs -L 1 -I{} emacsclient --eval "(projectile-add-known-project \"{}\")" >/dev/null

find ~/dias -type d -name ".git" -maxdepth 4 |
	xargs dirname |
	xargs -L 1 -I{} emacsclient --eval "(projectile-add-known-project \"{}\")" >/dev/null
