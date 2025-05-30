---
title: 'The decennial Census with tidycensus'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How do you import decennial Census data into R Studio using *tidycensus*?
- How do you process, query, wrangle, and visualize decennial Census data once it is imported into R Studio? 

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain how to use *tidycensus* to import decennial Census data at various geographic scales, and various temporal periods, into your R Studio environment. 
- Process and query decennial Census data to explore simple questions, using the *dplyr* package 
- Visualize decennial Census data using the *ggplot2* and *tmap packages
- Export decennial Census datasets and visualizations from your R Studio environment to a local directory in various file formats. 

::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction


``` r
library(tidycensus)
library(tmap)
library(tidyverse)
```



## Retrieving decennial Census data


``` r
# loads variable table for 2010 decennial census and assigns it to object named
# "decennial_variables_2010"
 decennial_variables_2010<-load_variables(2010, "sf1")
```




``` r
# prints "decennial_variables_2010"
decennial_variables_2010
```

``` output
# A tibble: 8,959 × 3
   name    label                                concept         
   <chr>   <chr>                                <chr>           
 1 H001001 Total                                HOUSING UNITS   
 2 H002001 Total                                URBAN AND RURAL 
 3 H002002 Total!!Urban                         URBAN AND RURAL 
 4 H002003 Total!!Urban!!Inside urbanized areas URBAN AND RURAL 
 5 H002004 Total!!Urban!!Inside urban clusters  URBAN AND RURAL 
 6 H002005 Total!!Rural                         URBAN AND RURAL 
 7 H002006 Total!!Not defined for this file     URBAN AND RURAL 
 8 H003001 Total                                OCCUPANCY STATUS
 9 H003002 Total!!Occupied                      OCCUPANCY STATUS
10 H003003 Total!!Vacant                        OCCUPANCY STATUS
# ℹ 8,949 more rows
```


``` r
# brings up "decennial_variables_2010" in data Viewer
View(decennial_variables_2010)
```


