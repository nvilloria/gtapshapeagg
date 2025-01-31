#' Compile TABLO Files to Executable Files
#'
#' This function compiles .tab files in a specified directory into executable files
#' using the TABLO and LTG commands from GEMPACK.
#'
#' @param dest_folder Character string. The directory containing .tab files to compile. Default is "gempack".
#'
#' @details
#' The function performs the following steps:
#' 1. Changes the working directory to the specified `dest_folder`.
#' 2. Identifies all .tab files in the directory.
#' 3. For each .tab file:
#'    a. Runs the TABLO command with the -wfp option.
#'    b. Runs the LTG command to create an executable file.
#' 4. Returns to the original working directory.
#'
#' @note
#' This function requires GEMPACK to be installed and accessible from the command line.
#' It uses system commands, so it may not work on all operating systems.
#'
#' @return This function does not return a value. It compiles .tab files into executables in the specified directory.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' compile_tab_files("path/to/gempack/folder")
#' }
#'
compile_tab_files <- function(dest_folder="gempack") {
  # Store the current working directory
  original_dir <- getwd()

  # Change to the dest_folder
  setwd(file.path(original_dir, dest_folder))

  # Get a list of all .tab files in the dest_folder
  tab_files <- list.files(pattern = "\\.tab$")

  # Apply the system command to each .tab file
  for (file in tab_files) {
      system(paste("tablo -wfp", file))
      # Strip the .tab extension from the file name
    file_without_extension <- tools::file_path_sans_ext(file)
      system(
          paste0("cmd /c call ltg ",file_without_extension)
      )
  }
  # Return to the original directory
  setwd(original_dir)
}
