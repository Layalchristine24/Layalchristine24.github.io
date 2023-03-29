---
author: Layal Christine Lettry
categories:
- R
date: "2023-03-28"
draft: false
excerpt: Create great workbooks with {openxlsx}
layout: single
subtitle: Some {openxlsx} features and best practices
title: Working with {openxlsx}
---

![openxlsx.demo](./featured.jpg)

In my [`openxlsx.demo`](https://github.com/Layalchristine24/openxlsx.demo) package,
you can find some applied examples using [`openxlsx`](https://github.com/ycphs/openxlsx/) that could help you create a
nice excel workbook with `R`. 

I will go through some of the coolest [`openxlsx`](https://github.com/ycphs/openxlsx/) features and best practices (in my opinion) in this blog post. The following guidelines come from my experience and you are free
to follow them or not. 

You can get other examples by reading these articles:

- [Introduction (`openxlsx` Homepage)](https://ycphs.github.io/openxlsx/articles/Introduction.html)

- [Formatting with xlsx (`openxlsx` Homepage)](https://ycphs.github.io/openxlsx/articles/Formatting.html)

## Use [`openxlsx`](https://github.com/ycphs/openxlsx/) inside of an `R` package
I would suggest to use [`openxlsx`](https://github.com/ycphs/openxlsx/) inside of an `R` package as you can better manage
how you organise your code. 

As described in the [r-pkgs (2e)](https://r-pkgs.org/code.html#sec-code-organising) book (by Hadley Wickham and Jenny Bryan), organise your code by writing functions into separated `R` files which you will save in your `R/*` folder. Each file can refer to a single function or to several functions (e.g. one big function with its helpers). For example, in my [`openxlsx.demo`](https://github.com/Layalchristine24/openxlsx.demo) package, the function `write_penguins()` is written in the [`R/write_penguins.R`](https://github.com/Layalchristine24/openxlsx.demo/blob/main/R/write_penguins.R) file and I can prepare my data by calling the function `prepare_penguins_mod()` written in the [`R/prepare_penguins_mod.R`](https://github.com/Layalchristine24/openxlsx.demo/blob/main/R/prepare_penguins_mod.R).

Moreover, you will certainly define some [`openxlsx`](https://github.com/ycphs/openxlsx/) styles for your excel workbook. You can write them into an `R` file such that you can easily retrieve all the styles you defined. 
For instance, in my [`openxlsx.demo`](https://github.com/Layalchristine24/openxlsx.demo) package,
all my [`openxlsx`](https://github.com/ycphs/openxlsx/) styles are written in the [`R/openxlsx_styles.R`](https://github.com/Layalchristine24/openxlsx.demo/blob/main/R/openxlsx_styles.R) file. By loading the package with `pkgload::load_all()`, you will be able to use your styles while you work on your code, as they do not need to be exported.

### Step 1: Prepare your data and create your workbook


``` r
#--- install the package openxlsx.demo -----------------------------------------
# install only if necessary

# install.packages("devtools")
# devtools::install_github("Layalchristine24/openxlsx.demo")

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
  startCol = 1
)

# write palmerpenguins::penguins_raw data
openxlsx::writeData(
  wb = wb,
  sheet = ws_penguins_raw,
  x = data_penguins_raw,
  startRow = first_row,
  startCol = 1
)

# View your workbook
openxlsx::openXL(wb)
```


### Step 2: Add drop-down values to a variable

Let us say you would like to provide a list of options in the form of a drop-down list. 

First, you need to write the options in another worksheet which you will reference to. You can do it by using the function [`addWorksheet()`](https://ycphs.github.io/openxlsx/reference/addWorksheet.html). 

Then, write the options in the new worksheet with [`writeData()`](https://ycphs.github.io/openxlsx/reference/writeData.html).

Finally, add the drop-down values to all the cells of your column with [`dataValidation()`](https://ycphs.github.io/openxlsx/reference/dataValidation.html). Do not worry about the warning message but make sure it works for your workbook (see [stackoverflow](https://stackoverflow.com/questions/72278966/data-validation-warning-message-with-openxlsx-package-in-r-sprintf)).

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

# View your workbook
openxlsx::openXL(wb)
```


### Step 3: Add colors to your drop-down values

To make it more readable, you could add some colors to the different options of your drop-down list. You will then need to create a style for each of the colors you want. Note that I directly created the style in the following chunk as they are not exported by [`openxlsx.demo`](https://github.com/Layalchristine24/openxlsx.demo).

```r
#--- add colors for drop-down values to size ---------------------------------
# see https://ycphs.github.io/openxlsx/articles/Formatting.html#conditional-formatting
openxlsx::conditionalFormatting(wb,
  sheet = ws_penguins,
  cols = which(names(data_penguins_mod) == "size"),
  rows = first_row + seq_len(nrow(data_penguins_mod)),
  type = "contains",
  rule = "huge", # condition under which to apply the formatting
  style = openxlsx::createStyle(
    bgFill = "#AAAAAA"
  )
)

openxlsx::conditionalFormatting(wb,
  sheet = ws_penguins,
  cols = which(names(data_penguins_mod) == "size"),
  rows = first_row + seq_len(nrow(data_penguins_mod)),
  type = "contains",
  rule = "big", # condition under which to apply the formatting
  style = openxlsx::createStyle(
    bgFill = "#6FA8DC"
  )
)

openxlsx::conditionalFormatting(wb,
  sheet = ws_penguins,
  cols = which(names(data_penguins_mod) == "size"),
  rows = first_row + seq_len(nrow(data_penguins_mod)),
  type = "contains",
  rule = "normal", # condition under which to apply the formatting
  style = openxlsx::createStyle(
    bgFill = "#00AA00"
  )
)

openxlsx::conditionalFormatting(wb,
  sheet = ws_penguins,
  cols = which(names(data_penguins_mod) == "size"),
  rows = first_row + seq_len(nrow(data_penguins_mod)),
  type = "contains",
  rule = "small", # condition under which to apply the formatting
  style = openxlsx::createStyle(
    bgFill = "#CCCC00"
  )
)

openxlsx::conditionalFormatting(wb,
  sheet = ws_penguins,
  cols = which(names(data_penguins_mod) == "size"),
  rows = first_row + seq_len(nrow(data_penguins_mod)),
  type = "contains",
  rule = "tiny", # condition under which to apply the formatting
  style = openxlsx::createStyle(
    bgFill = "#CC0000",
    fontColour = "#EEEEEE"
  )
)

# View your workbook
openxlsx::openXL(wb)

```



