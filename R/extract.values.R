#' Extract Values from a GEMPACK Text Mapping File
#'
#' This function extracts values from a text file based on a given start pattern.
#' It reads lines from the file until it encounters an empty line, extracting
#' the first word from each non-empty, non-comment line.
#'
#' @param lines Is the aggregation template read by
#'     \code{\link[gtapshapeagg]{maptext2har}} into R using
#'     readLines(mapfile).
#' @param start_pattern A character string specifying the pattern to
#'     identify the start of the section to extract values from.
#'
#' @return A character vector containing the extracted values. Returns NULL if
#'   the start pattern is not found.
#'
#' @details
#' The function performs the following steps:
#' 1. Locates the line containing the start pattern.
#' 2. Extracts all lines until it encounters an empty line.
#' 3. For each extracted line, it keeps only the first word.
#' 4. Removes empty lines and lines starting with '!' (comments).
#'
#' @note This function assumes that the 'lines' variable containing the file
#'   content is available in the environment where the function is called.
#'
#' @examples
#' # Assuming 'lines' contains the file content
#' values <- extract.values("header \"H2\"")
#'@export
extract.values <- function(lines, start_pattern) {
  # Find the start of the section
  start <- which(grepl(start_pattern, lines))
  if (length(start) == 0) return(NULL)

  # Extract lines until the next empty line
  section <- character()
  for (i in (start + 1):length(lines)) {
    if (trimws(lines[i]) == "") break
    section <- c(section, lines[i])
  }

  # Extract the first word from each line, ignoring comments and blank lines
  values <- gsub("^\\s*(\\S+).*$", "\\1", section)
  values <- values[values != "" & !grepl("^!", values)] # Remove empty lines and comments
  return(values)
}
