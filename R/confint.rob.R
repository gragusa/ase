
##' Computes confidence intervals for one or more parameters in a fitted
##' model. There is a default and a method for objects inheriting from class
##' "\code{lm}".
##'
##' \code{confint_rob} assumes asymptotic normality of the estimators of the parameters for
##' the fitted models, but does not assume conditional homoskedasticity.
##' 
##' @title Confidence Intervals for Model Parameters
##' @param object a fitted model object. 
##' @param parm a specification of which parameters are to be given confidence
##' intervals, either a vector of numbers or a vector of names. If missing, all
##' parameters are considered.
##' @param level the confidence level required.
##' @param type 

##' @return A matrix (or vector) with columns giving lower and upper confidence
##' limits for each parameter. These will be labelled as (1-level)/2 and 1 -
##' (1-level)/2 in \% (by default 2.5\% and 97.5\%).
##' @author Giuseppe Ragusa
##' @export
confint_rob <- function (object, parm, level = 0.95, type = c("HC1", "const", "HC", 
                                                              "HC0", "HC2", "HC3",
                                                              "HC4", "HC4m", "HC5") ) {
  cf <- coef(object)
  pnames <- names(cf)
  if (missing(parm)) 
    parm <- pnames
  else if (is.numeric(parm)) 
    parm <- pnames[parm]
  a <- (1 - level)/2
  a <- c(a, 1 - a)
  fac <- qnorm(a)
  pct <- paste(format(100 * a, trim = TRUE, scientific = FALSE, digits = 3), "%")
  ci <- array(NA, dim = c(length(parm), 2L), dimnames = list(parm, pct))
  ses <- sqrt(diag(vcovHC(object, type = type)))[parm]
  ci[] <- cf[parm] + ses %o% fac
  ci
}
