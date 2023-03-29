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

In this blog post, I will go through some of the [`openxlsx`](https://github.com/ycphs/openxlsx/) functions and explain how I used them. The following guidelines come from my experience and you are free
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
Let us create your first workbook! To do so, you can use the function [`createWorkbook()`](https://ycphs.github.io/openxlsx/reference/createWorkbook.html). 

```r
#--- install the package openxlsx.demo -----------------------------------------
# install only if necessary

# install.packages("devtools")
# devtools::install_github("Layalchristine24/openxlsx.demo")

#--- create workbook -----------------------------------------------------------
# create a new workbook
wb <- openxlsx::createWorkbook()
```

As you will write your data in several worksheets, create a new one with [`addWorksheet()`](https://ycphs.github.io/openxlsx/reference/addWorksheet.html). You can also name the worksheets by using the argument `sheetName`. 

In this example, you will write the `palmerpenguins::penguins` data set
into your first worksheet. Ideally, you want to modify it and add some features.

```r
#--- create 1st worksheet ------------------------------------------------------
# add a new worksheet to the workbook
ws_penguins <- openxlsx::addWorksheet(
  wb = wb,
  sheetName = "penguins"
)
```

For the second worksheet, you will use the `palmerpenguins::penguins_raw` data set which
contains all the variables and original names as downloaded (please refer to the
[`palmerpenguins` Homepage](https://allisonhorst.github.io/palmerpenguins/) for more details). 

```r
#--- create 2nd worksheet ------------------------------------------------------
# add a new worksheet to the workbook
ws_penguins_raw <- openxlsx::addWorksheet(
  wb = wb,
  sheetName = "penguins_raw"
)
```

You can use the function [`prepare_penguins_mod()`](https://github.com/Layalchristine24/openxlsx.demo/blob/main/R/prepare_penguins_mod.R) to modify the data set `palmerpenguins::penguins` by adding to it some new variables and rearrange the columns.

```r
#--- define your datasets ------------------------------------------------------
data_penguins <- palmerpenguins::penguins
data_penguins_raw <- palmerpenguins::penguins_raw

#--- modify data ---------------------------------------------------------------
data_penguins_mod <- openxlsx.demo::prepare_penguins_mod(
  data = data_penguins,
  data_raw = data_penguins_raw
)
```
As you want to add a specific style to header by directly using [`writeData()`](https://ycphs.github.io/openxlsx/reference/writeData.html), you first need to define the header style in a separated `R` file if you are working inside of a package by using the function [`createStyle()`](https://ycphs.github.io/openxlsx/reference/createStyle.html). Note that the argument `textDecoration` is set to `bold`, all the cell borders will be printed as `border` is set to `c("top", "bottom", "left", "right")` and they will have the `medium` size because `borderStyle` is set to `medium`. You also set `wrapText` to `TRUE` such that the text in a cell will automatically be wrapped if it is too long. 
 
```r
# define style style_variables_names
style_variables_names <- openxlsx::createStyle(
  fontSize = 12,
  halign = "left",
  valign = "top",
  textDecoration = "bold",
  border = c("top", "bottom", "left", "right"),
  borderStyle = "medium",
  wrapText = TRUE
)
```

Finally, you can write the data into the workbook thanks to the function [`writeData()`](https://ycphs.github.io/openxlsx/reference/writeData.html). Note that you set the first active row to be the second one by running `first_row <- 2L` as you want to leave the first row free for some future comments. 

```r
#--- define first row ----------------------------------------------------------
# first row where to write the data (set to 2 because you want to write comments
# in the first row)
first_row <- 2L

#--- write data ----------------------------------------------------------------
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

To see what your workbook looks like, use the function [`openXL()`](https://ycphs.github.io/openxlsx/reference/openXL.html).

``` r
# View your workbook
openxlsx::openXL(wb)
```
### Step 2: Create a drop-down list

#### Step 2.1: Add drop-down values to a variable

Let us say you would like to provide a list of options in the form of a drop-down list. 

First, you need to write the options in another worksheet which you will reference to. You can do it by using the function [`addWorksheet()`](https://ycphs.github.io/openxlsx/reference/addWorksheet.html). 
```r
# add worksheet "Drop-down values" to the workbook
ws_drop_down_values <- openxlsx::addWorksheet(
  wb = wb,
  sheetName = "drop-down-values"
)
```

Then, write the options in the new worksheet with [`writeData()`](https://ycphs.github.io/openxlsx/reference/writeData.html).

```r
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

```
Finally, add the drop-down values to all the cells of your column with [`dataValidation()`](https://ycphs.github.io/openxlsx/reference/dataValidation.html). You will use the following arguments: 

- `operator` should be `equal` (but can also be ignored);

- `type` should be `list` as you want a drop-down list;

- `value` should refer to the cells coordinates of the worksheet where you saved your options, i.e. `'drop-down-values'!$A$1:$A$5`. 

Do not worry about the warning message but make sure it works for your workbook (see [stackoverflow](https://stackoverflow.com/questions/72278966/data-validation-warning-message-with-openxlsx-package-in-r-sprintf)).

``` r
# add drop-down values
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


#### Step 2.3: Add colors to your drop-down values

To make it more readable, you could add some colors to the different options of your drop-down list by using the function [`conditionalFormatting()`](https://ycphs.github.io/openxlsx/reference/conditionalFormatting.html). You can see other examples by consulting this [webpage](https://ycphs.github.io/openxlsx/articles/Formatting.html#conditional-formatting). The specific arguments to use in this example are the following: 

- `rule`: Allows to enter the condition under which to apply the formatting. In this example, it will be the values of the drop-down list; i.e. `huge`, `big`, `normal`, `small` and `tiny`;

- `style`: Defines the style to apply if the condition set in the `rule` argument is fulfilled;

- `type`: Describes the `rule`. In this example, `type` should be equal to `contains` as you want to apply a specific style to all the cells containing the drop-down value defined in the `rule` argument.

You will then need to create a style for each of the colors you want by using the function [`createStyle()`](https://ycphs.github.io/openxlsx/reference/createStyle.html). Note that I directly created the different styles in the following chunk as they are not exported by [`openxlsx.demo`](https://github.com/Layalchristine24/openxlsx.demo), but you could also write them in a separated `R` file as explained in the first section of this post.

```r
#--- add colors for drop-down values to size -----------------------------------
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


#### Step 2.4: Make the sheet `drop-down-values` invisible
As you might not want to show the sheet where you wrote the options for the drop-down list, you can make it invisibile thanks to the function [`sheetVisibility()`](https://ycphs.github.io/openxlsx/reference/sheetVisibility.html). You need to specify the workbook name (i.e. `wb`) as well as the worksheet number you want to make invisible --- in this example, this number is stored in the object `ws_drop_down_values` --- and you can finally assign it to `FALSE`.  

```r
#--- hide sheet ----------------------------------------------------------------
# hide sheet "drop-down-values"
openxlsx::sheetVisibility(wb)[ws_drop_down_values] <- FALSE

# View your workbook
openxlsx::openXL(wb)
```

### Step 4: Set width and wrap text
You first need to define the styles in an external `R` file if you are working inside of a package by using the function [`createStyle()`](https://ycphs.github.io/openxlsx/reference/createStyle.html). Note that the argument `wrapText` is set to `TRUE` such that the text in a cell will automatically be wrapped. 

```r
# create style to wrap text
style_body <- openxlsx::createStyle(
  fontSize = 12,
  halign = "left",
  valign = "top",
  wrapText = TRUE
)
```

blablabla
```r
# --- set columns width --------------------------------------------------------
# set all cols but any_comment to a specific width in ws_penguins
openxlsx::setColWidths(
  wb = wb,
  sheet = ws_penguins,
  cols = which(names(data_penguins_mod) != "any_comment"),
  widths = 22 # "auto"for automatic sizing
)

# set all cols to a specific width in ws_penguins_raw
openxlsx::setColWidths(
  wb = wb,
  sheet = ws_penguins_raw,
  cols = seq_len(ncol(data_penguins_raw)),
  widths = 22 # "auto"for automatic sizing
)

# openxlsx::openXL(wb)

# --- wrap text ----------------------------------------------------------------
# add style_body to wrap text in ws_penguins
# (see option 'wrapText = TRUE' in 'createStyle()')
openxlsx::addStyle(
  wb = wb,
  sheet = ws_penguins,
  style = style_body,
  rows = first_row + seq_len(nrow(data_penguins_mod)),
  cols = seq_len(ncol(data_penguins_mod)),
  gridExpand = TRUE # apply style to all combinations of rows and cols
)

# add style_body to wrap text in ws_penguins_raw
# (see option 'wrapText = TRUE' in 'createStyle()')
openxlsx::addStyle(
  wb = wb,
  sheet = ws_penguins_raw,
  style = style_body,
  rows = first_row + seq_len(nrow(data_penguins_raw)),
  cols = seq_len(ncol(data_penguins_raw)),
  gridExpand = TRUE # apply style to all combinations of rows and cols
)

# View your workbook
openxlsx::openXL(wb)

```

### Step 5: Protect your worksheets
You can protect your worksheets from any modification thanks to the function [`protectWorksheet()`](https://ycphs.github.io/openxlsx/reference/protectWorksheet.html). By assigning `FALSE` to the arguments `lockAutoFilter` and `lockFormattingCells`, even though the worksheet is protected, you still allow for filtering and for formatting cells. You can also add other options like defining a password for example. Please check the function [reference](https://ycphs.github.io/openxlsx/reference/protectWorksheet.html).

```r
#--- protect worksheets --------------------------------------------------------
# protect the worksheet ws_penguins
openxlsx::protectWorksheet(
  wb = wb,
  sheet = ws_penguins,
  lockAutoFilter = FALSE, # allows filtering
  lockFormattingCells = FALSE # allows formatting cells
)

# protect the worksheet ws_penguins_raw
openxlsx::protectWorksheet(
  wb = wb,
  sheet = ws_penguins_raw,
  lockAutoFilter = FALSE, # allows filtering
  lockFormattingCells = FALSE # allows formatting cells
)

# View your workbook
openxlsx::openXL(wb)
```

### Step 6: Lock and unlock cells
Now that your worksheets are protected, you might want to unlock specific cells and to highlight which cells are locked, even though they seem to be editable (like `any_comments` in your example).

You first need to define the styles in an external `R` file if you are working inside of a package by using the function [`createStyle()`](https://ycphs.github.io/openxlsx/reference/createStyle.html). Note that the argument `locked` is set to `FALSE` to unlock a cell and to `TRUE` to lock another one.

```r 
# define style style_unlocked
style_unlocked <- openxlsx::createStyle(
  fontSize = 12,
  halign = "left",
  valign = "top",
  locked = FALSE,
  fgFill = "#d9d2e9",
  border = c("top", "bottom", "left", "right"),
  wrapText = TRUE
)

# define style style_locked
style_locked <- openxlsx::createStyle(
  fontSize = 12,
  halign = "left",
  valign = "top",
  locked = TRUE,
  fgFill = "#f4cccc",
  border = c("top", "bottom", "left", "right"),
  wrapText = TRUE
)
```

Then, you can apply these styles thanks to the function [`addStyle()`](https://ycphs.github.io/openxlsx/reference/addStyle.html). Note 

```r
#--- unlock column size (ws_penguins) and Comments (ws_penguins_raw) -----------

# apply unlocked style to size column
openxlsx::addStyle(
  wb = wb,
  sheet = ws_penguins,
  style = style_unlocked,
  rows = first_row + seq_len(nrow(data_penguins_mod)),
  cols = which(names(data_penguins_mod) == "size"),
  gridExpand = FALSE
)

# apply unlocked style to Comments column
openxlsx::addStyle(
  wb = wb,
  sheet = ws_penguins_raw,
  style = style_unlocked,
  rows = first_row + seq_len(nrow(data_penguins_raw)),
  cols = which(names(data_penguins_raw) == "Comments"),
  gridExpand = FALSE
)

#--- lock column any_comments in ws_penguins -----------------------------------

# apply locked style to any_comment column
openxlsx::addStyle(
  wb = wb,
  sheet = ws_penguins,
  style = style_locked,
  rows = first_row + seq_len(nrow(data_penguins_mod)),
  cols = which(names(data_penguins_mod) == "any_comment"),
  gridExpand = FALSE
)

# View your workbook
openxlsx::openXL(wb)
```
blabla bla

```r 
#--- unlock specific cells -----------------------------------------------------
# indices of columns to be unlocked if no value in a cell
tib_indices <- openxlsx.demo::find_cells_to_unlock(
  data = data_penguins_mod,
  "bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g", "sex"
)

# subtable with only na cases
isna_cases <- tib_indices |>
  dplyr::filter(to_unlock == 1) |>
  dplyr::arrange(rows, columns)


# apply unlocked style to isna_cases cells
openxlsx::addStyle(
  wb = wb,
  sheet = ws_penguins,
  style = style_unlocked,
  rows = first_row + isna_cases$rows,
  cols = isna_cases$columns,
  gridExpand = FALSE
)

# apply unlocked style to cells in 1st row of ws_penguins (for comments)
openxlsx::addStyle(
  wb = wb,
  sheet = ws_penguins,
  style = style_unlocked,
  rows = 1,
  cols = seq_len(ncol(data_penguins_mod)),
  gridExpand = TRUE
)

# apply unlocked style to cells in 1st row of ws_penguins_raw (for comments)
openxlsx::addStyle(
  wb = wb,
  sheet = ws_penguins_raw,
  style = style_unlocked,
  rows = 1,
  cols = seq_len(ncol(data_penguins_raw)),
  gridExpand = TRUE
)

# openxlsx::openXL(wb)

#--- add filter for several variables ------------------------------------------
# add filtering possibility
openxlsx::addFilter(
  wb = wb,
  sheet = ws_penguins,
  rows = first_row,
  cols = c(
    which(names(data_penguins_mod) == "year"),
    which(names(data_penguins_mod) == "species"),
    which(names(data_penguins_mod) == "island")
  )
)

# View your workbook
openxlsx::openXL(wb)
```

