tsls2 <- function (y, X, Z, names=NULL, weights,
                   cluster=NULL, ...) {
  n <- length(y)
  p <- ncol(X)
  if(missing(weights)||is.null(weights)) {
    rep.weights <- FALSE
    weights <- rep(1,n) }
  else {
    if(!is.null(weights) && !is.numeric(weights) ) 
      stop("'weights' must be a numeric vector")
    if(length(weights)!=n)
      stop("'weights' not of right length")
    rep.weights <- TRUE
  }
  
  w <- weights/sum(weights)*n
  D <- diag(w)
  invZtZ <- solve(crossprod(D%*%Z,Z))
  XtZ <- crossprod(D%*%X, Z)
  V <- solve(XtZ %*% invZtZ %*% t(XtZ))
  
  A <- V %*% XtZ %*% invZtZ
  b <- A %*% crossprod(D%*%Z, y)
  residuals <- (y - X %*% b)  
  meat <- crossprod(Z*c(residuals))
  V <- A%*%meat%*%t(A)
  result<-list()
  result$n <- n
  result$p <- p
  b <- as.vector(b)
  names(b) <- names
  result$coefficients <- b  
  result$residuals <- as.vector(residuals)
  result$response <- y
  result$model.matrix <- X 
  result$instruments <- Z
  result$vcov <- V
  result$cluster <- cluster
  result$s2 <- sum(residuals^2)/(n-p)
  if(rep.weights)
    result$weights <- weights
  result
}

ivregdefault <- function(y, X, Z, names=colnames(X), weights,
                         method = "tsls", start, ...)
{
  if(missing(weights))
    weights <- rep(1, length(y))
  if(any(weights)<0)
    stop('negative weights are not allowed')
  
  ## if(missing(cluster))
  ##   cluster <- rep(1, length(y))
  
  if((length(y)!=NROW(X))|(length(y)!=NROW(Z))|(NROW(Z)!=NROW(X)))
    stop('mismetch')
  
  if(NCOL(X)>NCOL(Z))
    stop('order condition is not satisfied, NCOL(X)>NCOL(Z)')
  
  if(!is.function(method)&!is.character(method))
    stop("'method' is wrong")
  
  args <- list(...)
  
  lm <- try(lowerize(method), silent = TRUE)
  
  if(is.null(start) & lm != 'tsls')
    start <- tsls2(y,X,Z,names=names, weights=weights)$coef
  
  momfiv <- function(b) 
    Z*c(y-X%*%b)
  dmomfiv <- function(b, weights = 1) 
    crossprod(Z * c(weights), -X)
  data <- list(y = y, X = X, Z = Z)
  
  out <- if(is.function(method) && !is.null(method()$family)) 
    mdest(momfiv, start = start,
          dmomfun = dmomfiv, weights = weights, mdfamily = method, ...)
  else 
    switch(lowerize(method),
           tsls = tsls2(y,X,Z,names = names, weights = weights)
           ## liml = tsls2(y,X,Z,names = names, weights = weights)          ,
           ## gmm = gmmest(momfiv, start = start, data = data,
           ##              dmomfun = dmomfiv, weights = weights, ...),
           ## el = mdest(momfiv, start = start, data = data,
           ##            dmomfun = dmomfiv, weights = weights, mdfamily = mdel, ...),
           ## et = mdest(momfiv, start = start, data = data,
           ##            dmomfun = dmomfiv, weights = weights, mdfamily = mdet, ...),
           ## cue = mdest(momfiv, start = start, data = data,
           ##             dmomfun = dmomfiv, weights = weights, mdfamily = mdcue, ...),
           ## ht = mdest(momfiv, start = start, data = data,
           ##            dmomfun = dmomfiv, weights = weights, mdfamily = mdht, ...),
           ## qt = mdest(momfiv, start = start, data = data,
           ##            dmomfun = dmomfiv, weights = weights, mdfamily = mdqt, ...)
    )
}    

##' Estimate IV models
##'
##' Details
##' @title ivreg

##' @param formula an object of class "formula" (or one that can be coerced to
##' that class): a symbolic description of the model to be fitted. The details of
##' model specification are given under ‘Details’.

##' @param instruments an object of class "formula" (or one that can be coerced to
##' that class): a symbolic description of the instruments to be used.

##' @param data an optional data frame, list or environment (or object
##' coercible by as.data.frame to a data frame) containing the variables in the
##' model. If not found in data, the variables are taken from
##' environment(formula), typically the environment from which lm is called.

##' @param subset an optional vector specifying a subset of observations to be
##' used in the fitting process.

##' @param weights an optional vector of weights to be used in the fitting
##' process. Should be NULL or a numeric vector. If non-NULL, weighted least
##' squares is used with weights weights (that is, minimizing sum(w*e^2));
##' otherwise ordinary least squares is used. See also ‘Details’,

