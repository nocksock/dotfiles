NixOS Multi Server Config

The base nix configuration for my personal servers.

## Setting up a new server

1. Create Server (eg. Ubuntu on Hetzner)
2. Adjust `~/.ssh/config` and verify login with `ssh <machine>` works
6. `./nox infect <machine>` to install NixOS on remote host
7. `./nox config fetch <machine>` to fetch remote configuration
8. Adjust `./machines/<machine>/configuration.nix`
3. Adjust `./flake.nix` with new machine
4. Adjust `./globals/keys.nix`
5. `./nox key update <machine>` to update secrets etc
9. `./nox deploy <machine>` to deploy

## In case of rebuild

Run `nox key forget <machine>` to remove key from `known_hosts`

Overview
--------

## repo

baseline

+ user: snock
+ user: machine

+ service: gitlab
+ service: docker registry

## studio

baseline

+ user: snock
+ user: machine


TODOS
-----

- migrate cool.* to nixos

    budget.blpblp.io
    cv.blpblp.io
    images.blpblp.io
    nvc.blpblp.io
    osc.style
    pb.blpblp.io
    shr.blpblp.io
    status.blpblp.io
    sync.blpblp.io
    layout-simulator.com
    nocksock.dev
