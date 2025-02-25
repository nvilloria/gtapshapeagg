
# gtapshapeagg

<!-- README.md is generated from README.Rmd. Please edit that file -->

## Overview

`gtapshapeagg` takes advantage of R’s scripting capabilities to organize
the execution of several GEMPACK programs that (1) split the regional
land rents in the standard GTAP database to subnational boundaries, such
as Agroecological Zones, and (2) aggregate the regions and countries of
the GTAP database with subnational land rents using a standard
aggregation template written as a GEMPACK text file. The package is
designed to work seamlessly with files produced by the `gtapshapeagg`
package and should be considered its companion.

`gtapshapeagg` relies on modified versions of the programs of
[**FlexAgg2**]((https://www.gtap.agecon.purdue.edu/databases/flexagg2.asp)),
to aggregate the regions and countries of the standard GTAP database.
The land rents are dissagregated using a program graciously provided by
the GTAP center.

The source code of these programs is provided with `gtapshapeagg`, in
the folder `inst/tablo`. To make them operational they must be compiled
by running `setup_gtapshapeagg()`. `setup_gtapshapeagg()` creates
fortran executable files of the needed gempack programs and places them
in the subfolder `gempack` in the current working directory \[i.e.,
`getwd()`\]. The workflow assumes that the computer is already setup to
[compile source-code GEPMPACK
programs](https://www.copsmodels.com/gpinstall.pdf) and that the user is
has secured the necessary sofware licences.

## Installation

You can install the development version of `gtapshapeagg` directly from
GitHub using the following commands:

``` r
## Install devtools if you don't already have it
install.packages("devtools")

## Install gtapshapeagg from GitHub
devtools::install_github("nvilloria/gtapshapeagg", build_vignettes = TRUE)

## Setup gtapshapeagg (compile tablo programs, if they are not
## compiled--they will be placed in the folder `gempack` in the
## current directory [i.e., getwd()]):
setup_gtapshapeagg()

## For testers/reviewers, unzip `gsdgdat11cMV6.har` (password protected):
unzip_gtapdata()
```

## Usage

The package is designed to work seamlessly with two files. One is a file
with eight headers that contain land cover and land use data by
subnational boundary and region. The other file has the sets (regions,
products, and subnational boundaries.) These files are created by
`gtapshape`. In addition, the program requires a fully disagregated
standard gtap database with its standard sets. If a regional or sectoral
aggregation is required, the parameter file of the standard GTAP
database need to be provided.

The required files can be in any directory specified by the user. In
order to make `gtapshapeagg` self-contained, we have prepackaged data
and set files for 18 AEZs as well as the standard GTAP database V11c,
GTAP Model V6 including parameters, and sets. The GTAP database is
password protected and we will not share the password, so please do not
ask. For the programs to run, licensed users should specify the location
(path file) of their har file.

Here’s a basic example of how to use `gtapshapeagg`:

``` r
# Load the package
library(gtapshapeagg)

# Example: Splitting national land rents into subnational boundaries
splitlr(
    # This is the data file with LULC by subantional boundaries,
    # regions and products, created by gtapshape:
    landdat = system.file("from-gtapshape", "gtaplulc-aez18.har",
                          package = "gtapshapeagg"),
    ## These are the LULC sets from gtapshape
    landsets = system.file("from-gtapshape", "gtaplulc-aez18-sets.har",
                           package = "gtapshapeagg"),
    # Standard GTAP sets
    stdgtapsets = system.file("GTAPv11c", "gsdgset11cMV6.har", package = "gtapshapeagg"), 
    # Standard GTAP database
    stdgtapdata = system.file("GTAPv11c", "gsdgdat11cMV6.har", package = "gtapshapeagg"),
    # Directory where to output landgtapsets and landgtapdat
    dir= "AEZ18v11c"
)

g <- createdat(
    mapfile = system.file("mappings", "my_agg_AEZ18.txt", package = "gtapshapeagg"),
    setfile = "./AEZ18v11c/landgtapsets.har",
    datfile = "./AEZ18v11c/landgtapdat.har",
    ## Standard GTAP parameters
    stdprm =  system.file("GTAPv11c", "gsdgpar11cMV6.har", package = "gtapshapeagg"),
    ## Directory with aggregated data
    dir = "My_18AEZagg" 
)
```

The arguments `landdat`, `landset` and `mapfile` read the respective
outputs created from `gtapshape`.

## License

This package is licensed under the MIT License. See the `LICENSE.md`
file for details.

------------------------------------------------------------------------
