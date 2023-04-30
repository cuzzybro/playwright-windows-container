# Run Playwright tests inside Windows Docker container

## Limitations

- You need to use `mcr.microsoft.com/windows` or `mcr.microsoft.com/windows/server` as a base image, `servercore` or `nanoserver` don't work due to missing dependencies.
- Firefox currently does not launch inside Windows Containers: https://github.com/microsoft/playwright/issues/13679

## Requirements

Windows 10 / 11 require Hyper-V turned on.<br>
See here: https://learn.microsoft.com/en-us/virtualization/windowscontainers/quick-start/set-up-environment?tabs=dockerce

## Usage

See the [`Dockerfile`](./Dockerfile) for the Dockerfile.

Demo project:

```bash
git clone https://github.com/cuzzybro/playwright-windows-container.git
cd playwright-windows-container
docker build -t cuzzybro/playwright-windows-containers .
docker run -it --isolation=hyperv --name="automation-container" cuzzybro/playwright-windows-containers
```