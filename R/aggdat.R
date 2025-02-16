#' Aggregate GTAP Data
#'
#' This function aggregates the GTAP data base (including subnational
#' boundaries) as instructed in the provided mapping.  It creates
#' necessary configuration files, runs the aggregation check, and
#' executes the data aggregation process.
#'
#' @param mapfile Gempack text file with aggregation template,
#'     generated by gtapshape.
#' @param setfile HAR file with GTAP sets, including the subnational
#'     bounds, also generated by gtapshape.
#' @param datfile HAR file with GTAP data, including the land use dat
#'     by subnational bounds, also generated by gtapshape.
#' @param dir Character string. Directory where output files will be
#'     saved.
#'
#' @details
#' The function performs the following steps:
#' 1. Runs `aggcheck()` to create gmap.har and check consistency between input sets and data.
#' 2. Creates the output directory if it doesn't exist.
#' 3. Generates an 'aggdat.cmf' configuration file with input and output file specifications.
#' 4. Executes the 'aggdat' system command to perform the actual data aggregation.
#'
#' @return This function does not return a value. It creates aggregated data files in the specified directory.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' aggdat("path/to/mapfile", "path/to/setfile", "path/to/datfile", "output_directory")
#' }
#'
#' @seealso
#' \code{\link{aggcheck}}
#'
aggdat <- function(mapfile,
                   setfile,
                   datfile,
                   dir ## where to put the data
                   ){
    ## aggcheck() reads aggregation mappings in the aggregation input file and
    ## creates gmap.har:, and checks the consistency between the sets
    ## in the input file and those in the data to be aggregated:
    aggcheck(mapfile, setfile)
    ## Aggregates the data to the sectors, regions and endowments in
    ## gmap.har:
    if(file.exists(dir)==FALSE){
        dir.create(dir)}
    write_cmf(
        cmf_filename="aggdat.cmf",
        input_files = list(DDATA=datfile,
                           DSETS=setfile,
                           ASETS="gmap.har"),
        output_files = list(ADATA =
                                file.path(getwd(),dir,"basedata.har"),
                            GSETS =
                                file.path(getwd(),dir,"sets.har")
                            ),
        out_dir = getwd()
    )
    run_gtap_program(program="./gempack/aggdat", cmf="aggdat.cmf")
}
