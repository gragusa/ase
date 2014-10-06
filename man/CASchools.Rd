\name{CASchools} 
\alias{CASchools} 
\title{California Test Score Data} 

\description{The dataset contains data on test performance, school 
characteristics and student demographic backgrounds for school districts in California.} 

\usage{data("CASchools")}

\format{
A data frame containing 420 observations on 14 variables.
\describe{
  \item{district}{character. District code.}
  \item{school}{character. School name.}
  \item{county}{factor indicating county.}
  \item{grades}{factor indicating grade span of district.}
  \item{students}{Total enrollment.}
  \item{teachers}{Number of teachers.}
  \item{calworks}{Percent qualifying for CalWorks (income assistance).}
  \item{lunch}{Percent qualifying for reduced-price lunch.}
  \item{computer}{Number of computers.}   
  \item{expenditure}{Expenditure per student.}
  \item{income}{District average income (in USD 1,000).}
  \item{english}{Percent of English learners.}
  \item{read}{Average reading score.}
  \item{math}{Average math score.}
  \item{testcore}{Mean of reading score and math score (read+math)/2.}
  \item{STR}{Student teacher ratio: students/teachers}
}
}

\details{
The data used here are from all 420 K-6 and K-8 districts in California 
with data available for 1998 and 1999.  Test scores are on the Stanford 
9 standardized test administered to 5th grade students.  
School characteristics (averaged across the district) include enrollment, 
number of teachers (measured as \dQuote{full-time equivalents}, number of 
computers per classroom, and expenditures per student. Demographic 
variables for the students are averaged across the district.  
The demographic variables include the percentage of students in the 
public assistance program CalWorks (formerly AFDC), the percentage 
of students that qualify for a reduced price lunch, and the 
percentage of students that are English learners (that is, students 
for whom English is a second language). 
}

\source{
Online complements to Stock and Watson (2007). 

\url{http://wps.aw.com/aw_stock_ie_2}
}

\references{
Stock, J. H. and Watson, M. W. (2007). \emph{Introduction to Econometrics}, 2nd ed. Boston: Addison Wesley.
}

\examples{
## data and transformations
data("CASchools")

## Stock and Watson (2007)
## p. 152
fm1 <- lm(testscore ~ STR, data = CASchools)
coeftest(fm1, vcov = sandwich)

## p. 159
fm2 <- lm(testscore ~ I(STR < 20), data = CASchools)

}

\keyword{datasets}
