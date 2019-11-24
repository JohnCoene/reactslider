#' React Slider
#'
#' Create a react slider
#'
#' @importFrom shiny restoreInput
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#'
#' @export
reactsliderInput <- function(inputId, data = NULL, min = NULL, max = NULL, step = 1, start = NULL, tooltip = c("always", "onClick", "never"), 
  prefix = "", postfix = "", labels = list(), sticky = FALSE, orientation = c("horizontal", "vertical"), 
  chart_tooltip = FALSE, width = 400, default = 0) {

  config <- list(
    min = min, 
    max = max, 
    step = step, 
    start = start, 
    tooltip = match.arg(tooltip),
    prefix = prefix,
    postfix = postfix,
    labels = labels,
    sticky = sticky,
    chartLength = width,
    chartTooltip = chart_tooltip,
    orientation = match.arg(orientation)
  )
  if(!is.null(data)) config$chartData <- as_chart_data(data)

  if(is.null(start) && !is.null(data))
    config$start <- round(mean(data))

  if(is.null(min) && !is.null(data))
    config$min <- floor(min(data))

  if(is.null(max) && !is.null(data))
    config$max <- ceiling(max(data))
  
  reactR::createReactShinyInput(
    inputId,
    "reactslider",
    htmltools::htmlDependency(
      name = "reactslider-input",
      version = "1.0.0",
      src = "www/reactslider/reactslider",
      package = "reactslider",
      script = "reactslider.js"
    ),
    default,
    config,
    htmltools::tags$div
  )
}

#' Shiny
#'
#' Shiny update.
#'
#' @export
updateReactsliderInput <- function(session, inputId, value, configuration = NULL) {
  message <- list(value = value)
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}

as_chart_data <- function(x) {
  counts <- table(x)
  x <- names(counts)
  x <- as.numeric(x)
  y <- unname(counts)
  purrr::map2(x, y, function(x, y){
    list(x = x, y = y)
  })
}