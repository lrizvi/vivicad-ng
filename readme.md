# vivicad-ng
*\~A Jupyter environment for microsystem design and multiphysics simulation\~*

This is a rewrite of the author's prior attempts at making devices entirely in Python.
The desired goal is a usable toolset capable of design, modeling, and FEA tasks
using only open-source components.

## Requirements
* An installation of Podman or Docker capable of running Linux containers.

## Setup
1. Build the container with Podman:
`podman build --format docker -t vivicad-ng <repo dir>`
Or if using Docker:
`docker build -t vivicad-ng <repo dir>`

<a name="run"></a>
2. `cd` to the desired run location, such as another project.
Run the container, specifying a port and a working directory.
Here, port 8888 and the current directory are selected:
`podman run -d -p 8888:8888 -v ${PWD}:/mnt -t vivicad-ng`

3. Access the container's JupyterLab server:
`xdg-open http://localhost:8888`
(Or just open the URL in your browser!)
*In Windows, replace `xdg-open` with `start`. In OSX, replace it with `open`.*

4. Note that authentication for Jupyter is disabled for developer convenience.
Do not expose the server to the Internet!!

## FAQ / Notes

**Q: How do I kill a running container?**

**A:** List and find the name of the container with `podman ps`.
Then, run `podman kill <container name>`.

**Q: I am getting errors regarding disk space. How do I make more space?**

**A:** Delete old containers. To delete everything: `podman rm -a && podman rmi -a`

**Q: How do I run other notebooks with this container?**

**A:** Change directory to the external notebook location then start the container.
`${PWD}:/mnt` in [running the container](#run) takes the current directory
and mounts it in the container at `/mnt`.
Alternatively, `${PWD}` can be replaced with an absolute path
or appended with a subdirectory, e.g. `${PWD}/notebooks`.

**Q: How do I fix Permission Denied errors when accessing files in a mounted directory?**

**A:** Run `sudo chmod 777 <directory path>` on the mounted directory
to allow the container to modify the contents.

**Q: How do I add dependencies to this project?**

**A:** There are two places to add dependencies.
Native programs, dependencies NOT installable by pip / Poetry, or anything not used by the vivicad codebase
should be installed by Micromamba and thus written to the `environment.yaml` file.
Dependencies in use by the codebase and installable by pip / Poetry should be added to `pyproject.toml` file
with `poetry add <package name>`.

**Q: How is this software structured?**

**A:** This software consists of a Python package and a container
providing a JupyterLab interface to the package
and third-party software meant to be used along with the package.
The package is for writing an API to be used within Jupyter
or by other software.
The container provides a portable and convenient environment
for an end-user to interact with the package
and included third-party software.

**Q: How is the container built?**

**A:** The container is defined by the `Containerfile` file.
This file is configured to install necessary runtime software
within the container.
Included software is managed by [Micromamba](https://github.com/mamba-org/mamba#micromamba), a Conda-compatible package manager,
and the container is built on top of [micromamba-docker](https://github.com/mamba-org/micromamba-docker).
Conda packages are declared in `environment.yaml`.
As a last step, the vivicad-ng Python package is installed within the package.
Running the package will start a JupyterLab server at port `8888`.
