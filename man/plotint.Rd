\name{plotint}
\alias{plotint}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Plotting of censored data.
}
\description{
  Plot a graphical representation of censored data, given as two-column matrix \code{x} containing in each
  row the left and right endpoints of a data interval.
  The grid of potential knots used by \code{logcon} is also shown.
}
\usage{
plotint(x, knot.prec = IQR(x[x<Inf])/150) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
    a two-column matrix of left and right endpoints of data intervals.
}
  \item{knot.prec}{
    the maximal distance between two consecutive grid points in the depiction of the grid used by
    \code{logcon}.
}
}
\value{
Used for the side effect.
}
\author{
Dominic Schuhmacher \email{schuhmacher@stat.unibe.ch}\cr
Kaspar Rufibach \email{kaspar.rufibach@gmail.com}\cr
Lutz Duembgen \email{duembgen@stat.unibe.ch}
}

\seealso{
  \code{\link{plot.lcdensity}}
}
\examples{
## See the examples for logcon
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
