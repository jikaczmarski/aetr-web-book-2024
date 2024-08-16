# Function to make space regardless of execution format
# To use: write `r space` outside of a code block
# Modify globally at ./scripts/inline_functions/space.R

# space <- if (knitr::is_html_output()) {
#   "<br>"
# } else if (knitr::is_latex_output()) {
#   "\\vspace{1em}"  # Adjust the space as needed
# } else {
#   ""
# }

space <- function(br = "<br>", vspace = "1em") {
  if (knitr::is_html_output()) {
    return(as.character(br))
  } else if (knitr::is_latex_output()) {
    return(as.character(paste0("\\vspace{", vspace, "}")))
  } else {
    return("")
  }
}