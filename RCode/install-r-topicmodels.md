---
layout: post
title: "Installing topicmodels - \"fatal error: 'gsl/gsl_rng.h'\""
date: 2021-11-30
tags: [R, topicmodels]
---

I recently tried to install the [topicmodels R package](https://cran.r-project.org/web/packages/topicmodels/index.html) (v0.2-3) on my PC with Ubuntu 20.04.3 LTS 
I ran the following command in R:

~~~r
install.packages("topicmodels")
~~~

Only to be met with the following errors:

~~~
ctm.c:29:10: fatal error: 'gsl/gsl_rng.h' file not found
#include <gsl/gsl_rng.h>
~~~

The topicmodels R package actually depends on the [GNU scientific library (GSL)](http://www.gnu.org/software/gsl/). You can:

- Download [gsl-latest.tar.gz](ftp://ftp.gnu.org/gnu/gsl/gsl-latest.tar.gz) from the [GSL ftp site](ftp://ftp.gnu.org/gnu/gsl/) and unzip it anywhere (e.g. /Downloads)
- Open the unzipped `gsl` folder in Terminal (e.g. `cd ~/Downloads/gsl-2.4`
- Run `sudo ./configure && make && make install`

If the above gives a "permission denied" error, instead try
```bash
sudo make clean
sudo chown -R $USER .
./configure && make
sudo make install
```
