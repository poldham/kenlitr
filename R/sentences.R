#' @title Sentences for Machine Learning (data)
#' @description A dataset of 11,124,944 sentences from the texts data for use in
#'   machine learning with libraries such as spaCy.
#' @details  The titles and abstracts from the texts dataset divided into
#'   sentences. For use with spaCy in Python convert places_root column to
#'   "answer" and replace TRUE with "accept" and FALSE with "reject". Then write
#'   to file with jsonlite::stream_out(sentences, file("sentences.jsonl")). The jsonl file
#'   can then be loaded directly into spaCy.
#' @usage data("sentences")
#' @format{
#' \describe{
#' \item{\code{doc_id}}{character}
#' \item{\code{text}}{character}
#' \item{\code{places_root}}{logical}
#' }
#' }
"sentences"