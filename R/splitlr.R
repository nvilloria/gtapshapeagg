#' Split Land Rent and Generate GTAP Land Use Data
#'
#' This function creates a GEMPACK command file (CMF) and executes a GEMPACK program
#' to split land rent and generate GTAP land use data.
#'
#' @param landdat Character string. Path to the land use and cover
#'     data file created by `gtapshapeagg`.
#' @param landsets Character string. Path to the sets file for land
#'     use data created by `gtapshapeagg`.
#' @param stdgtapsets Character string. Path to the sets and mapping
#'     data file for Standard GTAP v.11c.
#' @param stdgtapdata Character string. Path to the Standard GTAP
#'     v.11c data file.
#' @param dir Character string. Directory name for output files.
#'
#' @details
#' This function performs the following steps:
#' 1. Creates the output directory if it doesn't exist.
#' 2. Generates a GEMPACK command file (splitlr.cmf) with file paths and settings.
#' 3. Executes the GEMPACK program '03_rentcalc' using the generated CMF file.
#' 4. Moves the CMF file to the output directory.
#'
#' @return No return value. Files are written to the specified directory.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' splitlr("landdata.har", "landsets.har", "gtapsets.har", "basedata.har", "forestdata.har", "output_dir")
#' }
#'
splitlr  <- function(landdat = NULL,
                      landsets = NULL,
                      stdgtapsets,
                      stdgtapdata,
                     dir){
    ## Check if stdgtapdata file exists
    if (!file.exists(stdgtapdata)) {
        message("The GTAP database file was not found. If you want to use the GTAP Database V11c (2017, GTAP V6) distributed with this package, you need to run unzip_gtapdata(). This function will prompt you for a password. Otherwise, you need to provide your own data.")
        return(invisible(NULL))  # Exit the function early
    }
    if(file.exists(dir)==FALSE){
        dir.create(dir)}
    write_cmf(cmf_filename = "splitlr2.cmf",
          input_files = list(
              gtaplulc= landdat, #Land use and cover data
              gtapsets = landsets, # Sets for land use data, gtaplulc (provided in package inst/har)
              basesets = stdgtapsets, #Sets and mapping data for Standard GTAP v.11c
              basedata = stdgtapdata
          ),
          output_files = list(
              gtaplulcaez = paste(".\\",dir,"\\landgtapdat.har", sep=""), # gtap land use land cover data: full data
              gtaplulcset = paste(" .\\",dir,"\\landgtapsets.har", sep=""), # gtap land use land cover data: set data
             checks = paste(".\\",dir,"\\checks.har",sep="") #checks for reporting purposes
          ),
          out_dir=getwd()
          )
    run_gtap_program(program="./gempack/rentcalc", cmf="splitlr2.cmf")
    file.rename(from="splitlr2.cmf", to=paste("./",dir,"/splitlr2.cmf",sep=""))
    }
