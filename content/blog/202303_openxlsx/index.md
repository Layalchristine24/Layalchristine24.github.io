---
author: Layal Christine Lettry
categories:
- R
date: "2023-03-28"
draft: false
excerpt: Create great workbooks with `openxlsx`
layout: single
subtitle: Some `openxlsx` features and best practices
title: Working with `openxlsx`
---

![openxlsx.demo](./featured.jpg)

In my [`openxlsx.demo`](https://github.com/Layalchristine24/openxlsx.demo) package,
you can find some applied examples using `openxlsx` that could help you create a
nice Excel workbook with `R`. 

I will go through some of the coolest `openxlsx` features and best practices (in my opinion) in this blog post. The following guidelines come from my experience and you are free
to follow them (or not). 

You can get other examples by reading these articles:

- [Introduction (`openxlsx` Homepage)](https://ycphs.github.io/openxlsx/articles/Introduction.html)

- [Formating with xlsx (`openxlsx` Homepage)](https://ycphs.github.io/openxlsx/articles/Formatting.html)

## Use `openxlsx` inside of an `R` package
I would suggest to use `openxlsx` inside of an `R` package as you can better manage
how you organise your code. 

### Organise your code in several `R` files
As described in the [r-pkgs (2e)](https://r-pkgs.org/code.html#sec-code-organising) book (by Hadley Wickham and Jenny Bryan), write functions in separated `R` files which you will store in your `R/*` folder. Each file can refer to a single function or to several functions (e.g. one big function with its helpers). For example, in my [`openxlsx.demo`](https://github.com/Layalchristine24/openxlsx.demo) package, I wrote the function `write_penguins()` into the [`R/write_penguins.R`](https://github.com/Layalchristine24/openxlsx.demo/blob/main/R/write_penguins.R) file and I can prepare my data by calling the function `prepare_penguins_mod()` written in the [`R/prepare_penguins_mod.R`](https://github.com/Layalchristine24/openxlsx.demo/blob/main/R/prepare_penguins_mod.R).

Moreover, you will certainly define some `openxlsx` styles for your excel workbook. You can write them into an `R` file such that you can easily retrieve all the styles you defined. 
For instance, in my [`openxlsx.demo`](https://github.com/Layalchristine24/openxlsx.demo) package,
I wrote all my `openxlsx` styles into the [`R/openxlsx_styles.R`](https://github.com/Layalchristine24/openxlsx.demo/blob/main/R/openxlsx_styles.R) file. By loading the package with `pkgload::load_all()`, you will be able to use your styles while you develop your code, as they do not need to be exported. 

``` r
#--- define your datasets ------------------------------------------------------
data_penguins <- palmerpenguins::penguins
data_penguins_raw <- palmerpenguins::penguins_raw

#--- create workbook ---------------------------------------------------------
# create a new workbook
wb <- openxlsx::createWorkbook()

#--- create worksheet --------------------------------------------------------
# add a new worksheet to the workbook
ws_penguins <- openxlsx::addWorksheet(
  wb = wb,
  sheetName = "penguins"
)

# add a new worksheet to the workbook
ws_penguins_raw <- openxlsx::addWorksheet(
  wb = wb,
  sheetName = "penguins_raw"
)

#--- define first row --------------------------------------------------------
# first row where to write the data (set to 2 because we want to write comments 
# in the first row)
first_row <- 2L

#--- modify data -------------------------------------------------------------
data_penguins_mod <- openxlsx.demo::prepare_penguins_mod(
  data = data_penguins,
  data_raw = data_penguins_raw
)


#--- write data --------------------------------------------------------------
# write the palmerpenguins::penguins data
openxlsx::writeData(
  wb = wb,
  sheet = ws_penguins,
  x = data_penguins_mod,
  startRow = first_row,
  startCol = 1,
  headerStyle = style_variables_names # add a style directly to the header
)

# write palmerpenguins::penguins_raw data
openxlsx::writeData(
  wb = wb,
  sheet = ws_penguins_raw,
  x = data_penguins_raw,
  startRow = first_row,
  startCol = 1,
  headerStyle = style_variables_names, # add a style directly to the header
  withFilter = TRUE # filter on everywhere
)

```


### Add drop-down values to a variable

Let us say you would like to provide a list of options in the form of a drop-down list.

``` r
#--- add drop-down values to size --------------------------------------------
# add worksheet "Drop-down values" to the workbook
ws_drop_down_values <- openxlsx::addWorksheet(
  wb = wb,
  sheetName = "drop-down-values"
)

# add options for the drop-down in a second sheet
options <- c(
  "huge",
  "big",
  "normal",
  "small",
  "tiny"
)

# add drop-down values dataframe to the sheet "Drop-down values"
openxlsx::writeData(
  wb = wb,
  sheet = "drop-down-values",
  x = options,
  startCol = 1
)

# openxlsx::openXL(wb)

# add drop-downs
openxlsx::dataValidation(
  wb = wb,
  sheet = ws_penguins,
  cols = which(names(data_penguins_mod) == "size"),
  rows = first_row + seq_len(nrow(data_penguins_mod)),
  operator = "equal",
  type = "list",
  value = "'drop-down-values'!$A$1:$A$5"
)
# openxlsx::openXL(wb)

```