<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; overflow-x: scroll; width:100%; "><table class="table table-striped" style="width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;color: white !important;background-color: rgba(51, 51, 51, 255) !important;position: sticky; top:0; background-color: #FFFFFF;"> name </th>
   <th style="text-align:left;color: white !important;background-color: rgba(51, 51, 51, 255) !important;position: sticky; top:0; background-color: #FFFFFF;"> label </th>
   <th style="text-align:left;color: white !important;background-color: rgba(51, 51, 51, 255) !important;position: sticky; top:0; background-color: #FFFFFF;"> concept </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> H001001 </td>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:left;"> HOUSING UNITS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H002001 </td>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:left;"> URBAN AND RURAL </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H002002 </td>
   <td style="text-align:left;"> Total!!Urban </td>
   <td style="text-align:left;"> URBAN AND RURAL </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H002003 </td>
   <td style="text-align:left;"> Total!!Urban!!Inside urbanized areas </td>
   <td style="text-align:left;"> URBAN AND RURAL </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H002004 </td>
   <td style="text-align:left;"> Total!!Urban!!Inside urban clusters </td>
   <td style="text-align:left;"> URBAN AND RURAL </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H002005 </td>
   <td style="text-align:left;"> Total!!Rural </td>
   <td style="text-align:left;"> URBAN AND RURAL </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H002006 </td>
   <td style="text-align:left;"> Total!!Not defined for this file </td>
   <td style="text-align:left;"> URBAN AND RURAL </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H003001 </td>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:left;"> OCCUPANCY STATUS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H003002 </td>
   <td style="text-align:left;"> Total!!Occupied </td>
   <td style="text-align:left;"> OCCUPANCY STATUS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H003003 </td>
   <td style="text-align:left;"> Total!!Vacant </td>
   <td style="text-align:left;"> OCCUPANCY STATUS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H004001 </td>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:left;"> TENURE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H004002 </td>
   <td style="text-align:left;"> Total!!Owned with a mortgage or a loan </td>
   <td style="text-align:left;"> TENURE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H004003 </td>
   <td style="text-align:left;"> Total!!Owned free and clear </td>
   <td style="text-align:left;"> TENURE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H004004 </td>
   <td style="text-align:left;"> Total!!Renter occupied </td>
   <td style="text-align:left;"> TENURE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H005001 </td>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:left;"> VACANCY STATUS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H005002 </td>
   <td style="text-align:left;"> Total!!For rent </td>
   <td style="text-align:left;"> VACANCY STATUS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H005003 </td>
   <td style="text-align:left;"> Total!!Rented, not occupied </td>
   <td style="text-align:left;"> VACANCY STATUS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H005004 </td>
   <td style="text-align:left;"> Total!!For sale only </td>
   <td style="text-align:left;"> VACANCY STATUS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H005005 </td>
   <td style="text-align:left;"> Total!!Sold, not occupied </td>
   <td style="text-align:left;"> VACANCY STATUS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H005006 </td>
   <td style="text-align:left;"> Total!!For seasonal, recreational, or occasional use </td>
   <td style="text-align:left;"> VACANCY STATUS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H005007 </td>
   <td style="text-align:left;"> Total!!For migrant workers </td>
   <td style="text-align:left;"> VACANCY STATUS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H005008 </td>
   <td style="text-align:left;"> Total!!Other vacant </td>
   <td style="text-align:left;"> VACANCY STATUS </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H006001 </td>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:left;"> RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H006002 </td>
   <td style="text-align:left;"> Total!!Householder who is White alone </td>
   <td style="text-align:left;"> RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H006003 </td>
   <td style="text-align:left;"> Total!!Householder who is Black or African American alone </td>
   <td style="text-align:left;"> RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H006004 </td>
   <td style="text-align:left;"> Total!!Householder who is American Indian and Alaska Native alone </td>
   <td style="text-align:left;"> RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H006005 </td>
   <td style="text-align:left;"> Total!!Householder who is Asian alone </td>
   <td style="text-align:left;"> RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H006006 </td>
   <td style="text-align:left;"> Total!!Householder who is Native Hawaiian and Other Pacific Islander alone </td>
   <td style="text-align:left;"> RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H006007 </td>
   <td style="text-align:left;"> Total!!Householder who is Some Other Race alone </td>
   <td style="text-align:left;"> RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H006008 </td>
   <td style="text-align:left;"> Total!!Householder who is Two or More Races </td>
   <td style="text-align:left;"> RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H007001 </td>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:left;"> HISPANIC OR LATINO ORIGIN OF HOUSEHOLDER BY RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H007002 </td>
   <td style="text-align:left;"> Total!!Not Hispanic or Latino householder </td>
   <td style="text-align:left;"> HISPANIC OR LATINO ORIGIN OF HOUSEHOLDER BY RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H007003 </td>
   <td style="text-align:left;"> Total!!Not Hispanic or Latino householder!!Householder who is White alone </td>
   <td style="text-align:left;"> HISPANIC OR LATINO ORIGIN OF HOUSEHOLDER BY RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H007004 </td>
   <td style="text-align:left;"> Total!!Not Hispanic or Latino householder!!Householder who is Black or African American alone </td>
   <td style="text-align:left;"> HISPANIC OR LATINO ORIGIN OF HOUSEHOLDER BY RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H007005 </td>
   <td style="text-align:left;"> Total!!Not Hispanic or Latino householder!!Householder who is American Indian and Alaska Native alone </td>
   <td style="text-align:left;"> HISPANIC OR LATINO ORIGIN OF HOUSEHOLDER BY RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H007006 </td>
   <td style="text-align:left;"> Total!!Not Hispanic or Latino householder!!Householder who is Asian alone </td>
   <td style="text-align:left;"> HISPANIC OR LATINO ORIGIN OF HOUSEHOLDER BY RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H007007 </td>
   <td style="text-align:left;"> Total!!Not Hispanic or Latino householder!!Householder who is Native Hawaiian and Other Pacific Islander alone </td>
   <td style="text-align:left;"> HISPANIC OR LATINO ORIGIN OF HOUSEHOLDER BY RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H007008 </td>
   <td style="text-align:left;"> Total!!Not Hispanic or Latino householder!!Householder who is Some Other Race alone </td>
   <td style="text-align:left;"> HISPANIC OR LATINO ORIGIN OF HOUSEHOLDER BY RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H007009 </td>
   <td style="text-align:left;"> Total!!Not Hispanic or Latino householder!!Householder who is Two or More Races </td>
   <td style="text-align:left;"> HISPANIC OR LATINO ORIGIN OF HOUSEHOLDER BY RACE OF HOUSEHOLDER </td>
  </tr>
  <tr>
   <td style="text-align:left;"> H007010 </td>
   <td style="text-align:left;"> Total!!Hispanic or Latino householder </td>
   <td style="text-align:left;"> HISPANIC OR LATINO ORIGIN OF HOUSEHOLDER BY RACE OF HOUSEHOLDER </td>
  </tr>
