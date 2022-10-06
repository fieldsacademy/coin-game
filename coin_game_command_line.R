# Coin game
# allows for command line play of the coin game
# Author: Emma Kroell
# Last updated: October 6, 2022

# interactive command line player move
player_move <- function(n,k){
  # ask player how many to remove (need to provide less options if n < k)
  if (n < k){
    move <- menu(paste0(1:n," (leave ", n - 1:n," items remaining)"),
                 title = "How much do you remove?")
  } else{
    move <- menu(paste0(1:k," (leave ", n - 1:k," items remaining)"),
                 title = "How much do you remove?")
  }
  # update total
  n <- n - move
  # print updated total
  cat(n, "coins left. \n")

  return(n)
}

# play coin game in the command line
play_coin_game <- function(n,k){
  cat("Game starts with ", n, "coins. \n")

  whose_move <- c("Me", "You")
  move_choice <- menu(whose_move, title = "Who should go first?")

  if (move_choice == 1){
    while(n > 0){
      n <- player_move(n,k)
      if (n == 0) {
        cat("You win! :D")
        break
      }
      cat("Computer moves.\n")
      n <- computer_move(n,k)
      cat(n, "coins left. \n")
      if (n == 0) cat("You lose :(")
    }
  } else {
    while(n > 0){
      cat("Computer moves.\n")
      n <- computer_move(n,k)
      cat(n, "coins left. \n")
      if (n == 0) {
        cat("You lose :(")
        break
      }
      n <- player_move(n,k)
      if (n == 0) cat("You win! :D")
    }
  }

}


