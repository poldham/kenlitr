trends <- function(df, x = NULL, y = NULL, start = NULL, end = NULL, weight = NULL){
  # trends by year (single)
  df %>% 
    dplyr::group_by(.data[[x]]) %>% 
    dplyr::count() %>% 
    dplyr::filter(.data[[x]] >= start && .data[[x]] <= end) %>% 
    ggplot2::ggplot(., aes(.data[[x]], y = n)) + # is y = n OK here???? How to choose y?
    ggplot2::geom_line()

  # facet trends (for example by organisation or keywords or country), show top ten in order?
  
}


#lens %>% 
#  group_by(publication_year) %>%
 # count() %>%
#  filter(publication_year >= 1990 && publication_year <= 2016) %>% 
#  ggplot(., aes(x = publication_year, y = n)) + 
 # geom_line()

# papers %>% 
#   select(normalizedname, country, paperid, year) %>% 
#   mutate(duplicate_paperid = duplicated(paperid)) %>% 
#   filter(duplicate_paperid == FALSE) %>% 
#   group_by(country, year) %>% 
#   count()
# 
# affiliations %>% 
#   select()
