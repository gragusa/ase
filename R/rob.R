rob <- function(object, alpha = 0.05) {
  b <- coeftest(object, vcov = vcovHC)
  k <- nrow(b)
  cii <- matrix(0, k, 2)
  for (i  in  1:k) {
    cii[i,]<-  c(b[i,1] + qnorm(alpha/2)*b[i,2] , b[i,1] - qnorm(alpha/2)*b[i,2])
  }
  colnames(cii) <- c(paste("",alpha/2*100 ,"%"),
                     paste("",100 - alpha/2*100 ,"%"))
  cbind(b,cii)
}
