#' SURVEY ON HOUSEHOLD INCOME AND WEALTH data
#' 
#' A dataset contains data about payroll workers from the SWIG (Bank of Italy).
#' 
#' \itemize{
#'   \item wage. numeric: wages for payroll workers
#'   \item educ. numeric: years of education
#'   \item educf. factor: education levels. 
#'   \item gender. factor: gender 
#'   \item age. numeric: age of respondent 
#' }
#' 
#' @docType data
#' @keywords datasets
#' @name payroll
#' @usage data(payroll)
#' @format A data frame with 5700 rows and 5 variables
NULL

#' Data on test score and attendance.
#' 
#' These data were collected by Professors Ronald Fisher and Carl Liedholm
#' during a term in which they both taught principles of microeconomics at
#' Michigan State University.  
#' 
#' \itemize{
#' \item  attend  classes attended out of 32
#' \item  termGPA GPA for term
#' \item  priGPA  cumulative GPA prior to term
#' \item  ACT     ACT score
#' \item  final   final exam score
#' \item  atndrte percent classes attended
#' \item  hwrte   percent homework turned in
#' \item  frosh   =1 if freshman
#' \item  soph    =1 if sophomore
#' \item  missed  number of classes missed
#' \item  stndfnl (final - mean)/sd
#' }
#' 
#' @docType data
#' @keywords datasets
#' @name attend
#' @usage data(attend)
#' @format A data frame with 680 rows and 11 variables
NULL

#' Do education and IQ have an interactive effect in the log(wage) equation?
#' 
#' A dataset contains data about payroll workers 
#' 
#' \itemize{
#'   \item wage. numeric: wages for payroll workers
#'   \item educ. numeric: years of education
#'   \item KWW. factor: education levels. 
#'   \item IQ. factor: gender 
#'   \item age. numeric: age of respondent 
#'   \item hours. numeric: hours worked
#'   \item exper. numeric: experience
#' }
#' 
#' @docType data
#' @keywords datasets
#' @name wage2
#' @usage data(wage2)
#' @format A data frame with 935 rows and 17 variables
NULL

#' US Traffic Fatalities
#' 
#' US traffic fatalities panel data for the “lower 48” US states 
#' (i.e., excluding Alaska and Hawaii), annually for 1982 through 1988.
#' 
#' \itemize{
#' \item state. factor indicating state.
#' \item year. factor indicating year.
#' \item spirit. numeric: Spirit consumption.
#' \item unemp. numeric: state unemployment rare.
#' \item emppop. numeric: employment/population ratio.
#' \item beertax. numeric: tax on case of beer.
#' \item baptist. numeric: Percent of southern baptist.
#' \item mormon. numeric: Percent of mormons.
#' \item drinkage. numeric:  Minimum legal drinking age.
#' \item dry. numeric:  Minimum legal drinking age.
#' \item miles. numeric:  Minimum legal drinking age.
#' \item breath. factor: preliminary breath test law?
#' \item jail. factor: mandatory jail sentence?
#' \item service. factor: mandatory community service?
#' \item fatal. numeric: number of vehicle fatalities.
#' \item nfatal. numeric: number of night-time vehicle fatalities.
#' \item sfatal. numeric: number of single vehicle fatalities.
#' \item fatal1517. numeric: number of vehicle fatalities, 15–17 year olds.
#' \item nfatal1517. numeric: number of night-time vehicle fatalities, 15–17 year olds.
#' \item fatal1820. numeric: number of vehicle fatalities, 18–20 year olds.
#' \item nfatal1820. numeric: number of night-time vehicle fatalities, 18–20 year olds.
#' \item fatal2124. numeric: number of vehicle fatalities, 21–24 year olds.
#' \item nfatal2124. numeric: number of night-time vehicle fatalities, 21–24 year olds.
#' \item afatal. numeric: number of alcohol-involved vehicle fatalities.
#' \item pop. numeric: population.
#' \item pop1517. numeric: population, 15–17 year olds.
#' \item pop1820. numeric: population, 18–20 year olds.
#' \item pop2124. numeric: population, 21–24 year olds.
#' \item milestot. numeric: total vehicle miles (millions).
#' \item unempus. numeric: US unemployment rate.
#' \item emppopus. numeric: US employment/population ratio.
#' \item gsp. numeric: GSP rate of change.
#' }
#' 
#' @docType data
#' @keywords datasets
#' @name fatalities
#' @usage data(fatalities)
#' @format A data frame with 336 rows and 34 variables
NULL
#' Payroll data
#' 
#' A dataset contains data about payroll workers 
#' 
#' \itemize{
#'   \item wage. numeric: wages for payroll workers
#'   \item educ. numeric: years of education
#'   \item KWW. factor: education levels. 
#'   \item IQ. factor: gender 
#'   \item age. numeric: age of respondent 
#'   \item hours. numeric: hours worked
#'   \item exper. numeric: experience
#' }
#' 
#' @docType data
#' @keywords datasets
#' @name wage2
#' @usage data(wage2)
#' @format A data frame with 935 rows and 17 variables
NULL

