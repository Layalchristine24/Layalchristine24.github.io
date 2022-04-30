---
author: Layal Christine Lettry
categories:
- mediation analysis
- continuous treatments 
- generalized propensity score weighting
- R
- package
date: "2020-04-14"
draft: false
excerpt: Research article on direct and indirect effects of continuous treatments based on generalized propensity score weighting
layout: single
links:
- icon: website
  icon_pack: fab
  name: website
  url: https://onlinelibrary.wiley.com/doi/10.1002/jae.2765
subtitle: Martin Huber, Yu-Chin Hsu, Ying-Ying Lee, Layal Lettry
tags:
- hugo-site
title:  Research article on direct and indirect effects of continuous treatments based on generalized propensity score weighting
---
# Direct and indirect effects of continuous treatments based on generalized propensity score weighting
---

## Summary
This paper proposes semi- and nonparametric methods for disentangling the total causal effect of a continuous treatment on an outcome variable into its natural direct effect and the indirect effect that operates through one or several intermediate variables called mediators jointly. Our approach is based on weighting observations by the inverse of two versions of the generalized propensity score (GPS), namely the conditional density of treatment either given observed covariates or given covariates and the mediator. Our effect estimators are shown to be asymptotically normal when the GPS is estimated by either a parametric or a nonparametric kernel-based method. We also provide a simulation study and an empirical illustration based on the Job Corps experimental study.

## My contribution

I cleaned the dataset Job Corps and built the necessary variables for the study. The most important are:

- the continuous treatment variable (D): the total hours spent either in academic or vocational classes in the 12 months following the program assignment according to the survey;
- the mcontinuous mediator variables (M): the proportion of weeks employed in the second year;
- the outcome variable (Y): criminal behavior, namely the number of times
the individual was arrested by the police in the fourth year after the random assignment.

Please consult the [research paper](https://onlinelibrary.wiley.com/doi/10.1002/jae.2765) p. 825-826 for more information.