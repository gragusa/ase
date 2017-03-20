##' Summarize regression objects
##'
##' \code{summary_rob} produces result summaries of the results of various model
##' fitting functions using as default heteroskedastic robust standard errors. 
##'
##' @param object an object for which a summary is desired.
##' @param alpha significance level for the Wald test.
##' @param type the type of heteroskedastic robust variance estimator.
##' @param omit_factor whether to omit factor in output.
##' @param cluster for the plm method cluster standard errors at the individual level.
##' @return A \code{summary_rob} object.
##' @author Giuseppe Ragusa
##' @export
##' 

summary_rob <- function(object, ...) {
  UseMethod("summary_rob")
}


#' @rdname summary_rob
#' @method summary_rob lm
#' @export summary_rob.lm
summary_rob.lm <- function(object, alpha = 0.05, type = c("HC1", "const", "HC", 
                                                       "HC0", "HC2", "HC3",
                                                       "HC4", "HC4m", "HC5"), 
                           omit_factor = NULL) {  
  type <- match.arg(type)
  b <- coeftest(object, vcov = vcovHC(object, type = type), df = Inf)
  ncoef <- nrow(b)
  factor_regressors <- names(class_regressors <- attributes(object$term)$dataClasses)
  factor_regressors <- factor_regressors[class_regressors=="factor"]
  
  
  if( length(factor_regressors) > 0) {  
    for (j in factor_regressors) {
      rownames(b) <- gsub(j, x=rownames(b), replacement = "")    
    }
  }
  
  sobj <- summary(object)
  
  if(!is.null(omit_factor)) {
    factor_omitted <- names(object$xlevel)
    if(!is.logical(omit_factor)) {
      factor_omitted <- na.omit(factor_omitted[match(factor_omitted, omit_factor)])
    }
    excl <- NULL
    for(j in 1:length(factor_omitted)) {
      excl <- c(excl, object$xlevel[[j]])
    }
    idx <- which(!is.na(match(rownames(b), excl)))
    b <- b[-idx,,drop=FALSE]
    sobj$factor_omitted <- factor_omitted
  }
  
  
  sobj$coefficients <- b
  ind <- is.na(b)

  sobj$fstatistic <- c(value=NA, numdf = NA, dendf = Inf)
  
  if(ncoef>1) {
    try({
    f <- waldtest(object, vcov=vcovHC(object, type = type), test = 'Chisq')
    sobj$fstatistic <- c(value=f$Chisq[2], numdf = abs(f$Df[2]), dendf = Inf)
    })
  }
  
  class(sobj) <- "summary_rob"
  sobj
}

#'
#' @rdname summary_rob
#' @method summary_rob glm
#' @export summary_rob.glm

summary_rob.glm <- function(object, alpha = 0.05, type = c("HC1", "const", "HC", 
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


#' @rdname summary_rob
#' @method summary_rob plm
#' @export summary_rob.plm


summary_rob.plm <- function(object, alpha = 0.05, cluster = FALSE, type = c("HC1", "const", "HC", 
                                                                        "HC0", "HC2", "HC3",
                                                                        "HC4", "HC4m", "HC5")) {
  type <- match.arg(type)
  if(cluster)
    out <- plm:::summary.plm(object, .vcov = plm:::vcovHC.plm(object, type=type, cluster = "group"))
  else
    out <- plm:::summary.plm(object, .vcov = plm:::vcovHC.plm(object, method = "white1", type=type))
  
  class(out) <- "summary_rob_plm"
  return(out)
}
          