#' CEO Compensation
#' 
#' A dataset containing a random sample of CEO's compensation information.
#' 
#'\itemize{
#'\item    salary. numeric:     1990 salary, thousands $
#'\item  pcsalary. numeric:       \% change salary, 89-90
#'\item     sales. numeric:  1990 firm sales, millions $
#'\item       roe. numeric:  return on equity, 88-90 avg
#'\item     pcroe. numeric:          \% change roe, 88-90
#'\item       ros. numeric: return on firm\'s stock, 88-90
#'\item     indus. numeric:        =1 if industrial firm
#'\item   finance. numeric:         =1 if financial firm
#'\item  consprod. numeric:  =1 if consumer product firm
#'\item   utility. numeric:  =1 if transport. or utilties
#'}
#' @docType data
#' @keywords datasets
#' @name ceo
#' @usage data(ceo)
#' @format A data frame with 208 rows and 10 variables
NULL

#'CEO Compensation
#' 
#' A dataset containing a random sample of CEO's compensation information.
#' Source: May 6, 1991 Issue of Businessweek
#' 
#'\itemize{
#'  
#'\item    salary. numeric: 1990 compensation, $1000s
#'\item       age. numeric: age of CEO in years
#'\item   college. numeric: =1 if attended college
#'\item      grad. numeric: =1 if attended graduate school
#'\item    comten. numeric: years with company
#'\item    ceoten. numeric: years as ceo with company
#'\item     sales. numeric: 1990 firm sales, millions
#'\item  profits.  numeric: 1990 profits, millions
#'\item    mktval. numeric: market value, end 1990, mills.
#'}
#' @docType data
#' @keywords datasets
#' @name ceo2
#' @usage data(ceo2)
#' @format A data frame with 177 rows and 9 variables
NULL

#' Crime and punishment in North Carolina
#' 
#' A panel of 90 observations from 1981 to 1987 about crime and punishment in
#' Noth Caroline.
#'
#'\itemize{
#' \item county county identifier
#'\item year year from 1981 to 1987
#'\item crmrte. crimes committed per person
#'\item prbarr. 'probability' of arrest
#'\item prbconv. 'probability' of conviction
#'\item prbpris. 'probability' of prison sentenc
#'\item avgsen. average sentence, days
#'\item polpc. police per capita
#'\item density. people per square mile
#'\item taxpc. tax revenue per capita
#'\item region. one of 'other', 'west' or 'central'
#'\item smsa. 'yes' or 'no' if in SMSA
#'\item pctmin. percentage minority in 1980
#'\item wcon. weekly wage in construction
#'\item wtuc. weekly wage in trns, util, commun
#'\item wtrd. weekly wage in whole sales and retail trade
#'\item wfir. weekly wage in finance, insurance and real estate
#'\item wser. weekly wage in service industry
#'\item wmfg. weekly wage in manufacturing
#'\item wfed. weekly wage of federal emplyees
#'\item wsta. weekly wage of state employees
#'\item wloc. weekly wage of local governments employee
#'\item mix. offence mix: face-to-face/other
#'\item pctymle. percentage of young males
#'}
#'
#' @docType data
#' @keywords datasets
#' @name crimenc
#' @usage data(crimenc)
#' @format A data frame with 630 rows and 25 variables 
NULL

#' Cigarette Consumption Panel Data
#' 
#' Panel data on cigarette consumption for the 48 continental US States from
#' 1985-1995.
#' 
#' \itemize{
#' \item    state Factor indicating state.
#' \item    year Factor indicating year.
#' \item    cpi Consumer price index.
#' \item    population State population.
#' \item    packs Number of packs per capita.
#' \item    income State personal income (total, nominal).
#' \item    tax Average state, federal and average local excise taxes for fiscal year.
#' \item  price Average price during fiscal year, including sales tax.
#' \item    taxs Average excise taxes for fiscal year, including sales tax.
#'}
#' @docType data
#' @keywords datasets
#' @name Cigarettes
#' @usage data("Cigarettes")
#' @format A data frame containing 48 observations on 7 variables for 2 periods.
NULL

#' County crime data
#' 
#' Panel data on county level crime data.
#' 
#' \itemize{
#' \item     county               county identifier
#' \item     year                        81 to 87
#' \item     crmrte     crimes committed per person
#' \item     prbarr         'probability' of arrest
#' \item     prbconv     'probability' of conviction
#' \item     prbpris 'probability' of prison sentenc
#' \item     avgsen             avg. sentence, days
#' \item     polpc               police per capita
#' \item     density             people per sq. mile
#' \item     taxpc          tax revenue per capita
#' \item      west           =1 if in western N.C.
#' \item   central           =1 if in central N.C.
#' \item     urban                   =1 if in SMSA
#' \item  pctmin80            perc. minority, 1980
#' \item      wcon       weekly wage, construction
#' \item      wtuc    wkly wge, trns, util, commun
#' \item      wtrd wkly wge, whlesle, retail trade
#' \item      wfir    wkly wge, fin, ins, real est
#' \item      wser      wkly wge, service industry
#' \item      wmfg         wkly wge, manufacturing
#' \item      wfed         wkly wge, fed employees
#' \item      wsta       wkly wge, state employees
#' \item      wloc        wkly wge, local gov emps
#' \item      mix offense mix: face-to-face/other
#' \item      pctymle              percent young male
#'}
#' @docType data
#' @keywords datasets
#' @name countycrime
#' @usage data("countycrime")
#' @format A data frame containing 630 observation on 26 variables.
#' @source From C. Cornwell and W. Trumball (1994), “Estimating the
#' Economic Model of Crime with Panel Data,” Review of Economics and Statistics 76, 360-366.
NULL
