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

### 1. Prepare your data in a separated `R` file
As described in [r-pkgs](https://r-pkgs.org/code.html#sec-code-organising), write functions in separated `R` files which you will store in your `R/*` folder. Each file can refer to a single function or to several functions (e.g. one big function with its helpers). 

Moreover, you will certainly define some `openxlsx` styles for your excel workbook. You can write them into an `R` file such that you can easily retrieve all the styles you defined. 
For instance, in my [`openxlsx.demo`](https://github.com/Layalchristine24/openxlsx.demo) package,
I wrote all my `openxlsx` styles into the [`R/openxlsx_styles.R`](https://github.com/Layalchristine24/openxlsx.demo/blob/main/R/openxlsx_styles.R) file. By loading the package with `pkgload::load_all()`, you will be able to use your styles while you develop your code, as they do not need to be exported. 






