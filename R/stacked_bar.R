#' @title Create a Stacked Bar Chart
#' @description Draw a vertically stacked bar chart with ggplot2
#' @param x a data frame
#' @param col the column to be stacked, quoted
#' @param top the number of items to include, numeric
#' @param title chart title, quoted
#' @param x_label chart x axis label, quoted
#' @param y_label chart y axis label, quoted
#' @return plot
#' @export
#'
#' @examples \dontrun{stacked_bar(affiliations, col = "normalizedname", top = 10, 
#' title = "Papers by Affiliation", x_label = "Affiliation", y_label = "Publication Count")}
stacked_bar <- function(x, col = NULL, top = NULL, title = NULL, x_label = NULL, y_label = NULL){
  x %>% 
    select(.data[[col]]) %>%
    count(.data[[col]], sort = TRUE) %>% 
    top_n(n = 10) %>% 
    ggplot(., aes(x = reorder(.data[[col]], n), y = n, fill = .data[[col]])) +
    geom_bar(stat = "identity") +
    coord_flip() +
    scale_color_tableau("Tableau 20") +
    theme(legend.position="none") +
    labs(title = title, x = x_label, y = y_label)
  
}