#' @title Text Mine Terms in Text Fields
#' @description Text mine text files for top tesms
#' @param x a data frame
#' @param col the column to be text mined, quoted
#' @param token either words or ngrams. If ngrams set n_gram value, character
#' @param n_gram Number of words to split as tokens e.g 2, numeric
#' @param top the number of items to include, numeric
#' @param title chart title, quoted
#' @param x_label chart x axis label, quoted
#' @param y_label chart y axis label, quoted
#' @details The text mining functions are adapted from Silge & Robinson `Text Mining with R``
#' @return plot
#' @export
#'
#' @examples \dontrun{
#' keywords_rank <- text_mine(lens, col = "keywords", top = 20) %>% print()
#' text_mine(lens, col = "keywords", top = 20, viz = TRUE)
#' title_ngrams <- text_mine(lens, col = "title", top = 20, token = "ngrams", n_gram = 2, title = "Top Terms in Title", x_label = "Terms", y_label = "Publication Count")
#' text_mine(lens, col = "title", top = 20, token = "ngrams", n_gram = 2, title = "Top Terms in Title", x_label = "Terms", y_label = "Publication Count", viz = TRUE)
#' abstract_ngrams <- text_mine(lens, col = "abstract", top = 20, token = "ngrams", n_gram = 2, title = "Top Terms in Title", x_label = "Terms", y_label = "Publication Count")
#' text_mine(lens, col = "abstract", top = 20, token = "ngrams", n_gram = 2, title = "Top Terms in Title", x_label = "Terms", y_label = "Publication Count", viz = TRUE)
#' title_words <- text_mine(lens, col = "title", top = 20, token = "words", title = "Top Terms in Title", x_label = "Terms", y_label = "Publication Count")
#' text_mine(lens, col = "title", top = 20, token = "words", title = "Top Terms in Title", x_label = "Terms", y_label = "Publication Count", viz = TRUE)
#' abstract_words <- text_mine(lens, col = "abstract", top = 20, token = "words", title = "Top Terms in Title", x_label = "Terms", y_label = "Publication Count")
#' text_mine(lens, col = "abstract", top = 20, token = "words", title = "Top Terms in Title", x_label = "Terms", y_label = "Publication Count", viz = TRUE)
#' texts_words <- text_mine(texts, col = "text", top = "20", token = "words", title = "Top Words in Titles and Abstracts", x_label = "Terms", y_label = "Publication Count")
#' texts_ngrams <- text_mine(texts, col = "text", top = "20", token = "ngrams", n_gram = 2, title = "Top Words in Titles and Abstracts", x_label = "Terms", y_label = "Publication Count")
#' }
text_mine <- function(x, col = NULL, token = NULL, n_gram = NULL, lower = TRUE, top = NULL, 
                        title = NULL, x_label = NULL, y_label = NULL, viz = NULL){
  
  # use of .data[[col]] for tidy evaluation
  # see https://www.tidyverse.org/articles/2019/06/rlang-0-4-0/ if unfamiliar with .data[[col]]
  # and friends such as {{ }}
  
  x <- x %>% 
    dplyr::select(.data[[col]]) %>%
    tidyr::drop_na(.data[[col]])
  
  # logical test to pass to if statement

  test_key <- col == "keywords" 
  test_mesh <- col == "mesh_terms"
  
  # separate concatenated values onto new rows on ";", trim extra whitespace,
  # convert to lower to improve score, rank on terms, then select top n to pass
  # to console or to viz in stacked bar chart
  
  if(test_key == TRUE || test_mesh == TRUE){
  out <- x %>% 
    tidyr::separate_rows(.data[[col]], sep = ";") %>% 
    dplyr::mutate(terms = stringr::str_trim(.data[[col]], side = "both")) %>% 
    dplyr::mutate(terms = stringr::str_to_lower(terms)) %>% 
    dplyr::select(terms) %>% 
    dplyr::count(terms, sort = "TRUE") %>% 
    dplyr::top_n(n = top)
  } else if(!is.null(n_gram)) {

   # for titles or abstracts provide options
   # to parse into words or ngrams, lower is optional
   # for words ngram distinction warning needed on token = words and ngram = x cases. Fail fast and clearly
   # stop_words are obligatory in code below. Make optional with arg. 
    
    out <- x %>%
     tidytext::unnest_tokens(terms, input = .data[[col]], token = token, n = n_gram, to_lower = lower) %>%
     tidyr::separate(terms, c("word1", "word2"), sep = " ", extra = "drop") %>%
     dplyr::mutate(word1 = stringr::str_trim(word1, side = "both")) %>%
     dplyr::mutate(word2 = stringr::str_trim(word2, side = "both")) %>%
     dplyr::filter(!word1 %in% tidytext::stop_words$word) %>%
     dplyr::filter(!word2 %in% tidytext::stop_words$word) %>%
     tidyr::unite(terms, word1, word2, sep = " ") %>%
     dplyr::count(terms, sort = TRUE) %>%
     dplyr::top_n(n = top)

   out
  } else if(token == "words"){
   out <- x %>% 
     tidytext::unnest_tokens(terms, input = .data[[col]], token = token, to_lower = lower) %>% 
     dplyr::filter(!terms %in% tidytext::stop_words$word) %>% 
     dplyr::count(terms, sort = TRUE)  %>%
     dplyr::top_n(n = top)
 }
  
# option, pass to stacked_bar() fun rather than repeating code? 
# provide options to choose the ggtheme in later version
  
 if(!is.null(viz)){
      out %>%
      ggplot2::ggplot(., aes(x = reorder(terms, n), y = n, fill = terms)) +
      ggplot2::geom_bar(stat = "identity") +
      ggplot2::coord_flip() +
      ggthemes::scale_color_tableau("Tableau 20") +
      ggplot2::theme(legend.position="none") +
      ggplot2::labs(title = title, x = x_label, y = y_label)

    } else { out }
     
}