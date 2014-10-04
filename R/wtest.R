
##' coeftest is a function for performing Wald test of estimated coefficients.

##'
##' 
##' @title Testing Estimated Coefficients
##' @param object an object
##' @param testcoef 
##' @param null null hypothesis being tested (default 0)
##' @param vcov the variance to be used (default heteroskedastic robust)
##' @param type type of variance estimator
##' @return A list with test information
##' @author Giuseppe Ragusa
##' @export
wald_test <- function(object, testcoef = NULL, null, vcov = vcovHC, type = c("HC1", "const", "HC", 
                                                                           "HC0", "HC2", "HC3",
                                                                           "HC4", "HC4m", "HC5")) 
  {
  
  cobj <- coef(object)
  
  if(is.null(testcoef))
    testcoef <- names(cobj <- coef(object))
  
  if(missing(null))
    null <- rep(0, length(testcoef))
  
  betahat <- cobj[testcoef]
  q <- length(betahat)
    
  if(is.function(vcov)) {
    V <- vcov(object, type = type)[testcoef, testcoef]
  } else {
    V <- vcov[testcoef, testcoef]
  }
  
  Ft <- t(betahat-null)%*%solve(V)%*%(betahat-null)
  
  pvalue <- pchisq(Ft, q, lower.tail = FALSE)
  
  out <- structure(data.frame(
          q = q, 
          W = Ft, 
          pvalue = pvalue))
  
  cat('Wald test\n\n')
  cat("Null hypothesis:\n")
  cat(paste(testcoef, null, sep=" = "), sep='\n')
  cat('\n')
  
  print(format(out), row.names=FALSE)
  invisible(out)
  
}

Ftest <- wald_test
