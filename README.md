## pen (Project ENvironment)

This project is initially made for my personal needs, learning, and experimentation, but maybe others might find it or the idea useful as well. It's opinionated, strictly Linux-based and work in progress.

### Why?

I wanted to have a rootless and clean containerized environment for each project with related tools and runtimes, but at the same time didn't want to lose my familiar host configuration. Most importantly, I wanted a firewall that lets me easily control outbound requests both per project and per process. This helps me identify dependencies on external domains for both production and development environments, as well as block unwanted requests from different tools and apps.   

https://github.com/user-attachments/assets/64291fbd-51b4-43ea-b1b1-aea3d9cec50e

Existing solutions closest to my needs are distrobox and devcontainer, but with certain features that for my needs were obstacles or hard to change/maintain:

- **DevContainers** - designed to be a strict environment for the *application* to run in, not a comfortable environment for the *developer* to work in. It lacks a familiar user/host environment. Because they are OCI-based, implementing per-process firewall logic for me was too difficult. Its (sort of) tight integration with IDE (VS Code) was not helping either.
- **Distrobox** - gives you the familiar user environment by mapping the entire home directory, but it lacks an easy way to actually configure what to share, what should be read-only, and what should be writable. It's mostly meant for running software packaged for different Linux distros than the host and is not designed as a development environment with a built-in firewall in mind.

### What is `pen`?
`pen` is just a small bash wrapper around **Incus (LXC)**. 

The setup is split into two YAML files:
1. **The Recipe:** Where the distro, release, base packages, and system configuration are set.
2. **The Project Config:** Where project specifics live, e.g. container name, host mounts, and env vars (shared from host).

It's intended that `pen` is used with **OpenSnitch** (firewall, installed by default in the image), but this is not a strict requirement and is optional.

### Host Dependencies
- `incus`
- `distrobuilder`
- `yq`
- `envsubst`
- `opensnitch-ui` (for the firewall GUI)

### Comparison

| Feature              | DevContainers       | Distrobox            | `pen`                                     |
| :---                 | :---                | :---                 | :---                                      |
| **Runtime**          | OCI (Docker/Podman) | Hybrid               | **Incus (LXC)**                           |
| **Home Dir**         | Sterile/Isolated    | Maps everything      | **Surgical/Customizable**                 |
| **Network/firewall** | Static/Global       | Host-level           | **Interactive per-project & per-process** |
| **Focus**            | App Consistency     | Distro Compatibility | **Dev Experience**                        |

### Quick Start
```bash
# Initialize a new project environment
pen init [alias]

# Enter the environment
pen bash
```
