# IBM ILOG CPLEX

This image is made to contain [CPLEX Optimizer](https://www.ibm.com/analytics/data-science/prescriptive-analytics/cplex-optimizer)
suite.

The `Dockerfile` works will any CPLEX version, and is made from `ubuntu:17.10`.

# Content of the image

Once built, the image should contain a working CPLEX installation:

- The installation path, if required, is `/opt/bim/ILOG/CPLEX_Studio`.
- Both python 2 and 3 APIs are installed, together with the required python version.

# Building the image

This image is **not standalone**, you will need:

- An archive containing installer for Java.
  - You can download one freely here:
https://java.com/en/download/.
  - You need to download the `tar.gz` version and put it into the `files`
  subfolder as `jre.tar.gz`.

- A binary installer for CPLEX:
  - You should have a proper CPLEX license for this, and you can download the binary
  installer from IBM website.
  - You need the **linux x86-64** version of the installer. Once you have it, you need
  to put it into the `files` folder as `cplex.linux-x86-64.bin`.
  - The `Dockerfile` should work with any CPLEX version.
