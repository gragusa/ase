# ASE
  
  

This package contains functions that are used in Applied Statistics and Econometrics, a course thought at Luiss University in Rome. 

## Examples

```
## Loading required package: sandwich
```

```
## Warning: package 'sandwich' was built under R version 3.1.1
```

```
## Loading required package: lmtest
## Loading required package: zoo
## 
## Attaching package: 'zoo'
## 
## The following objects are masked from 'package:base':
## 
##     as.Date, as.Date.numeric
```



```r
## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
## Conditional homoskedastic errors
summary(lm.D9)
```

```
## 
## Call:
## lm(formula = weight ~ group)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -1.0710 -0.4938  0.0685  0.2462  1.3690 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)    5.032      0.220   22.85  9.5e-15 ***
## groupTrt      -0.371      0.311   -1.19     0.25    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.696 on 18 degrees of freedom
## Multiple R-squared:  0.0731,	Adjusted R-squared:  0.0216 
## F-statistic: 1.42 on 1 and 18 DF,  p-value: 0.249
```

```r
## No assumption on conditional variance of residuals
summary_rob(lm.D9)
```

```
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)    5.032      0.184   27.29  4.3e-16
## groupTrt      -0.371      0.311   -1.19     0.25
## ---
## Heteroskadasticity robust standard errors used
## 
## Residual standard error: 0.696 on 18 degrees of freedom
## Multiple R-squared:  0.0731,	Adjusted R-squared:  0.0216 
## F-statistic: 1.42 on 1 and Inf DF,  p-value: 0.234
```
