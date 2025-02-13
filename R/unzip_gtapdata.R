#' Unzip GTAP Data File
#'
#' This function unzips a password-protected GTAP data file from the gtapshapeagg package.
#' It prompts the user for a password and uses 7-Zip to extract the contents.
#'
#' @details
#' The function locates the zip file 'gsdgdat11cMV6.zip' in the 'GTAPv11c' directory
#' of the gtapshapeagg package. It then prompts the user for a password and uses
#' 7-Zip to extract the contents to the same directory.
#'
#' @note
#' This function requires 7-Zip to be installed and accessible from the command line.
#'
#' @return
#' This function does not return a value. It unzips the file and prints a success
#' message if the operation is successful. If the unzip operation fails, it stops
#' with an error message.
#'
#' @examples
#' \dontrun{
#' unzip_gtapdata()
#' }
#'
#' @export
unzip_gtapdata <- function() {
    zip_file <- system.file("GTAPv11c", "gsdgdat11cMV6.zip", package = "gtapshapeagg")
    output_dir <- system.file("GTAPv11c", package = "gtapshapeagg")

    ## Prompt the user for the password
    cat("Enter password: ")
    password <- readLines(con = stdin(), n = 1)

    ## Construct the system command to unzip using 7-Zip
    cmd <- sprintf('7z x -p%s "%s" -o"%s" -aoa', password, zip_file, output_dir)

    ## Run the command and capture output
    result <- system(cmd, intern = TRUE)

    ## Check if the unzip operation was successful
    if (any(grepl("Everything is Ok", result))) {
        message("File successfully unzipped!")
    } else {
        stop("Failed to unzip. Check your password or file.")
    }
}
