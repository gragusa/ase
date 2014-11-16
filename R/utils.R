trim <- function(x, q = 0.01) {
  qq <- quantile(x, p=c(q, 1-q))
  x[x>qq[1] & x<qq[2]]
}

capply <- function(str, ff) 
  sapply(lapply(strsplit(str, NULL), ff), paste, collapse="") 

cap <- function(char) {
  ## change lower letters to upper, others leave unchanged
  if (any(ind <- letters==char)) LETTERS[ind]    else char 
}

capitalize <- function(str) { # vector of words
  ff <- function(x) paste(lapply(unlist(strsplit(x, NULL)),cap),collapse="")
  capply(str,ff) 
}

lower <- function(char) {
  ## change upper letters to lower, others leave unchanged
  if (any(ind <- LETTERS==char)) letters[ind]    else char 
}

lowerize <- function(str) {
  ff <- function(x) paste(lapply(unlist(strsplit(x, NULL)),lower),collapse="")
  capply(str,ff) 
}
