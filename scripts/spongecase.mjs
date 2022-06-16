#!/usr/bin/env zx

let paste = await $`pbpaste`

const sponge = paste.stdout.split('').map((v, i) => i % 2 == 0 ? v.toLowerCase() : v.toUpperCase()).join('')

console.log(sponge)

await $`echo -n ${sponge} | pbcopy`
