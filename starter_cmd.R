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

blogdown::check_site()
# This is a "hello world" example website for the [**blogdown**](https://github.com/rstudio/blogdown) package. The theme was forked from [@jrutheiser/hugo-lithium-theme](https://github.com/jrutheiser/hugo-lithium-theme) and modified by [Yihui Xie](https://github.com/yihui/hugo-lithium).