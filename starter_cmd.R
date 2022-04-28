if (!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("rstudio/blogdown")

blogdown::install_hugo()

library(blogdown)
new_site() # default theme is lithium
# need to stop serving so can use the console again
# install_theme("themes/hugo-lithium", 
#               theme_example = TRUE, 
#               update_config = TRUE)

blogdown::serve_site() 
