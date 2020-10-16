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
    <p> In the midst of the pandemic, I had to get out of my usual state of mind to celebrate - throw a party and get drunk. As many states near Texas required any traveling Texas residents to quarantine 2 weeks when they arrive at their states, I've decided to get to know more about Texas. And naturally, it came to my mind that I wanted to conquer the highest point in Texas, before I go to other states and climb mountains. <br />
    Where I live, Austin, is quite flat and I did not expect Texas to have quite high elevation until I looked up the 'highest point in Texas'. </p>
    <iframe width="900" height="800" frameborder="0" scrolling="no" src="//plotly.com/~elainewonlee/1.embed"></iframe>
    <p>I scraped the data from <a href="https://public-nps.opendata.arcgis.com/">Wikipedia page</a> with very simple Python code</p>
    <h3>Preformatted</h3>
    <pre><code>import pandas as pd
      url='https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_elevation'
      df=pd.read_html(url, header=0)[0]i = 0;
    </code></pre>
    <p>Then used Plotly in R to make the interactive plot.</p>
    <a href="03_uspark.html" class="button big">Stay tuned!</a>