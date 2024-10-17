# sshrc-insight: A LaTeX class for SSHRC Insight Grant proposals

## Overview

The `sshrc-insight` LaTeX class facilitates the preparation of funding
proposals for the Insight Grants program of Canada's Social Sciences
and Humanities Research Council (SSHRC).  It has the following key
features:

* Formats the proposal according to the SSHRC's specifications.

* Allows parts of the proposal to be compiled into separate PDFs to
attach to the appropriate places in the online application form.

* Alternatively, allows the proposal to be compiled into a single PDF
in order to facilitate the writing and pre-submission reviewing
process.

* Ensures that citation numbering remains consistent regardless
whether the proposal is compiled as separate PDFs or a single PDF.

* Provides character counts for long-answer form fields.

* Supports preparation of proposals in either English or French.

* Compatible with `pdflatex`, `xelatex`, and `lualatex`.

## Building and installing

To build the class, run the file `sshrc-insight.ins` through `latex`
or `pdflatex` and then copy the resulting `.cls` file into a directory
searched by LaTeX.

To generate the documentation, run the file `sshrc-insight.dtx`
through `pdflatex`.

The `.tex` files built along with the class are the template proposal.
Copy them to a separate directory and edit them as desired.  
generate the proposal as a single PDF, run the file `proposal.tex`
though `pdflatex` (or `xelatex` or `lualatex`) and `biber` until all
the references are resolved.  To generate separate PDFs for the
various parts of the proposal, use the same procedure on the other
`.tex` files.  Note that `proposal.tex` must be compiled before the
other files that use citation commands.

## Development

`sshrc-insight` was written and is maintained by [Tristan
Miller](https://logological.org/).

For now, the source code is hosted on GitHub at
[https://github.com/logological/sshrc-insight](https://github.com/logological/sshrc-insight).
There you will also find an issue tracker for reporting bugs and
feature requests.

## Licence

The `sshrc-insight` class is distributed under the conditions of the
[LaTeX Project Public
License](https://www.latex-project.org/lppl.txt), either version 1.3c
of this license or (at your option) any later version.
