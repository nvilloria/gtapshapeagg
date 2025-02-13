.onAttach <- function(libname, pkgname) {

    packageStartupMessage("\n\nWelcome to gtapshapeagg! \n
Run setup_gtapshapeagg() the first time you use this package to compile the tablo programs needed to split the subnational land rents and aggregate the GTAP database with subnational land use. The compiled programs (executables) will reside in the folder gempack of your current working directory, i.e., getwd(). You can also run setup_gtapshapeagg() to check that the needed programs are installed. \n
If you are a reviewer, unzip the GTAP V11c (GTAPV6) database with the provided password by running unzip_gtapdata()---7-zip must be installed and available in your computer's environmental variable PATH. Otherwise, you will need to have to provide your own dataset \n")
    }
