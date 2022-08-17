#!/usr/bin/env zx

$.prefix += 'export LC_ALL=en_US.UTF-8; '

let paste = await $`pbpaste`

const sponge = paste.stdout.split(' ')
	.map(word =>
		word.split('')
			.map((v, i) => i % 2 == 0
				? v.toLowerCase()
				: v.toUpperCase())
			.join(''))
	.join(' ');

await $`echo -n ${sponge} | pbcopy`
