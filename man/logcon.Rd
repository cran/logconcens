\name{logcon}
\alias{logcon}
\alias{logConCens}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Compute log-concave MLE based on censored or exact data.
}
\description{
Based on independent intervals \eqn{X_i = [L_i,R_i]}, where \eqn{-\infty < L_i \leq R_i \leq \infty}{-Inf < L_i <= R_i <= Inf}, compute the maximum likelihood estimator of a (sub)density under the assumption that it is log-concave. Computation is based on an EM algorithm. For further information see Duembgen, Schuhmacher, and Rufibach (2011, preprint).
}
\usage{
logcon(x, p0 = 0, force.inf = FALSE, domind1 = 1,
   domind2 = length(unique(as.vector(x))), maxiter = 49,
   knot.prec = IQR(x[x<Inf])/150, show = FALSE, verbose = FALSE)

logConCens(x, p0 = 0, show = FALSE, verbose = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
    a two-column matrix of \eqn{n \geq 2}{n >= 2} rows containing the data intervals, or a vector of length
    \eqn{n \geq 2}{n >= 2} containing the exact data points.
}
  \item{p0}{
    a number from 0 to 1 specifying a potential \dQuote{mass at infinity}, i.e. a subdensity
    is estimated that integrates to \code{1-p0}. In the default case of \code{p0 = 0}
    a proper probability density is computed.
}
  \item{force.inf}{
    \code{logical}. For experimental use only. Should the domain interval be forced to be right-infinite? There are no built-in checks, so this option should typically not be set by the user. 
}
  \item{domind1}{
    the index of the element in \code{sort(unique(as.vector(x)))} that gives the left endpoint of the maximal domain to be considered by the algorithm. See details.
}
  \item{domind2}{
    as \code{domind1}, but for the right endpoint. See details.
}
  \item{maxiter}{
    the maximal number of iterations in the EM algorithm. Default is \code{49} rather than \code{50},
    because this goes well with plotting in case of \code{show = TRUE}. 
}
  \item{knot.prec}{
    the maximal distance between two consecutive grid points, where knots (points at which the resulting
    log-density \eqn{\phi}{phi} may change slope) can be positioned.
}
  \item{show}{
    \code{logical}. Should progress of the algorithm be plotted? Warning: if \code{TRUE}, this may open
    many new graphics devices in case of complicated data sets.
}
  \item{verbose}{
    \code{logical}. Should additional information about the progress of the algorithm be printed? 
    This mainly prints quantities important for the decision to reduce the domain of the function
    and about the progress of the EM algorithm.  
}
}
\details{
\code{logConCens} is just an alias for \code{logcon} where the more technical parameters cannot be changed by the user. It is introduced to provide unified naming with the main functions in the packages \code{logcondens} and \code{logcondiscr}. 

The function \code{logcon} (approximatively) computes a concave, piecewise linear function \eqn{\phi}{phi} that satisfies \eqn{\int \exp \phi(x) \, dx = 1}{int exp(phi(x)) dx = 1} and maximizes the (normalized) log-likelihood for the estimation of a density \eqn{\exp \circ \, \phi}{exp o phi}, viz.

\deqn{\ell(\phi, p_o) = \frac{1}{n} \sum_{i=1}^n \biggl[ 1\{L_i = R_i\} \phi(X_i) + 1\{L_i < R_i\}
   \log \biggl( \int_{L_i}^{R_i} \exp \phi(x) \; dx + 1\{R_i = \infty\} p_o \biggr) \ \biggr],}{%
   l(\phi, p_o) = (1/n) \sum_{i=1}^n  [  1{L_i = R_i} phi(X_i) + 1{L_i < R_i}
   log ( int_{L_i}^{R_i} exp phi(x) \, dx + 1{R_i = Inf} p_o )  ],}

where \eqn{p_0 = 0} in the current implementation.

If \code{x} is a two-column matrix, it is assumed to contain the left and right interval endpoints in the right order. Intervals may have length zero (both endpoints equal) or be unbounded to the right (right endpoint is \code{Inf}). Computation is based on an EM algorithm, where the M-step uses an active set algorithm for computing the log-concave MLE for exact data with weights. The active set algorithm was described in Duembgen, Huesler, and Rufibach (2007) and Duembgen and Rufibach (2011) and is available in the R package \code{logcondens}. It has been re-implemented in C for the current package because of speed requirements. The whole algorithm for censored data has been indicated in Duembgen, Huesler, and Rufibach (2007) and was elaborated in Duembgen, Schuhmacher, and Rufibach (2011, preprint).

If \code{x} is a vector argument, i.e. all the data is exact, the active set algorithm is accessed directly.

In order to obtain a finite dimensional optimization problem the (supposed) domain of \eqn{\phi}{phi} is subdivided by a grid. Stretches between interval endpoints where for theoretical reasons no knots (points where the slope of \eqn{\phi}{phi} changes) can lie are left out. The argument \code{kink.prec} gives the maximal distance we allow between consecutive grid points in stretches where knots can lie. Say \code{plotint(x)} to see the grid.

The EM algorithm works only for fixed dimensionality of the problem, but the domain of the function \eqn{\phi}{phi} is not a priori known. Therefore there is an outer loop starting with the largest possible domain, given by the minimal and maximal endpoints of all the intervals, and decreasing the domain as soon as the EM steps let \eqn{\phi}{phi} become very small towards the boundary. In the present implementation \dQuote{very small} means that the integral of \eqn{\exp \circ \, \phi}{exp o phi} over the first or last stretch between interval endpoints within the current domain falls below a certain threshold \code{delta} (which is currently computed in the internal function \code{clc.fixdom}).

Domain reduction tends to be rather conservative. If the computed solution has a suspiciously steep slope at the left [right] end of the domain, the recommended strategy is to enforce a smaller domain by setting the argument \code{domind1} [\code{domind2}] in the function call to be \code{1} above the value of \code{domind1} [\code{1} below the value of \code{domind2}] in the returned solution. The function \code{\link{loglike}} may be used to compare the (normalized) log-likelihoods of the results.
}
\value{
An object of class \code{lcdensity} for which reasonable \code{\link[=plot.lcdensity]{plot}}, \code{\link[=print.lcdensity]{print}}, and \code{\link[=summary.lcdensity]{summary}} methods are implemented.

If the argument \code{x} is a two-column matrix (censored data case), such an object has the following components. 
\item{basedOn }{the string \code{"censored"} for the type of data the solution is based on.}
\item{status }{currently only \code{0} if the algorithm converged; and \code{1} otherwise. 
   Note that in most cases even with status \code{1} the returned solution is very close to the truth.
   The \code{1} is often due to the fact that the termination criterion is not so well balanced yet.}
\item{x }{the data entered.}
\item{tau }{the ordered vector of different interval endpoints. Limitations of the stretches.}
\item{domind1, domind2}{the indices of the \code{tau}-element at which the domain of the MLE \eqn{\phi}{phi}%
   starts/ends.}
\item{tplus}{the grid vector. \code{tau[domind1:domind2]} augmented by points of subdivision.}
\item{isKnot}{\code{0}-\code{1} value. For the finite elements of \code{tplus} a \code{1} if \eqn{\phi}{phi} has a knot at this position, \code{0} otherwise.}
\item{phi}{the vector of \eqn{\phi}{phi}-values at the finite elements of \code{tplus}.}
\item{phislr}{if \eqn{\sup({\rm dom}(\phi)) = \infty}{sup(dom(phi)) = Inf}, the slope of \eqn{\phi}{phi} after the last knot. Otherwise \eqn{-\infty}{-Inf}.}
\item{Fhat}{the vector of values of the distribution function \eqn{F} of \eqn{\exp \circ \, \phi}{exp o phi} at the finite elements of \code{tplus}.}
\item{Fhatfin}{the computed value of \eqn{\lim_{t \to \infty} F(t)}{lim_{t to Inf} F(t)}.}
}

