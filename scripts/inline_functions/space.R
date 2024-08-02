# Function to make space regardless of execution format
# To use: write `r space` outside of a code block
# Modify globally at ./scripts/inline_functions/space.R
space <- if (knitr::is_html_output())"<br>" else if (knitr::is_latex_output()) "\\vspace{1em}"