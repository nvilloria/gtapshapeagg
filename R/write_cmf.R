#' Write a Command File (CMF) for GEMPACK
#'
#' This function creates a Command File (CMF) used in GEMPACK operations, specifying input and output files.
#'
#' @param cmf_filename Character string. The name of the CMF file to be created.
#' @param input_files Named list. Names and paths of input files to be included in the CMF.
#' @param output_files Named list. Names and paths of output files to be included in the CMF.
#' @param out_dir Character string. Directory where the CMF file will be saved. If NULL, current working directory is used.
#' @param workdir Character string. Working directory for file paths. Default is the current working directory.
#'
#' @return Character string. The full path to the created CMF file.
#'
#' @details
#' The function creates a CMF file with the following structure:
#' 1. A header for input files.
#' 2. List of input files with their paths.
#' 3. A header for output files.
#' 4. List of output files with their paths.
#'
#' The function ensures that the output directory exists, creating it if necessary.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' input_files <- list(GTAPSETS = "sets.har", GTAPDATA = "basedata.har")
#' output_files <- list(GTAPVIEW = "baseview.har")
#' cmf_path <- write_cmf("example.cmf", input_files, output_files, "path/to/output")
#' print(cmf_path)
#' }
#'
write_cmf <- function(cmf_filename,
                      input_files,
                      output_files,
                      out_dir,
                      workdir=getwd()){
 # Set default output directory if not provided
  if (is.null(out_dir)) {
      out_dir <- getwd()
  }

  # Ensure output directory exists
  dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

  # Create CMF file path
  cmffile.location <- file.path(out_dir, cmf_filename)

  # Prepare CMF content
  cmf_content <- c("!Input files:!")

  # Add input files
  for (name in names(input_files)) {
    cmf_content <- c(cmf_content,
                     paste0("FILE ", name, "=", input_files[[name]], ";"))
  }

      # Add separator for output files
  cmf_content <- c(cmf_content, "!Output files:!")

  # Add output files
  for (name in names(output_files)) {
    cmf_content <- c(cmf_content,
                     paste0("FILE ", name, "=", output_files[[name]], ";"))
  }

  # Write CMF file
  writeLines(cmf_content, cmffile.location)

  # Return the path of the created CMF file
  return(cmffile.location)
    }
