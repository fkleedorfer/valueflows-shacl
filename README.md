# Valueflows-Shacl
 
SHACL shapes for checking a valueflows model and SHACL-AF Rules for calculating effects of events.

## Running

1. Install shacl as per https://github.com/TopQuadrant/shacl/ (=download and unpack zip, remember path)
2. Set the path to the shacl scripts in `scripts/settings.sh`
Note: The scripts are developed on Windows/Git Bash where the shacl scripts need windows-style paths as they are set in the `scripts/settings.sh`file. On unix/mac, you will need unix-style paths.

Use the `scripts/shacl-single.sh` script to get started.


## Structure

**`rdf/valueflows-shapes.ttl`** 

The SHACL code being developed. I don't trust `owl:imports` yet, so it's all in one file.

**`rdf/input`**: 

Contains unit tests. Those with `-fail` in the name are expected to fail, those with `-ok` in the name are expected to conform.

**`rdf/expected`**:

Contains the expected output, three files per file in `rdf/input`: 
* `[input-filename]-val.ttl`: contains the validation output
* `[input-filename]-inf.ttl`: contains the inferences made based on the input
* `[input-filename]-inf-val.ttl`: contains the validation output of the input file plus the inferences
