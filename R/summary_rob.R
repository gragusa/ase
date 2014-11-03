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
##' 
##' 

summary_rob <- function(obj, ...) {
  UseMethod("summary_rob")
}

#' @return \code{NULL}
#'
#' @rdname summary_rob
#' @method summary_rob lm
#' @S3method summary_rob lm
#' @export
summary_rob.lm <- function(object, alpha = 0.05, type = c("HC1", "const", "HC", 
                                                       "HC0", "HC2", "HC3",
                                                       "HC4", "HC4m", "HC5")) {  
  type <- match.arg(type)
  b <- coeftest(object, vcov = vcovHC(object, type = type), df = Inf)
  
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


#' @return \code{NULL}
#'
#' @rdname summary_rob
#' @method summary_rob plm
#' @S3method summary_rob plm
#' @export

summary_rob.plm <- function(obj, alpha = 0.05, cluster = FALSE, type = c("HC1", "const", "HC", 
                                                                        "HC0", "HC2", "HC3",
                                                                        "HC4", "HC4m", "HC5")) {
  type <- match.arg(type)
  if(cluster)
    obj <- plm:::summary.plm(obj, .vcov = plm:::vcovHC.plm(obj, type=type, cluster = "group"))
  else
    obj <- plm:::summary.plm(obj, .vcov = plm:::vcovHC.plm(obj, method = "white1", type=type))
  
  class(obj) <- "summary_rob_plm"
  return(obj)
}
          



