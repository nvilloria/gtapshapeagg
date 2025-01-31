#' Convert GTAP Aggregation Template to HAR File
#'
#' This function reads a GTAP aggregation template file and converts it into a HAR (Header Array) file.
#'
#' @param mapfile An aggregation template for the GTAP database.
#'
#' @return This function does not return a value. It writes the extracted data to a HAR file named 'test.har'.
#'
#' @details
#' The function performs the following steps:
#' 1. Extracts various sections from the GTAP aggregation template using the extract.values function.
#' 2. Creates a structured list (aggregation) containing the extracted data.
#' 3. Uses the HARr package to write the structured data to a HAR file.
#'
#' @note
#' - This function requires the HARr package to be installed.
#' - The extract.values function should be defined elsewhere in the package.
#' - The output HAR file is always named 'test.har' and is written to the current working directory.
#'
#' @examples
#' \dontrun{
#' maptext2har("path/to/gtap_aggregation_template.txt")
#' }
#'
#' @importFrom HARr write_har
#'
#' @export
maptext2har <- function(mapfile){
    lines <- readLines(mapfile)
    aggregation <- list(
        H2 = structure(
            extract.values(lines,"header \"H2\""),
            description = "Set TRAD_COMM traded commodities"),
        DCOM = structure(
            extract.values(lines,"header \"DCOM\""),
            description = "Sectoral aggregation mapping"),
        H1 = structure(
            extract.values(lines,"header \"H1\""),
            description = "Set REG regions"),
        DREG = structure(
            extract.values(lines,"header \"DREG\""),
            description = "Regional aggregation mapping"),
        H6 = structure(
            extract.values(lines,"header \"H6\""),
            description = "AEND Aggregate endowment"),
        AMEN = structure(
            extract.values(lines,"header \"AMEN\""),
            description = "AMEN Aggregate mobile endowments"),
        ALEN = structure(
            extract.values(lines,"header \"ALEN\""),
            description = "ALEN Aggregate labor endowments"),
        ACEN = structure(
            extract.values(lines,"header \"ACEN\""),
            description = "ACEN Aggregate capital endowment"),
        ASEN = structure(
            extract.values(lines,"header \"ASEN\""),
            description = "ASEN Aggregate sluggish endowment"),
        AFEN = structure(
            extract.values(lines,"header \"AFEN\""),
            description = "AFEN Aggregate sector-specific endowment"),
        DEND = structure(
            extract.values(lines,"header \"DEND\""),
            description = "Endowment aggregation mapping"),
        MMEN = structure(
            extract.values(lines,"header \"MMEN\""),
            description = "Mobile endowment aggregation mapping"),
        MLEN = structure(
            extract.values(lines,"header \"MLEN\""),
            description = "Labor endowment aggregation mapping"),
        MCEN = structure(
            extract.values(lines,"header \"MCEN\""),
            description = "ACEN Aggregate capital endowment mapping"),
        MSEN = structure(
            extract.values(lines,"header \"MSEN\""),
            description = "AMEN Aggregate sluggish endowment mapping"),
        MFEN = structure(
            extract.values(lines,"header \"MFEN\""),
            description = "MFEN Aggregate sector-specific endowment"),
        ETRE = structure(
            array(
                extract.values(lines,"header \"ETRE\""),
                dim=c(
                    length(extract.values(lines,"header \"ETRE\"")),
                    1
                ),
                dimnames=list(dim1name =c(1:length(extract.values(lines,"header \"ETRE\""))), ETRAE ="ETRAE")
            ),description = "Value of ETRAE for endowments"),
        ESPF = structure(
            array(extract.values(lines,"header \"ESPF\""))
          , description = "Value of ESPF for fixed factor"),
        ESMS = structure(
            array( extract.values(lines,"header \"ESMS\""))
          , description = "Value of ESMS for mobile and sluggish endowments (except capital)"),
        SLUG = structure(
            array(
                as.integer(extract.values(lines,"header \"SLUG\"")),
                dim=c(length(extract.values(lines,"header \"SLUG\"")),1)
            ),
            description = "Sluggish (1) or mobile (0) endowments")
    )
    write_har(aggregation, 'gmap.har')
    }
