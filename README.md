# qclsip

The Quantum Cascade Laser Stock Image Project.

Overview
--------------------

This project aims to provide sketches and figures related to quantum cascade
lasers (QCLs) under the Creative Commons CC-BY 4.0 License. The figures can
be created as LaTeX/TikZ source code or SVG and are compiled to PDF, EPS
and PNG files.

Build instructions
--------------------

The binaries are compiled by executing

    $ make

in the project directory. Inkscape, poppler-utils, and a LaTeX installation
are required. A compressed archive with all figures can be generated with

    $ make install

Contribute
--------------------

- Create a new directory in src/ or use an existing directory.

- Copy templates/standalone.tex into the directory, rename and modify it
  accordingly.

- AND/OR create a SVG file in the directory (using a vector graphics editor
  such as Inkscape).

- Compile, test and share via git.
