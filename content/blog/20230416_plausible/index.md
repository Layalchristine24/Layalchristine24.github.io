---
author: Layal Christine Lettry
categories:
- R
- Plausible
- Hugo
date: "2023-04-26"
draft: false
excerpt: How to integrate Plausible Analytics into your Hugo Website
layout: single
subtitle: Use Plausible Analytics as an alternative to Google Analytics
title: Website Traffic Metrics with Plausible Analytics
---

![Website Analytics](./featured.jpg)

### Introduction
In this article, I would like to explain how to use [Plausible Analytics](https://plausible.io) with a 
Hugo website built with a [Hugo Apéro](https://hugo-apero-docs.netlify.app) theme. 

### Motivation
At the time I wanted to install [Google Analytics](https://analytics.google.com/analytics/web/provision/#/provision) 
for my personal Hugo website to obtain some statistics about its usage, I 
came across [this GitHub issue](https://github.com/rstudio/blogdown/issues/731) 
which caught my attention.

According to [Seth Ariel Green](https://github.com/setgree) 
who wrote [that GitHub issue](https://github.com/rstudio/blogdown/issues/731), 
[Google Analytics](https://analytics.google.com/analytics/web/provision/#/provision) 
should be avoided and an alternative tool should be used to track the website traffic. 
His suggestion was to opt for [Plausible Analytics](https://plausible.io). 

Therefore, I looked for information about the installation of [Plausible Analytics](https://plausible.io) 
to start measuring site traffic metrics for my personal website built with [Hugo Apéro](https://hugo-apero-docs.netlify.app). However, I did not find any clear 
description about the installation process. 

That is why I would like to share my experience with you in this article.

### Why choose Plausible Analytics over Google Analytics?

#### Context
In 2022, some countries prohibited the use of [Google Analytics](https://analytics.google.com/analytics/web/provision/#/provision) 
since they considered it as unlawful and violating the [General Data Protection Regulation (GDPR)](https://gdpr.eu/what-is-gdpr/#:~:text=The%20General%20Data%20Protection%20Regulation,to%20people%20in%20the%20EU.). 
This is the case of [France](https://www.cnil.fr/en/use-google-analytics-and-data-transfers-united-states-cnil-orders-website-manageroperator-comply), 
[Italy](https://www.cpomagazine.com/data-protection/italy-bans-google-analytics-over-improper-eu-us-data-transfers/), [Austria](https://matomo.org/blog/2022/01/google-analytics-gdpr-violation/) and [Denmark](https://cookie-script.com/privacy-laws/danish-dpa-outlaws-using-google-analytics), among others. More details can be found on [this webpage](https://plausible.io/blog/google-analytics-illegal).

#### Advantages of Plausible Analytics

Three of the advantages of using Plausible Analytics over Google Analytics are listed below[^1]:

1. [Plausible Analytics](https://plausible.io) is a lightweight and simple analytics 
tool offering clear statistics on one page. It is quite the opposite of [Google Analytics](https://analytics.google.com/analytics/web/provision/#/provision) 
which requires some exploration and understanding of all its options and dashboards.

2. The analytics script of [Plausible Analytics](https://plausible.io) is smaller
and lighter than the one of [Google Analytics](https://analytics.google.com/analytics/web/provision/#/provision). 
Therefore, it does not slow down your website.

3. [Plausible Analytics](https://plausible.io) respects the privacy of the visitors
and do not use any cookies.

You can find more reasons to use [Plausible Analytics](https://plausible.io) in
its own [GitHub repository](https://github.com/plausible/analytics/) as it is open-source.


[^1]: [My reference](https://plausible.io/simple-web-analytics). 

### Integration of Plausible Analytics in a Hugo Website with Hugo Apéro theme

To install [Plausible Analytics](https://plausible.io), you should:

 1. [register your account](https://plausible.io/docs/register-account);
 
 2. [add your website details](https://plausible.io/docs/add-website);
 
 3. [add your JavaScript snippet in the `<head>` of your website](https://plausible.io/docs/plausible-script): if your website is built with [Hugo Apéro](https://hugo-apero-docs.netlify.app), you should 
 
    i) create a new file in `themes/hugo-apero/layouts/partials/head_custom.html` like it was done in [this commit](https://github.com/Layalchristine24/Layalchristine24.github.io/commit/b223aef03f779a6708450815fa29015425498679));
    
    
    ii) write `{{ partial "head_custom.html" . }}` into `themes/hugo-apero/layouts/partials/head.html` like in [this line of code](https://github.com/Layalchristine24/Layalchristine24.github.io/blob/9d677ec48047c31eb84076725c547e877cd6c0fc/themes/hugo-apero/layouts/partials/head.html#L3);
  

4. push your modifications and deploy your website;

5. check that the script is installed on your website by viewing the page source
and by searching with `Cmd + F` the character string `data-domain`. 

6. if everything went according to the plan, you will receive an email starting 
with "Congrats! The Plausible script has been installed correctly on [your website]."


 ***<p style="text-align: center;">Congratulations, you made it!!</p>***

## Analyse your data with the R package [`plausibler`](https://github.com/giocomai/plausibler)

With the R package [`plausibler`](https://github.com/giocomai/plausibler), you can make queries and summarise your website traffic metrics
directly from your R console. 

You will only need to get an API key which you can easily generate. You
can access to your settings page by clicking on the little three vertical dots that are located next
to your username at the top of the page on the right in [Plausible Analytics](https://plausible.io). When you scroll down the page, you will see a 
section called "API Keys" where you can generate and then copy an API Key into the
function `plausibler::pa_set()` as explained in the `README` file of the GitHub repository [`plausibler`](https://github.com/giocomai/plausibler).

Then, follow the `README` instructions and you will be able to obtain all your website statistics right in your R session. 

 


## Acknowledgements

Many thanks to the author of [`plausibler`](https://github.com/giocomai/plausibler), namely [Giorgio Comai](https://github.com/giocomai), and to [Seth Ariel Green](https://github.com/setgree) for 
[his GitHub issue](https://github.com/rstudio/blogdown/issues/731) that allowed me
to discover [Plausible Analytics](https://plausible.io).

 ***<p style="text-align: center;">Thank you for reading this article and have fun!</p>***
