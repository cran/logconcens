\name{logconcens-package}
\alias{logconcens-package}
\alias{logconcens}
\docType{package}
\title{
Maximum likelihood estimation of a log-concave density based on censored data. 
}
\description{
Based on independent intervals \eqn{X_i = [L_i,R_i]}, where \eqn{-\infty < L_i \leq R_i \leq \infty}{-Inf < L_i <= R_i <= Inf}, compute the maximum likelihood estimator of a density under the assumption that it is log-concave. For further information see Duembgen, Schuhmacher, and Rufibach (2011, preprint).
}
\details{
\tabular{ll}{
Package: \tab logconcens\cr
Type: \tab Package\cr
Version: \tab 0.11-2\cr
Date: \tab 2011-10-17\cr
License: \tab GPL (>=2)\cr
LazyLoad: \tab yes\cr
}
The main function is \code{\link{logcon}}, which offers computation of the MLE for censored and also exact data and allows the setting of various parameters that are mainly related to control of the underlying EM algorithm in \dQuote{difficult} situations. An object of type \code{lcdensity} is returned, for which \code{\link[=plot.lcdensity]{plot}}, \code{\link[=print.lcdensity]{print}}, and \code{\link[=summary.lcdensity]{summary}} methods have been (partly) implemented. There is also a function \code{\link{loglike}} to compute the log-likelihood of a \code{lcdensity} object.  
}
\author{
Dominic Schuhmacher \email{schuhmacher@stat.unibe.ch}\cr
Kaspar Rufibach \email{kaspar.rufibach@gmail.com}\cr
Lutz Duembgen \email{duembgen@stat.unibe.ch}

Maintainer: Dominic Schuhmacher \email{schuhmacher@stat.unibe.ch}
}
\references{
Duembgen, L., Schuhmacher, D., Rufibach, K. (2011, preprint). Maximum likelihood estimation of a log-concave density based on censored data.
}
\keyword{package}
\examples{
## exact data
set.seed(10)
x <- rnorm(100)
res <- logcon(x)
\dontrun{plot(res)}

## censored data
x <- matrix(rnorm(100),50,2)
x <- t(sapply(split(x,1:50), sort))
plotint(x)
res <- logcon(x, show=FALSE)
\dontrun{plot(res)}
}
