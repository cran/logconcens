\name{cure.profile}
\alias{cure.profile}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Evaluate the profile log-likelihood over a grid of \eqn{p_0}-values.
}
\description{
For each of a series of values of the \dQuote{mass at infinity} \eqn{p_0} run the function \code{logcon} and evaluate the (normalized) log-likelihood at \eqn{(\phi,p_0)}{phi,p_0}, where \eqn{\phi}{phi} is the log-density returned by \code{logcon}. This serves for approximate likelihood maximization over \eqn{\phi}{phi} and \eqn{p_0} combined via maximum profile likelihood.
}
\usage{
cure.profile(x, p0grid = seq(0,0.95,0.05), force.inf = FALSE,
   domind1 = 1, domind2 = length(unique(as.vector(x))), maxiter = 49,
   knot.prec = IQR(x[x<Inf])/150)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
    a two-column matrix of \eqn{n \geq 2}{n >= 2} rows containing the data intervals.
  }
  \item{p0grid}{
    a vector of values \eqn{p_0} for which the profile log-likelihood is to be evaluated.
  }
  \item{force.inf, domind1, domind2, maxiter, knot.prec}{
    arguments passed to the function \code{\link{logcon}}.
  }
}
\value{
  A list containing the following values:
  \item{p0hat }{the element in \code{p0grid} that maximizes the profile likelihood (in the very unlikely case of ties, only the smallest such element is returned).}
\item{status }{the vector of (normalized) profile log-likelihood values for the elements of \code{p0grid}.} 
}
\author{
Dominic Schuhmacher \email{schuhmacher@stat.unibe.ch}\cr
Kaspar Rufibach \email{kaspar.rufibach@gmail.com}\cr
Lutz Duembgen \email{duembgen@stat.unibe.ch}
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{logcon}}
\code{\link{loglike}}
}
\examples{
## A somewhat silly example
set.seed(10)
n <- 100
y <- rgamma(n,3)
x <- cbind(y,y)
cured <- rbinom(n,1,0.3)
x[cured == 1,1] <- 10
x[cured == 1,2] <- Inf

\dontrun{
plotint(x)
progrid <- seq(0,0.6,0.025)
prores <- cure.profile(x, progrid)
plot(progrid, prores$loglike)
prores$p0hat
res <- logcon(x, p0=prores$p0hat, verbose=FALSE)
plot(res, type="density")
xi <- seq(0,10,0.025)
lines(xi,0.7*dgamma(xi,3), col=2, lwd=2)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ likelihood }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
