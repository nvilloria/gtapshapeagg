#' Aggregate Parameters for GTAP Data
#'
#' This function aggregates parameters for GTAP (Global Trade Analysis Project) data.
#' It performs consistency checks, creates necessary configuration files, and executes
#' the parameter aggregation process.
#'
#' @param mapfile Character string. Path to the mapping file for aggregation.
#' @param setfile Character string. Path to the set file for disaggregated GTAP data.
#' @param datfile Character string. Path to the disaggregated GTAP data file.
#' @param stdprm Character string. Path to the standard parameters file.
#' @param dir Character string. Directory where aggregated output files will be saved.
#'
#' @details
#' The function performs the following steps:
#' 1. Runs `aggcheck()` to create gmap.har and check consistency between input sets and data.
#' 2. Creates the output directory if it doesn't exist.
#' 3. Generates an 'aggpar.cmf' configuration file with input and output file specifications.
#' 4. Executes the 'aggpar' system command to perform the actual parameter aggregation.
#'
#' Input files:
#' - datfile: Disaggregated data in GTAP notation
#' - stdprm: Disaggregated parameters
#' - gmap.har: User-supplied parameters from input file (created by aggcheck)
#' - setfile: Set specification for disaggregate data
#'
#' Output files:
#' - aggpar.har: Aggregated CDE, CES, and CET elasticities (saved in the specified directory)
#'
#' @return This function does not return a value. It creates aggregated parameter files in the specified directory.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' aggpar("path/to/mapfile", "path/to/setfile", "path/to/datfile",
#'        "path/to/stdprm", "output_directory")
#' }
#'
#' @seealso
#' \code{\link{aggcheck}}
#'
aggpar <- function(mapfile,
                   setfile,
                   datfile,
                   stdprm,
                   dir){
    ## Reads aggregation mappings in the aggregation input file and
    ## creates gmap.har:, and checks the consistency between the sets
    ## in the input file and those in the data to be aggregated:
    aggcheck(mapfile,setfile)
    if(file.exists(dir)==FALSE){
        dir.create(dir)}
    write_cmf(
        cmf_filename= "aggpar.cmf",
        input_files = list(
            DDATA = datfile,
            DPARAM = stdprm,
            EPARAM ="gmap.har",
            DSETS = setfile,
            ASETS="gmap.har"),
        output_files = list(
            PARAM = file.path( getwd(), dir, "aggpar.har")
        ),
        out_dir = getwd()
    )
    run_gtap_program(program="./gempack/aggpar", cmf="aggpar.cmf")
    }