</tbody>
</table></div>




## Cleaning and processing decennial Census datasets

## Visualizing decennial Census data with *ggplot2*

## Mapping decennial Census data with *tmap*

## Working with multiple Census datasets

## Exporting decennial Census datasets and analysis products from R Studio


This is a lesson created via The Carpentries Workbench. It is written in
[Pandoc-flavored Markdown][pandoc] for static files (with extension `.md`) and
[R Markdown][r-markdown] for dynamic files that can render code into output
(with extension `.Rmd`). Please refer to the [Introduction to The Carpentries
Workbench][carpentries-workbench] for full documentation.

What you need to know is that there are three sections required for a valid
Carpentries lesson template:

 1. `questions` are displayed at the beginning of the episode to prime the
    learner for the content.
 2. `objectives` are the learning objectives for an episode displayed with
    the questions.
 3. `keypoints` are displayed at the end of the episode to reinforce the
    objectives.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

Inline instructor notes can help inform instructors of timing challenges
associated with the lessons. They appear in the "Instructor View"

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: challenge 

## Challenge 1: Can you do it?

What is the output of this command?

```r
paste("This", "new", "lesson", "looks", "good")
```

:::::::::::::::::::::::: solution 

## Output
 
```output
[1] "This new lesson looks good"
```

:::::::::::::::::::::::::::::::::


## Challenge 2: how do you nest solutions within challenge blocks?

:::::::::::::::::::::::: solution 

You can add a line with at least three colons and a `solution` tag.

:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::

## Figures

You can include figures generated from R Markdown:


``` r
pie(
  c(Sky = 78, "Sunny side of pyramid" = 17, "Shady side of pyramid" = 5), 
  init.angle = 315, 
  col = c("deepskyblue", "yellow", "yellow3"), 
  border = FALSE
)
```

<div class="figure" style="text-align: center">
<img src="fig/01-decennial-census-rendered-pyramid-1.png" alt="pie chart illusion of a pyramid"  />
<p class="caption">Sun arise each and every morning</p>
</div>
Or you can use pandoc markdown for static figures with the following syntax:

`![optional caption that appears below the figure](figure url){alt='alt text for
accessibility purposes'}`

![You belong in The Carpentries!](https://raw.githubusercontent.com/carpentries/logo/master/Badge_Carpentries.svg){alt='Blue Carpentries hex person logo with no text.'}

## Math

One of our episodes contains $\LaTeX$ equations when describing how to create
dynamic reports with {knitr}, so we now use mathjax to describe this:

`$\alpha = \dfrac{1}{(1 - \beta)^2}$` becomes: $\alpha = \dfrac{1}{(1 - \beta)^2}$

Cool, right?

::::::::::::::::::::::::::::::::::::: keypoints 

- Use `.md` files for episodes when you want static content
- Use `.Rmd` files for episodes when you need to generate output
- Run `sandpaper::check_lesson()` to identify any issues with your lesson
- Run `sandpaper::build_lesson()` to preview your lesson locally

::::::::::::::::::::::::::::::::::::::::::::::::

