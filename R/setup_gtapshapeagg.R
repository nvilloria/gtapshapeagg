#' Setup gtapshapeagg
#'@export
setup_gtapshapeagg <- function() {
    packageStartupMessage("\n\nWelcome to gtapshapeagg!\n")

    cat("\n\nChecking that the GEMPACK programs used by gtapshapeagg are properly installed...\n")

    mf <- check_exe_files()

    ## cat("Check that the needed GEMPACK programs are installed.\n")

    ## mf <- check_exe_files()

    if (length(mf$missing)>0) {
        u <- readline(
            prompt = "\n\nDo you want to compile them? (yes/no): ")
        if (tolower(u) == "yes") {
            cat("C\n\n opying and compiling tablo files...\n")
            copy_missing_tab_files(missing_exe_files= mf$missing)
            compile_tab_files()
        }else{
            cat("\n\nSkipping compilation of missing GEMPACK programs.\n")
        return(invisible(NULL))
        }
    }else{
        cat("These are all the GEMPACK programs required by gtapshape.\n")
        }
}
