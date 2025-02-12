
# gtapshapeagg

<!-- README.md is generated from README.Rmd. Please edit that file -->

## Overview

`gtapshapeagg` is an R package that implements
[**FlexAgg2**]((https://www.gtap.agecon.purdue.edu/databases/flexagg2.asp)),
to aggregate the regions and countries of the GTAP database using a
standard aggregation template written as a GEMPACK text file.

`gtapshapeagg` provides additional functionality to split the regional
land rents in the standard GTAP database to subnational boundaries, such
as Agroecological Zones. The package is designed to work seamlessly with
files produced by the `gtapshapeagg` package.

`gtapshapeagg` takes advantage of R’s scripting capabilities to organize
the execution of several GEMPACK programs. The source code of these
programs is provided with `gtapshapeagg`. To make them operational they
must be compiled by running `setup_gtapshapeagg()`.
`setup_gtapshapeagg()` creates fortran executable files of the needed
gempack programs and places them in the subfolder `gempack` in the
current working directory \[i.e., `getwd()`\]. The workflow assumes that
the computer is already setup to [compile source-code GEPMPACK
programs](https://www.copsmodels.com/gpinstall.pdf) and the user is
responsible for securing the necessary sofware licences.

## Installation

You can install the development version of `gtapshapeagg` directly from
GitHub using the following commands:

``` r
# Install devtools if you don't already have it
install.packages("devtools")

# Install gtapshapeagg from GitHub
devtools::install_github("nvilloria/gtapshapeagg")
```

## Usage

Here’s a basic example of how to use `gtapshapeagg`:

``` r
# Load the package
library(gtapshapeagg)

# Example 1: Using FlexAgg functionality

# Example 2: Splitting national land rents into subnational boundaries
splitlr(
    landdat = "./from-gtapshape/gtaplulc.har",## From gtapshape
    landsets = "./from-gtapshape/gtaplulc-sets.har",  ## From gtapshape
    stdgtapsets="./GTAPv11c/gsdgset11cMV6.har", # <- Standard GTAP database
    stdgtapdata="./GTAPv11c/gsdgdat11cMV6.har" , # <- Standard GTAP database
    dir= "AEZ18v11c" # <- Directory where to output landgtapsets and landgtapdat
)

m <- system.file("mappings", "my_agg_AEZ18.txt", package = "gtapshapeagg")

createdat(mapfile = m, ## Aggregation mapping
          setfile = "./AEZ18v11c/landgtapsets.har", ## from splitlr()
          datfile = "./AEZ18v11c/landgtapdat.har", ## from splitlr()
          stdprm =  "./GTAPv11c/gsdgpar11cMV6.har", # Standard GTAP parameters
          dir = "My_18AEZagg" ## Directory with aggregated data
          )
```

## License

This package is licensed under the MIT License. See the `LICENSE.md`
file for details.

------------------------------------------------------------------------
