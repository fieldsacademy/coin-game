# App to play coin game in R shiny
# Author: Emma Kroell
# Last updated: October 6, 2022
#
# References:
# Attali, Dan (2022). Need any more reason to love R-Shiny? Here: you can even use
#    Shiny to create simple games! https://deanattali.com/blog/shiny-game-lightsout/.
# Wickham, Hadley (2020). Mastering Shiny. https://mastering-shiny.org/index.html.

# Packages
library(shiny)
library(shinyjs)
library(tidyverse)

# source helper functions
source("coin_game_shiny.R")

ui <- fluidPage(
  titlePanel(
    # app title
    "Coin game"
  ),
  sidebarLayout(
    sidebarPanel(
      # inputs
      useShinyjs(),   # lets us do cool shiny stuff like hide and show inputs
      numericInput("n","Number of coins",16,min=4,max=50),   # user chooses number of coins
      numericInput("k","Max removed per turn",3,min=2,max=7),   # user chooses max turn removal
      selectInput("firstplay", "Who plays first?", c("Me", "Computer")),
      actionButton("start","Start Game"),
      hidden(radioButtons("move","Your move", seq(1,3),
                          selected = character(0))),  # make this depend on k
      hidden(textOutput("text")),
    ),
    mainPanel(plotOutput("coinplot"))
      # outputs
    )
  )

server <- function(input, output,session) {

  values <- reactiveValues(
    n = NULL,   # Number of coins
    k = NULL,   # Number of possible removals per turn
  )

  # START GAME
  observeEvent(input$start,{
    hide("text")
    values$n <- as.numeric(input$n)
    values$k <- as.numeric(input$k)
    # plot initial coins
    output$coinplot <- renderPlot({
      if (is.numeric(values$n)) plot_coins(input$n,values$n)
    }, height=400)

    # If the computer starts:
    if (input$firstplay == "Computer") {
      # computer move
      delay(600, {
        values$n <- computer_move(values$n,values$k)

        if (values$n == 0){
          # computer wins
          output$coinplot <- renderPlot({
            ggplot() + theme_void() +
              annotate("text", x=2.5, y=2.5, label= "You lose :(", size = 20)
          }, height=400)
          hide("move")
        } else{
          output$coinplot <- renderPlot({
            plot_coins(input$n,values$n)
          }, height=400)
        }
        show("text")
        output$text <- renderText({ paste("Computer moves.",values$n, "coins left.") })
      })

    }
    # show options for player to click
     # update buttons first
     updateRadioButtons(session,"move","Your move",
                        seq(1,values$k),selected = character(0))
    show("move")
    })

  # PLAYER MOVES
  observeEvent(input$move,{
    if (input$move > 0) {
      # player move
      n_player <- values$n - as.numeric(input$move)

      if (n_player == 0){
        # player wins
        output$coinplot <- renderPlot({
          ggplot() + theme_void() +
            annotate("text", x=2.5, y=2.5, label= "You win :D", size = 20)
        }, height=400)
        hide("move")
      } else {
        output$coinplot <- renderPlot({
          plot_coins(input$n,n_player)
        }, height=400)


        # computer move
        delay(600, {
          values$n <- computer_move(n_player,values$k)
          # show("text")
          # output$text <- renderText({ paste("Computer moves.",values$n, "coins left.") })
          if (values$n == 0){
            # computer wins
            output$coinplot <- renderPlot({
              ggplot() + theme_void() +
                annotate("text", x=2.5, y=2.5, label= "You lose :(", size = 20)
            }, height=400)
            hide("move")
          } else{
            output$coinplot <- renderPlot({
              plot_coins(input$n,values$n)
            }, height=400)
          }

          # reset buttons for next player move
          # check if less than k coins left, if so show less buttons
          if (values$n < values$k){
            updateRadioButtons(session,"move","Your move",
                               seq(1,values$n),selected = character(0))
          } else {
            # otherwise show k buttons
            updateRadioButtons(session,"move","Your move",
                               seq(1,values$k),selected = character(0))
          }
          show("text")
          output$text <- renderText({ paste("Computer moves.",values$n, "coins left.") })
        })
      }
      }})

}

shinyApp(ui, server)
