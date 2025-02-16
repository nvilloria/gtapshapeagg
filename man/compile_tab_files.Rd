% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compile_tab_files.R
\name{compile_tab_files}
\alias{compile_tab_files}
\title{Compile TABLO Files to Executable Files}
\usage{
compile_tab_files(dest_folder = "gempack")
}
\arguments{
\item{dest_folder}{Character string. The directory containing .tab files to compile. Default is "gempack".}
}
\value{
This function does not return a value. It compiles .tab files into executables in the specified directory.
}
\description{
This function compiles .tab files in a specified directory into executable files
using the TABLO and LTG commands from GEMPACK.
}
\details{
The function performs the following steps:
\enumerate{
\item Changes the working directory to the specified \code{dest_folder}.
\item Identifies all .tab files in the directory.
\item For each .tab file:
a. Runs the TABLO command with the -wfp option.
b. Runs the LTG command to create an executable file.
\item Returns to the original working directory.
}
}
\note{
This function requires GEMPACK to be installed and accessible from the command line.
It uses system commands, so it may not work on all operating systems.
}
\examples{
\dontrun{
compile_tab_files("path/to/gempack/folder")
}

}
