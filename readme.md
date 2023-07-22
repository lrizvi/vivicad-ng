# vivicad-ng
*\~A Jupyter environment for microsystem design and multiphysics simulation\~*

This is a rewrite of the author's prior attempts at making devices entirely in Python.
The ultimate goal is a practical toolset capable of CAD, modeling, and simulation tasks
using only open-source components.

## Setup
1. Build the container with Podman:
`podman build --format docker -t vivicad-ng <repo dir>`
Or with Docker:
`docker build -t vivicad-ng <repo dir>`

2. Run the container, specifying a port and a working directory.
Here, port 8888 and the current directory are selected:
`podman run -d -p 8888:8888 -v ${PWD}:/mnt -t vivicad-ng`

3. Access the container's JupyterLab server:
`xdg-open http://localhost:8888`
(Or just open the URL in your browser!)
*In Windows, replace `xdg-open` with `start`. In OSX, replace it with `open`.*

4. Note that authentication for Jupyter is disabled for developer convenience.
Do not expose the server to the Internet!!
