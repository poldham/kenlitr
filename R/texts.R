#' @title Texts for text mining and Machine Learning  (data)
#' @description A dataset that combines the title and abstracts from the lens dataset for text mining and ML. 
#' @details  The titles and abstracts are divided into separate files and then
#'   joined. A unique id is constructed from the paperid and row number
#'   separated by "_". The result is a data frame compliant with the emerging
#'   TIF format favoured by quanteda, spacyr etc. paperids can be reconstructed for joins at a later stage using tidyr::separate(). 
#'   For use with spacy in Python try jsonlite::stream_out(texts, file(flights.jsonl)).
#' @usage data("texts")
#' @aliases texts
#' @format{
#' \describe{
#' \item{\code{id}}{character}
#' \item{\code{texts}}{character}
#' }
#' }
"texts"