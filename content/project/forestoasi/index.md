---
author: Layal Christine Lettry
categories:
- classification
- clustering
- R
- package
date: "2022-04-30"
draft: false
excerpt: My exploratory project (private GitHub repository)
layout: single
links:
- icon: github
  icon_pack: fab
  name: code
  url: https://github.com/Layalchristine24/forestoasi
subtitle: forestoasi R package
tags:
- hugo-site
title: forestoasi R package
---
# Testing classification methods on the Swiss Pension Register
---

## Description of the project

This project is about testing the estimation power of some classification methods which are applied to the arbitrarily clustered Swiss pension register. It is then possible to compare the performance of several methods in order to evaluate the feasibility of estimating the annual average determinant revenue (AADR) only with some sociodemographic characteristics.

## Application

The following methods were applied on the arbitrarily clustered Swiss pension register: 
- Linear Discriminant Analysis, 
- Logit Discriminant Analysis, 
- Splines, 
- MARS, 
- Classification trees.

## Evaluation of the results

As the performance of the methods mentioned above did not give satisfactory results, 
we had to find a better way to cluster the pensions register. This is the role 
of my [rrclust project](https://layalchristinelettry.rbind.io/project/rrclust/) using the [kamila clustering algorithm](https://github.com/ahfoss/kamila) of A. Foss et al. (2016) and A. Foss et al. (2018). 