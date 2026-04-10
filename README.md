# docker-clrmamepro

****NOTE****
The updates to the original docker-clrmamepro were assisted with AI. This fork is to help me learn github and how to code. This is not intended for general use by anyone.

Docker container for [CLRMamePro](https://mamedev.emulab.it/clrmamepro/) — the ROM management and organization tool for Windows, running on Linux via Wine.

This is a modernized fork of [mikenye/docker-clrmamepro](https://github.com/mikenye/docker-clrmamepro), updated to:
- Use the current `jlesage/baseimage-gui` v4 (Ubuntu 24.04)
- Automatically check for and build new CLRMamePro versions daily via GitHub Actions
- Publish images to GitHub Container Registry (GHCR)

The web UI and VNC infrastructure is provided by the excellent [jlesage/baseimage-gui](https://github.com/jlesage/docker-baseimage-gui).

---

## Quick Start

```bash
docker run -d \
  --name=clrmamepro \
  --restart=unless-stopped \
  -p 5800:5800 \
  -v /path/to/config/backup:/opt/clrmamepro/backup \
  -v /path/to/config/datfiles:/opt/clrmamepro/datfiles \
  -v /path/to/config/settings:/opt/clrmamepro/settings \
  -v /path/to/roms:/opt/clrmamepro/roms \
  ghcr.io/Walker843/docker-clrmamepro:latest
```

Then browse to `http://your-host-ip:5800` to access the GUI.

---

## Docker Compose

See [docker-compose.yml](docker-compose.yml) for a full example. Copy it, adjust the volume paths, and run:

```bash
docker compose up -d
```

---

## Environment Variables

| Variable | Description | Default |
|---|---|---|
| `PUID` | User ID the app runs as | `1000` |
| `PGID` | Group ID the app runs as | `1000` |
| `DISPLAY_WIDTH` | Width of the application window | `1280` |
| `DISPLAY_HEIGHT` | Height of the application window | `768` |
| `VNC_PASSWORD` | Optional password for VNC access | *(none)* |

---

## Volumes

| Container Path | Description |
|---|---|
| `/opt/clrmamepro/backup` | Backup files |
| `/opt/clrmamepro/datfiles` | DAT files |
| `/opt/clrmamepro/dir2dat` | Dir2Dat output |
| `/opt/clrmamepro/downloads` | Downloads |
| `/opt/clrmamepro/fastscans` | Fast scan cache |
| `/opt/clrmamepro/headers` | Header files |
| `/opt/clrmamepro/logs` | Logs |
| `/opt/clrmamepro/scans` | Scan results |
| `/opt/clrmamepro/settings` | CLRMamePro settings/config |
| `/opt/clrmamepro/roms` | Your ROM collection |

---

## Ports

| Port | Protocol | Description |
|---|---|---|
| `5800` | HTTP | Web-based GUI access |
| `5900` | VNC | VNC client access (optional) |

---

## Auto-Updates

A GitHub Actions workflow runs daily and checks the CLRMamePro download page for a new version. If a new version is found, it automatically builds and pushes a new image tagged with both `latest` and the CLRMamePro version number (e.g., `cmpro4.045`).

You can also trigger a manual build at any time from the **Actions** tab in GitHub.

To keep your running container up to date, use Watchtower or simply pull the latest image:

```bash
docker compose pull && docker compose up -d
```
