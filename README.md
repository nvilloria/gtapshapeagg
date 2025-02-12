
# gtapshapeagg

<!-- README.md is generated from README.Rmd. Please edit that file -->

## Overview

`gtapshapeagg` is an R package that implements **FlexAgg**, a data
aggregation tool, and provides additional functionality to split
national land rents into subnational boundaries. The package is designed
to work seamlessly with files produced by the `gtapshapeagg` package,
making it an essential tool for users working with GTAP-related data.

Key features include: - **FlexAgg implementation**: A flexible data
aggregation system. - **Subnational rent allocation**: A module for
distributing national land rents across subnational boundaries.

## Installation

You can install the development version of `gtapshapeagg` directly from
GitHub using the following commands:

``` r
# Install devtools if you don't already have it
install.packages("devtools")

# Install gtapshapeagg from GitHub
devtools::install_github("yourusername/gtapshapeagg")
```

Replace `"yourusername"` with your actual GitHub username.

## Usage

Here’s a basic example of how to use `gtapshapeagg`:

``` r
# Load the package
library(gtapshapeagg)

# Example 1: Using FlexAgg functionality
result <- flexagg_function(data, parameters)
print(result)

# Example 2: Splitting national land rents into subnational boundaries
subnational_rents <- split_land_rents(national_data, boundary_file)
print(subnational_rents)
```

Replace `data`, `parameters`, `national_data`, and `boundary_file` with
your actual datasets and input files.

## Dependencies

The package depends on the following R packages: - `dplyr` - `sf` -
Other dependencies will be automatically installed during installation.

## Contributing

Contributions are welcome! If you encounter any issues or have
suggestions for improvement, please open an issue or submit a pull
request on [GitHub](https://github.com/yourusername/gtapshapeagg).

## License

This package is licensed under the MIT License. See the `LICENSE.md`
file for details.

------------------------------------------------------------------------
