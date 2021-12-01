To generate an SBOM for your Dart package ensure you have a suitable sbom.yaml in the top level directory of the package,
examples of such can be found in the yaml directory in the examples folder.

To generate the SBOM open a console window and simply type :-
```
sbom
```
You will be informed of the progress of the generation through informational(white), warning(yellow) and error(red) messages output to the console.

If an error is encountered generation will stop, warnings do not stop the generation of the SBOM itself but may result in a SBOM that will not pass validation.
The warning messages will inform you of the nature of the warning. On completion an sbom file will be present, this will be of the type
selected in the sbom.yaml files, for example sbom.spdx.

The generator allows a number of command line parameters to be supplied if needed, type :-
```
sbom --help
```

to see these. This will allow you to set the top level package directory, verbosity levels etc.
