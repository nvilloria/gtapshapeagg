#' Run a GEMPACK Program
#'
#' This function executes a GEMPACK program using the system command.
#'
#' @param program The name of the GEMPACK program to run (e.g., "tablo").  This should be the full path of the executable or be in the system's PATH.
#' @param cmf The path to the command file (.cmf) that controls the GEMPACK program.
#'
#' @return Depends on the program, but the message should be that the
#'     program completed without error.
#'
#' @export
run_gtap_program <- function(program, cmf){
  system(paste(program, "-cmf", cmf),ignore.stdout=FALSE)
}
