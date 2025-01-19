# GCR-Laravel

GCR-Laravel offers ready-made Docker images for Laravel projects. These images are designed to work across various systems and are optimized for Alpine and Debian environments. Access them directly from the [GitHub Container Registry (GHCR)](https://github.com/KiTechSoftware/gcr-laravel). Images are always updated to use the currently supported and stable PHP version, which is currently 8.4.

---

## Features

- **System Compatibility**:
    - Supports `linux/amd64`, `linux/arm64`, and `linux/arm/v7` architectures.
- **Pre-Built Images**:
    - Available at: `ghcr.io/kitechsoftware/laravel`
- **Laravel-Optimized**:
    - Configurations for Nginx and PHP-FPM tailored specifically for Laravel.
- **Lightweight Design**:
    - Leverages the efficiency of `Alpine` and `Debian` distributions.
- **Setup Automation**:
    - Includes a setup script to streamline tasks like generating `.env` files, managing permissions, and installing dependencies.

---

## Using the Docker Images

The current image tags available are:

- 11-laravel-alpine
- 11-laravel-debian
- 11-lumen-alpine
- 11-lumen-debian

### Downloading an Image

To download an image, use the following command:

```bash
# Example: Download the Laravel Alpine image
docker pull ghcr.io/kitechsoftware/laravel:11-laravel-alpine
```

### Running a Container

To start a container with the downloaded image:

```bash
# Example: Run the Laravel Alpine image
docker run -p 80:80 --name laravel-app ghcr.io/kitechsoftware/laravel:11-laravel-alpine
```

To run an existing Laravel project, use the following command:

```sh
docker run -p 80:80 -v $(pwd):/var/www/html laravel-app
```

#### Optional: Access the Container and Run the Post-Setup Script

Each image includes a `setup` script to simplify Laravel setup. The script performs the following tasks:

- Creates a `.env` file if it doesn’t already exist.
- Installs dependencies using Composer.
- Configures permissions for `storage` and `bootstrap/cache` directories.

To access the container, use:
```sh
docker exec -it <container_id> bash
```

and run the post-setup script inside the container:

```sh
sh /usr/local/bin/setup
```

Alternatively, you can simply run:

```sh
setup
```

The post-setup script is not tied to the container lifecycle.

##### Support for Both Workflows

- **Fresh Laravel Installation**: Set up a new Laravel project.
- **Existing Project Setup**: Set up an existing project via volume mount.

---

## Folder Structure

Here’s how the repository is organized:

```plaintext
.
├── 11
│   ├── laravel
│   │   ├── alpine
│   │   │   ├── Dockerfile
│   │   │   ├── nginx.conf
│   │   │   ├── setup
│   │   ├── debian
│   │       ├── Dockerfile
│   │       ├── nginx.conf
│   │       ├── setup
│   ├── lumen
│       ├── alpine
│       │   ├── Dockerfile
│       │   ├── nginx.conf
│       │   ├── setup
│       ├── debian
│           ├── Dockerfile
│           ├── nginx.conf
│           ├── setup
├── .github
│   ├── workflows
│       ├── build.yml
```

---

## GitHub Actions Workflow

This repository includes a `build.yml` file for automating the creation and publishing of Docker images to GHCR.

### Workflow Highlights

- **Build Matrix**:
    - Supports both Alpine and Debian environments.
- **Multi-Architecture Support**:
    - Compatible with `linux/amd64`, `linux/arm64`, and `linux/arm/v7` systems.
- **Automatic Tagging**:
    - Automatically assigns tags based on the image version and type.

## Contributing

1. **Fork** this repository.
2. **Create** a branch for your changes.
3. **Submit** a pull request to propose your updates.

---

## License

This project is licensed under the MIT License. For more details, check the LICENSE file.
