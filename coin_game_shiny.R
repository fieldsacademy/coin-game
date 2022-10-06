# Coin game
# helper functions for app.R
# Author: Emma Kroell
# Last updated: October 6, 2022

# implements computer's turn
# optimal move if possible, otherwise random move
computer_move <- function(n,k){
  # if n mod (k+1) = 0, then there is nothing we can do => random move
  if (n %% (k+1) == 0) {
    n <- n - sample(1:k,1)   # remove a random amount
  } else {
    # we are in a winning position since n mod (k+1) \neq 0
    # remove enough so that n mod (k+1) = 0
    remainder <- n %% (k+1)
    n <- n - remainder
  }
  return(n)
}


# plot the coins
# needed for shiny app
plot_coins <- function(n_og,n){
  # set dimensions for square array
  square_length <- ceiling(sqrt(n_og))

  # fill in coins
  x <- rep(1:square_length,each=square_length)[1:n] * 0.75
  y <- rep(seq(1,square_length),square_length)[1:n]

  # make plots
  as_tibble(cbind(x,y)) |>
    ggplot(aes(x,y)) + geom_point(size=20,colour="darkgoldenrod3") +
    xlim(c(0.5, 0.75 *(square_length+0.5))) + ylim(c(0.5,square_length+0.5)) + theme_void()

}

