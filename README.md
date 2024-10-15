rdkit-tar-bundles
---

Contains the docker commands needed to compile the latest RDKit for Ubuntu. Once built,
the image will contain a zipped tar file with the compiled RDKit binaries. At the moment,
out builds default to Ubuntu 22:04.

Instructions for Compiling
---
* Create a new directory: `mkdir rdkit_binaries`
* Build the image: `docker build --tag rdkit_ubuntu_image .`
* Start a container: `docker run -it --rm -v $PWD/rdkit_binaries:/rdkit_binaries rdkit_ubuntu_image`
* Within the container, move the tar ball to the mounted directory: `cp /tmp/rdkit-Release_2024_09_1_ubuntu_22_04.tar.gz /rdkit_binaries`
* Exit the container

Instructions for Installing on Debian
---
* `tar xf rdkit-Release_2024_09_1_ubuntu_22_04.tar.gz`
* `cp -r rdkit-Release_2024_09_1/Code /usr/local/include/rdkit`
* `cp rdkit-Release_2024_09_1/build/lib/* /usr/lib`

Notes
---
* Update the RDKIT_VERSION variable in the docker file as needed
* Similarly, update the version used in the installation instructions above as needed