##' @param na.action a function which indicates what should happen when the
##' data contain NAs. The default is set by the na.action setting of options, and
##' is na.fail if that is unset. The ‘factory-fresh’ default is na.omit. Another
##' possible value is NULL, no action. Value na.exclude can be useful.


##' @param contrasts an optional list. See the contrasts.arg of model.matrix.default.

##' @param method the method to be used. 

##' @param start initial values. Needed only when methods is different than "tsls" or "gmm" 
##' @param ... other arguments
##' @rdname ivreg
##' @return \code{NULL}
##' @export ivreg
ivreg <- function (formula, instruments, data, subset, weights,
                   na.action, contrasts = NULL,
                   method = "tsls", start = NULL,...) {
  if (missing(na.action))
    na.action <- options()$na.action
  m <- match.call(expand.dots = FALSE)
  
  mf <- match(c("formula", "instruments", "data", "subset", "weights", "na.action", 
                "contrast", "cluster"), names(m), 0L)
  m <- m[c(1L, mf)]
  m$drop.unused.levels <- TRUE
  if (is.matrix(eval(m$data, sys.frame(sys.parent()))))
    m$data <- as.data.frame(data)
  response.name <- deparse(formula[[2]])
  form <- as.formula(paste(
    paste(response.name, collapse = ""),
    "~",
    paste(deparse(formula[[3]]), collapse = ""),
    "+",
    paste(deparse(instruments[[2]]), collapse = "")))
  m$formula <- form
  m$instruments <- m$contrasts <- NULL
  m$method <- NULL
  m[[1]] <- as.name("model.frame")
  mf <- eval(m, sys.frame(sys.parent()))
  na.act <- attr(mf, "na.action")
  Z <- model.matrix(instruments, data = mf, contrasts)
  y <- mf[, response.name]
  X <- model.matrix(formula, data = mf, contrasts)
  weights <- model.weights(mf)
  result <- ivregdefault(y, X, Z, names = colnames(X), weights = weights,
                         method = method, start, ...)
  result$response.name <- response.name
  result$formula <- formula
  result$instruments <- Z
  result$formula.Z <- instruments
  result$call <- match.call(expand.dots = TRUE)
  result$terms <- attr(mf, "terms")
  if (!is.null(na.act))
    result$na.action <- na.act
  if(!is.null(result$cluster))
    attr(result$vcov,'cluster')$name <- as.character(match.call()['cluster'])
  class(result) <- c('ivreg', 'grpack')
  result
}


##' @export 
print.ivreg <- function(x, ...) {
  cat("\nModel Formula: ")
  print(x$formula)
  cat("\nInstruments: ")
  print(x$formula.Z)
  cat("\nCoefficients:\n")
  print(x$coefficients)
  cat("\n")
  invisible(x)
}

##' @export summary_rob.ivreg
summary_rob.ivreg <- function(object, digits = 4, ...) {
  save.digits <- unlist(options(digits = digits))
  on.exit(options(digits = save.digits))
  cat("\n2SLS Estimates\n")
  ## if(!is.null(AC <- attr(object$vcov,'cluster'))) {
  ##   cat("\nNumber of cluster (", AC$name, "): ", AC$nclus,"\n")
  ## }
  cat("\nModel Formula: ")
  print(object$formula)
  cat("Instruments: ")
  print(object$formula.Z)
#   cat("\nResiduals:\n")
#   print(summary(residuals(object)))
  cat("\n")
  df <- object$n-object$p
  std.errors <- sqrt(diag(object$vcov))
  b <- object$coefficients
  t <- b/std.errors
  p <- 2*(1 - pt(abs(t), df))
  table <- cbind(b, std.errors, t, p)
  rownames(table) <- names(b)
  colnames(table) <- c("Estimate","Std. Error","t value","Pr(>|t|)")
  print(table)

  cat("---\nHeteroskadasticity robust standard errors used\n")
  cat(paste("\nResidual standard error:", round(object$s, digits),
            "on", df, "degrees of freedom\n\n"))
}

##' @export 
J_test <- function(obj, ...)
  UseMethod("J_test")

##' @method J_test ivreg
##' @export J_test.ivreg
J_test.ivreg <- function(obj, ...) {
  g <- obj$instruments*obj$residuals
  m <- ncol(g)
  k <- length(coef(obj))
  if(m<=k)
    error("Exactly identified problem")
  J <- colSums(g)%*%solve(crossprod(g))%*%colSums(g)
  
  pvalue <- pchisq(J, m-k, lower.tail = FALSE)
  
  out <- structure(data.frame(
    q = m-k, 
    J = J, 
    pvalue = pvalue))
  
  cat('\nJ-test test of overidentifying restrictions \n\n')
  print(format(out), row.names=FALSE)
  cat("\n")
  invisible(out)
  
}