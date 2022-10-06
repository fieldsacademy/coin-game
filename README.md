# coin-game

Code to implement coin game in R, and create R shiny app.
Play the game here: https://fieldsacademy.shinyapps.io/coin-game/

# Game rules
This is a two-player games. You have 16 coins in a pile. You and your opponent take turns removing 1, 2, or 3 coins from the pile.
The winner is the person who removes the last coin. 

The app allows you to change the number of coins in the pile at the start of the game, the maximum number a player can remove on their turn, and
who goes first (you or the computer).

The goal is to have the user reflect upon the following questions:
- What is your strategy when playing? Is it working?
- Is there a guaranteed winning strategy?
- Does it matter who plays first?
- What happens if you change the number of coins in the initial pile?
- What happens if you change how many coins a player can remove in a turn?

# Authorship
This code and app was developed for the Fields Academy at The Fields Instutute for Research in Mathematical Sciences.
Author: Emma Kroell, https://www.emmakroell.ca
Copyright: The Fields Instutute for Research in Mathematical Sciences, http://www.fields.utoronto.ca/activities/academy

# References
Attali, Dean (2016). Need any more reason to love R-Shiny? Here: you can even use Shiny to create simple games!
   https://deanattali.com/blog/shiny-game-lightsout/.
Attali, Dean (2021). shinyjs: Easily Improve the User Experience of Your Shiny Apps in Seconds. R package version 2.1.0.
   https://CRAN.R-project.org/package=shinyjs
Chang, Winston, Joe Cheng, JJ Allaire, Carson Sievert, Barret Schloerke, Yihui Xie, Jeff Allen, Jonathan McPherson, Alan Dipert
   and Barbara Borges (2021). shiny: Web Application Framework for R. R package version 1.7.1. https://CRAN.R-project.org/package=shiny
Wickham, Hadley (2020). Mastering Shiny. https://mastering-shiny.org/index.html.
