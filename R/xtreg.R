# xtreg <- function(obj, ...)
#   UseMethod("xtreg", obj)
# 
# xtreg.formula <- function(formula, data, model.type = c("within", "between"), 
#                           panel, subset, weights, na.action, 
#                           model = TRUE, x = FALSE, y = FALSE, 
#                           qr = TRUE, singular.ok = TRUE, 
#                           contrasts = NULL, offset, ...) {
#   
#   
#   type  <- match.arg(model.type)
#   
#   if(missing(panel) && type == "within")
#     stop("'panel' variable must be specified")
#   
#   cl <- match.call()
#   mf <- match.call(expand.dots = FALSE)
#   m <- match(c("panel", "model.type"), names(mf), 0L)
#   mf <- mf[-m]  
#   mf[[1L]]  <- quote(stats::lm)
#   mf <- as.list(mf)
#   mf$method <- "model.frame"
#   mf_1 <- eval(as.call(mf), parent.frame())
#   mf$formula <- update(formula, substitute(.~.+panel))
#   mf_2 <- eval(as.call(mf), parent.frame())
#   
#   ## Transform the data
#   
#   mf_3 <- mf_2 %*% mutate_each(funs(mean))
#   
#   call <- substitute(group_by(mf_2, target), list(target = as.name(substitute(panel)))) 
#   mf_2 <- eval(call) 
#   
#   ## Within transformtion
#   mf_w <- mf_2 %>% mutate_each(funs(.-mean(.)))
#   
#   mf$formula <- formula
#   mf$data <- mf_w
#   mf$method <- "qr"
#   
#   within <- eval(as.call(mf), parent.frame())
#   within$call <- cl
#   within
#   
#   cln <- colnames(mf_2)
#   cln <- cln[-match(all.names(substitute(panel)), cln)]
#   
#              
#   
#   
#   mf_2 %>% mutate(nfatal = fatal-mean(fatal))
#   
#   tmp <- as.list(formula)
#   tmp[[3]] <- paste(tmp[[3]], panel, sep = "+")
#   
#   
#   
#   
#  
# }
#   
#   