\references{
Duembgen, L., Huesler, A., and Rufibach, K. (2007). Active set and EM algorithms for log-concave densities based on complete and censored data. Technical Report 61. IMSV, University of Bern. \url{http://arxiv.org/abs/0707.4643}

Duembgen, L., and Rufibach, K., (2011). logcondens: Computations Related to Univariate Log-Concave Density Estimation. Journal of Statistical Software, 39(6), 1-28. \url{http://www.jstatsoft.org/v39/i06}

Duembgen, L., Schuhmacher, D., and Rufibach, K. (2011, preprint). Maximum likelihood estimation of a log-concave density based on censored data.
}
\author{
Dominic Schuhmacher \email{schuhmacher@stat.unibe.ch}\cr
Kaspar Rufibach \email{kaspar.rufibach@gmail.com}\cr
Lutz Duembgen \email{duembgen@stat.unibe.ch}
}
\note{
 If \code{x} is a vector, this function does the same as the function \code{logConDens} in the package
 \code{logcondens}. The latter package offers additional features such as grid-based computation with weights
 (for high numerical stability) and
 smoothing of the estimator, as well as nicer plotting. \strong{For exact data} we recommend using
 \code{logConDens} for
 everyday data analysis. \code{logcon} with a vector argument is to be preferred if time is of the essence (for
 data sets with several thousands of points or repeated optimization in iterative algorithms) or
 if an additional slope functionality is required. 

 Two other helpful packages for log-concave density estimation based on exact data are \code{logcondiscr} for estimating a discrete distribution and \code{LogConcDEAD} for estimating a multivariate continuous distribution.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{loglike}}, \code{\link{lcdensity-methods}}
}
\examples{
set.seed(20)
n <- 200
## generate exact data:
y <- rgamma(n,3)
## censor data according to whether they lie befor or after
## virtual obsevations z:
z <- rexp(n,1/6)
x <- cbind(ifelse(y <= z, y, z), ifelse(y <= z, y, Inf))
## display the censored data graphically:
plotint(x)
## compute the log-concave MLE:
res.cens <- logcon(x)
plot(res.cens)
## compare to the true log-density of the Gamma(3,1)-distribution
xi <- seq(0,12,0.05)
lines(xi,log(dgamma(xi,3)),col=3)

## compare to the performance of the log-concave MLE
## if we had had all of the exact data
res.exact <- logcon(y)
lines(res.exact$x, res.exact$phi, lwd=2, lty=2)

## compare estimated survival function to the Kaplan-Meier estimator
## we only consider a small subsample for dramatic effect
\dontrun{
library(survival)
xx <- x[1:50,]
res.cens2 <- logcon(xx)
plot(res.cens2, type="survival")

xx.surv <- Surv(xx[,1], xx[,2]<Inf)
res.surv <- survfit(xx.surv ~ 1)
lines(res.surv, lwd=1.5)

xi <- seq(0,12,0.05)
lines(xi,1-pgamma(xi,3),col=3)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
