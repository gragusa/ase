##' \code{print.summary_rob} is the print method for \code{summary_rob} model summaries.
##'
##' \code{print.summary_rob} is the print method for \code{summary_rob} model summaries.
##' @title  Printing Summary
##' @author Giuseppe Ragusa
##' @method print summary_rob
##' @export print.summary_rob
print.summary_rob <-
function (x, digits = max(3L, getOption("digits") - 3L), symbolic.cor = x$symbolic.cor, 
    signif.stars = FALSE, call=FALSE, ...) 
{
  if(call) {
    cat("\nCall:\n", paste(deparse(x$call), sep = "\n", collapse = "\n"), 
        "\n\n", sep = "")
  }
    resid <- x$residuals
    df <- x$df
    rdf <- df[2L]
  
    if (length(x$aliased) == 0L) {
        cat("\nNo Coefficients\n")
    }
    else {
        if (nsingular <- df[3L] - df[1L]) 
            cat("\nCoefficients: (", nsingular, " not defined because of singularities)\n", 
                sep = "")
        else cat("\nCoefficients:\n")
        coefs <- x$coefficients
        if (!is.null(aliased <- x$aliased) && any(aliased)) {
            cn <- names(aliased)
            coefs <- matrix(NA, length(aliased), 4, dimnames = list(cn, 
                colnames(coefs)))
            coefs[!aliased, ] <- x$coefficients
        }
        printCoefmat(coefs, digits = digits, signif.stars = signif.stars, 
            na.print = "NA", ...)
        cat("---\nHeteroskadasticity robust standard errors used\n")
    }
    if(!is.null(x$sigma))
    cat("\nResidual standard error:", format(signif(x$sigma, 
        digits)), "on", rdf, "degrees of freedom")
    cat("\n")
    if (nzchar(mess <- naprint(x$na.action))) 
        cat("  (", mess, ")\n", sep = "")
    if (!is.null(x$fstatistic)) {
        cat("Multiple R-squared: ", formatC(x$r.squared, digits = digits))
        cat(", Adjusted R-squared: ", formatC(x$adj.r.squared, 
            digits = digits), "\nF-statistic:", formatC(x$fstatistic[1L], 
            digits = digits), "on", x$fstatistic[2L], "and", 
            x$fstatistic[3L], "DF,  p-value:", format.pval(pf(x$fstatistic[1L], 
                x$fstatistic[2L], x$fstatistic[3L], lower.tail = FALSE), 
                digits = digits))
        cat("\n")
    }
    if(!is.null(x$factor_omitted)) {
      cat('---\nFactors not reported:', paste(x$factor_omitted, sep = ","), "\n")
    }
    correl <- x$correlation
    if (!is.null(correl)) {
        p <- NCOL(correl)
        if (p > 1L) {
            cat("\nCorrelation of Coefficients:\n")
            if (is.logical(symbolic.cor) && symbolic.cor) {
                print(symnum(correl, abbr.colnames = NULL))
            }
            else {
                correl <- format(round(correl, 2), nsmall = 2, 
                  digits = digits)
                correl[!lower.tri(correl)] <- ""
                print(correl[-1, -p, drop = FALSE], quote = FALSE)
            }
        }
    }
    
    cat("\n")
    invisible(x)
}


##' @method print summary_rob_plm
##' @export print.summary_rob_plm

print.summary_rob_plm <- function (x, digits = max(3, getOption("digits") - 2), width = getOption("width"), 
          subset = NULL, ...) 
{
  formula <- formula(x)
  has.instruments <- (length(formula)[2] == 2)
  effect <- plm:::describe(x, "effect")
  model <- plm:::describe(x, "model")
  cat(paste(plm:::effect.plm.list[effect], " ", sep = ""))
  cat(paste(plm:::model.plm.list[model], " Model", sep = ""))
  if (model == "random") {
    ercomp <- describe(x, "random.method")
    cat(paste(" \n   (", random.method.list[ercomp], "'s transformation)\n", 
              sep = ""))
  }
  else {
    cat("\n")
  }
  if (has.instruments) {
    ivar <- describe(x, "inst.method")
    cat(paste("Instrumental variable estimation\n   (", inst.method.list[ivar], 
              "'s transformation)\n", sep = ""))
  }
  cat("\nCall:\n")
  print(x$call)
  cat("\n")
  pdim <- plm:::pdim.panelmodel(x)
  print(pdim)
  if (model == "random") {
    cat("\nEffects:\n")
    print(x$ercomp)
  }
#   cat("\nResiduals :\n")
#   save.digits <- unlist(options(digits = digits))
#   on.exit(options(digits = save.digits))
#   print(sumres(x))
  cat("\nCoefficients :\n")
  if (is.null(subset)) 
    printCoefmat(coef(x), digits = digits)
  else printCoefmat(coef(x)[subset, , drop = FALSE], digits = digits)
  cat("\n")
#   cat(paste("Total Sum of Squares:    ", signif(tss(x), digits), 
#             "\n", sep = ""))
#   cat(paste("Residual Sum of Squares: ", signif(deviance(x), 
#                                                 digits), "\n", sep = ""))
#   cat(paste("R-Squared      : ", signif(x$r.squared[1], digits), 
#             "\n"))
  cat("Adj. R-Squared : ", signif(x$r.squared[2], digits), 
      "\n")
  fstat <- x$fstatistic
  if (names(fstat$statistic) == "F") {
    cat(paste("F-statistic: ", signif(fstat$statistic), " on ", 
              fstat$parameter["df1"], " and ", fstat$parameter["df2"], 
              " DF, p-value: ", format.pval(fstat$p.value, digits = digits), 
              "\n", sep = ""))
  }
  else {
    cat(paste("Chisq: ", signif(fstat$statistic), " on ", 
              fstat$parameter, " DF, p-value: ", format.pval(fstat$p.value, 
                                                             digits = digits), "\n", sep = ""))
  }
  invisible(x)
}
