---
author: Layal Christine Lettry
categories:
- kamila
- machine learning
- R
- package
date: "2022-04-30"
draft: false
excerpt: My machine learning project (private GitHub repository)
layout: single
links:
- icon: github
  icon_pack: fab
  name: code
  url: https://github.com/asam-group/rrml
subtitle: Applying machine learning and classification methods on a kamila-clustered dataset
tags:
- hugo-site
title: rrml R package
---
# Machine learning methods applied to the Swiss Pension Register <img src="./featured-hex.jpg" align="right" height="139" />
---

## Prerequisite
The R package *rrml* must have a kamila-clustered dataset (in our case, the Swiss Pension Register) as input. This is linked to the package [rrclust](https://github.com/asam-group/rrclust) where
the [kamila](https://github.com/ahfoss/kamila)'s algorithm allows to cluster
the Swiss pension register (cf. [rrclust project](https://layalchristinelettry.rbind.io/project/rrclust/)).

## Description of the project

This R package allows us to test the estimation power of some classification methods which are applied to the kamila-clustered Swiss pension register. It is then possible to compare the results with the performance of several methods applied on the arbitrarily pension register. 

If the performance is good enough, we can apply machine learning methods (as the 
[Transformation Forests Method](https://github.com/cran/trtf)) in order to estimate a distribution for each part of the population. 
Our final objective is to use these estimated distributions for predicting the annual average 
revenue of each new pensioner. 

## Application

By now, only the Linear Discriminant Analysis has been programmed. This project 
is still work-in-progress.

The following methods are intended to be tested on the kamila-clustered Swiss pension register:  
- Logit Discriminant Analysis, 
- Splines, 
- MARS, 
- Classification trees 
- and Transformation forests.

## Evaluation of the results

The first tests driven with the linear discriminant analysis tend to give a better performance in terms of estimation power 
than the ones performed in the [forestoasi project](https://layalchristinelettry.rbind.io/project/forestoasi/) on an arbitrarily clustered pension register. We are confident
that the other methods mentioned above will allow us to get good results as well.

Stay tuned !
