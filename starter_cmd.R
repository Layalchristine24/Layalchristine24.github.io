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
blogdown::install_theme("escalate/hugo-split-theme")
blogdown::install_theme("wowchemy/starter-academic")

blogdown::find_hugo('all')
blogdown::config_Rprofile()
blogdown::check_hugo()
blogdown::config_netlify()
blogdown::remove_hugo()
# make sure your project is either backed up or under version control
blogdown::bundle_site(".", output = ".")

remotes::install_github('rstudio/blogdown', force = TRUE)


R.version.string
# install.packages("rstudioapi")
rstudioapi::getVersion()
blogdown::install_theme("hugo-apero/hugo-apero")

blogdown::install_theme(theme = "hugo-apero/hugo-apero",
                        update_config = FALSE, 
                        force = TRUE)


library(blogdown)
new_site(theme = "hugo-apero/hugo-apero", 
           format = "toml",
           sample = FALSE,
           empty_dirs = TRUE)
