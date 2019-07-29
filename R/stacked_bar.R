#' @title Create a Stacked Bar Chart
#' @description Draw a vertically stacked bar chart with ggplot2
#' @param x a data frame
#' @param col the column to be stacked, quoted
#' @param top the number of items to include, numeric
#' @param title chart title, quoted
#' @param x_label chart x axis label, quoted
#' @param y_label chart y axis label, quoted
#'
#' @return plot
#' @export
#'
#' @examples \dontrun{stacked_bar(affiliations, col = "normalizedname", top = 10, title = "Papers by Affiliation", x_label = "Affiliation", y_label = "Publication Count")}
stacked_bar <- function(x, col = NULL, top = NULL, title = NULL, x_label = NULL, y_label = NULL){
  x %>% 
    dplyr::select(.data[[col]]) %>%
    dplyr::count(.data[[col]], sort = TRUE) %>% 
    dplyr::top_n(n = 10) %>% 
    ggplot2::ggplot(., aes(x = reorder(.data[[col]], n), y = n, fill = .data[[col]])) +
    ggplot2::geom_bar(stat = "identity") +
    ggplot2::coord_flip() +
    ggthemes::scale_color_tableau("Tableau 20") +
    ggplot2::theme(legend.position="none") +
    ggplot2::labs(title = title, x = x_label, y = y_label)
  
}