#' Generate GTAP View Files
#'
#' This function creates configuration files and executes the 'gtapview' command
#' to generate view files for GTAP (Global Trade Analysis Project) data.
#'
#' @param dir Character string. Directory containing input files and where output files will be saved.
#'
#' @details
#' The function performs the following steps:
#' 1. Creates a 'gtapview.cmf' configuration file specifying input and output files.
#' 2. Executes the 'gtapview' system command to generate view files.
#'
#' Input files (expected in the specified directory):
#' - basedata.har: Aggregated GTAP data
#' - sets.har: Aggregated GTAP sets
#' - default.prm: Aggregated data parameters
#'
#' Output files (created in the specified directory):
#' - baseview.har: File with headers for viewing
#' - baserate.har: File with tax rate headers for viewing
#'
#' @return This function does not return a value. It creates view files in the specified directory.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' gtapview("path/to/data_directory")
#' }
#'
gtapview <- function(dir){
        write_cmf(
        cmf_filename= "gtapview.cmf",
        input_files = list(
            GTAPDATA= file.path( getwd(), dir, "basedata.har"),
            GTAPSETS= file.path( getwd(), dir, "sets.har"),
            GTAPPARM= file.path( getwd(), dir, "default.prm")
        ),
        output_files = list(
            GTAPVIEW = file.path( getwd(), dir, "baseview.har"),
            TAXRATES = file.path( getwd(), dir, "baserate.har")
        ),
        out_dir = getwd()
    )
        run_gtap_program(program="./gempack/gtapview", cmf="gtapview.cmf")
}

