---
layout: post
title: 'Which state has the highest elevation in US?'
landing-title: 'Highest and lowest elevation of each state'
nav-menu: false
description: null
author: "Won Lee"
show_tile: false
---
<head>
<style>
p {
  font-size: 20px;
}
</style>
</head>
<body>
<!-- One -->
<section id="one">
	<div class="inner">
    <h4>Posted on: 2020-10-16</h4>
    <p> In the midst of the pandemic, I had to get out of my usual state of mind for any kind of celebration - throw a party and get drunk. As many states near Texas required any traveling Texas residents to quarantine 2 weeks when they arrive at their states, I've decided to get to know more about Texas. And naturally, it came to my mind that I wanted to conquer the highest point in Texas, before I go to other states and climb mountains. <br />
    Where I live, Austin, is quite flat and I did not expect Texas to have quite high elevation until I looked up the 'highest point in Texas'. </p>
    <iframe width="900" height="800" frameborder="0" scrolling="no" src="//plotly.com/~elainewonlee/1.embed"></iframe>
    <p>I scraped the data from <a href="https://public-nps.opendata.arcgis.com/">Wikipedia page</a> with very simple Python code</p>
    <h4>Python code used for scraping wiki code</h4>
    <pre><code>import pandas as pd
      url='https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_elevation'
      df=pd.read_html(url, header=0)[0]i = 0;</code></pre>
    <p>Then used Plotly in R to make the interactive plot. I made the plot in R first using below code</p>
    <h4>R code used for plotting the interactive plot</h4>
    <pre><code>
    library(tidyverse)
    library(plotly)
    df %>% 
  rename(State = `Statefederal district or territory`) %>% 
  filter(State != "United States") %>%  # get rid of redundant info
  filter(!grepl('Islands',State)) %>% 
  filter(State %notin% c('Guam','Puerto Rico','American Samoa')) %>% 
  mutate(`Highest point` = gsub('\\[.*' , '', `Highest point`), # delete citation label from wiki
         `Lowest point` = gsub('\\[.*' , '', `Lowest point`),
         `Highest elevation` = as.numeric(str_sub(gsub('\\m.*', '', `Highest elevation`),1,-2)),
         `Lowest elevation` = as.numeric(str_sub(gsub('\\m.*', '', gsub('.*ft', '', `Lowest elevation`)),1,-2))) %>% 
  mutate(`Lowest elevation` = ifelse(is.na(`Lowest elevation`),0,`Lowest elevation`)) %>%  #replace NA value 
  arrange(desc(`Highest elevation`)) %>% 
  mutate(id = seq_along(State)) %>% 
  mutate(State = fct_reorder(State,desc(`Highest elevation`))) %>% 
  mutate(`Elevation span` = `Highest elevation` - `Lowest elevation`) %>%
  rename(`Highest elevation (m)` = `Highest elevation`,
         `Lowest elevation (m)` = `Lowest elevation`,
         `Elevation span (m)` = `Elevation span`) %>% 
  ggplot()+
  geom_bar(aes(x = State,
               y = `Highest elevation (m)`,
               fill = `Elevation span (m)`),
           stat = 'identity',
           color = NA)+
  geom_bar(aes(x = State,
               y = `Lowest elevation (m)`),
               stat = 'identity', 
           fill = 'white', 
           color = 'white')+
  geom_hline(yintercept = 0, 
             color = 'dodgerblue', 
             size = 1.5)+
  labs(x = '',
       y = '',
       title = 'The highest and lowest elevation by each state (m)',
       fill = 'Elevation \nspan (m)')+
  theme_minimal()+
  scale_fill_viridis(option = 'D')+
  theme(axis.text.x = element_text(angle = 90,size = rel(1.5)),
        axis.text.y = element_text(size = rel(1.4)),
        plot.title = element_text(size = rel(2)),
        panel.grid.major.x = element_blank(),
        legend.position = 'right')  -> p

ggplotly(p) -> myplotly </code></pre>
    <p>Then I uploaded the plot to my Plotly account, then embedded the plot link (iframe link provided on the Plotly account dashboard) in this post. </p>
    <h4>R code used to upload my plot to my Plotly account</h4>
    <pre><code>Sys.setenv('plotly_username'='##USERNAME##')
    Sys.setenv('plotly_api_key'='##API_KEY##')
    api_create(myplotly, filename = 'state_elevation',fileopt='overwrite')</code></pre>
    <p>P.S. Before I finish, I have to say I hate the 'Medium - Towards Data Science' posts. I bet they all have useful information, but why do I have to pay 5$ monthly, when I can get free information elsewhere if I do my diligence just for like 5 second more?</p>
    <a href="03_uspark.html" class="button big">Stay tuned!</a>