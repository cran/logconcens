\name{logconcens-internal}
\alias{GetWeights}
\alias{J00}
\alias{J10}
\alias{clc.fixdom}
\alias{subdivisor}
%
\title{Internal logconcens functions}
\description{Internal logconcens functions, usually not to be called by the user}
\usage{
GetWeights(tplus, p0, xindex, rightinf, phi, phislr, needsl)
J00(x, y, v = 1)
J10(x, y)
clc.fixdom(x, p0, force.inf = FALSE, tau, subdivide, domind1, domind2,
   reduce = TRUE, maxiter = 49, knot.prec = IQR(x[x<Inf])/150,
   move.prec = 1e-08, show = TRUE, verbose = FALSE)
subdivisor(j, tau, eps = 0.01)
}
\author{
Dominic Schuhmacher \email{schuhmacher@stat.unibe.ch}\cr
Kaspar Rufibach \email{kaspar.rufibach@gmail.com}\cr
Lutz Duembgen \email{duembgen@stat.unibe.ch}
}
\keyword{internal}

