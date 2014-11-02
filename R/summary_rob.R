##' \code{summary_rob} produces result summaries of the results of various model
##' fitting functions using as default heteroskedastic robust standard errors. 
##'
##' 
##' @title Object Summaries
##' @param object an object for which a summary is desired.
##' @param alpha significance level for the Wald test 
##' @param type the type of heteroskedastic robust variance estimator
##' @return It depends
##' @author Giuseppe Ragusa
##' @export
summary_rob <- function(object, alpha = 0.05, type = c("HC1", "const", "HC", 
                                                       "HC0", "HC2", "HC3",
                                                       "HC4", "HC4m", "HC5")) {
  if(class(object)!="lm")
    stop("'summary_rob' only works on object of class 'lm'")
  type <- match.arg(type)
  b <- coeftest(object, vcov = vcovHC(object, type = type))
  
  factor_regressors <- names(class_regressors <- attributes(object$term)$dataClasses)
  factor_regressors <- factor_regressors[class_regressors=="factor"]
  
  
  if( length(factor_regressors) > 0) {  
    for (j in factor_regressors) {
      rownames(b) <- gsub(j, x=rownames(b), replacement = "")    
    }
  }
  
  sobj <- summary(object)
  sobj$coefficients <- b
  ind <- is.na(b)
  
  if(nrow(b)>1) {
    f <- waldtest(object, vcov=vcovHC(object, type = type), test = 'Chisq')
    sobj$fstatistic <- c(value=f$Chisq[2], numdf = abs(f$Df[2]), dendf = Inf)
  } else {
    sobj$fstatistic <- c(value=NA, numdf = NA, dendf = Inf)
  }
    
  class(sobj) <- "summary_rob"
  sobj
}
