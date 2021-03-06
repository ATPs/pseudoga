% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pseudoga_code_subset.R
\name{pseudoga_parallel}
\alias{pseudoga_parallel}
\title{Function to estimate pseudotime}
\usage{
pseudoga_parallel(
  sce,
  type = c("counts", "nomralized", "expression"),
  ntest = 50,
  repl = 3,
  subsample = 100,
  minit = 30,
  epsilon = 1e-04,
  normalization = c("default", "TMM", "quant", "cpm"),
  nnprop = 0.3
)
}
\arguments{
\item{sce}{A SingleCellExpression object. The slot "assays" must contain one of the followings: "counts" (count data), "normalized" (normalized data), "expression" (neither count data nor normalized data).}

\item{type}{Type of expression data to be analyzed. It should assume one of these values: "counts", "normalized", "expression". Default is "counts".}

\item{ntest}{Size of each generation considered in genetic algorithm is (8*ntest) . Default value for ntest is 50.}

\item{repl}{Number of independent pseudotime estimates used to calculate final trajectory. Default value is 3. Increasing the value of this parameter will in general improve the accuracy of the estimate.}

\item{minit}{Minimum number of generations considered in genetic algorithm. Default value is 30.}

\item{epsilon}{The tolerance value used in convergence. Default value is \eqn{10^{-4}}.}

\item{normalization}{Normalization method applied on the input dataset. It must be one of the following "default" (DESeq Normalization), "TMM" (TMM Normalization), "quant" (Quantile Normalization) or "cpm" (Counts Per Million).}

\item{nnprop}{Proportion of sample size used as value of k for kNN smoothing. If subsample size is N, (N*nnprop) is considered as value of k. Default value is 0.3.}

\item{subset}{Number of cells used in each of the independent pseudotime estimation. Default value is 100. For larger datasets, larger values are recommended.}
}
\value{
An updated SingleCellExperiment object in which colData contains values for pseudotime for each cell with slot name "Pseudotime" .
}
\description{
This function estimates pseudotime using PseudoGA algorithm. This function is designed to work on large number of cells. A number of subsamples are chosen to avoid computing pseudotime on large number of cells. Ordering of cells is performed using genetic algorithm on each of the subsamples. Pseudotimes are updated using nearest neighbor smoothing. Based on different subsamples, multiple pseudotime estimates are calculated independently and the final pseudotime estimate is obtained based on principal curve fitting on indepedent estimates. In general, increasing the number of subsets will improve the accuracy of the estimate.
}
\examples{
\dontrun{
library(pseudoga)
library(SingleCellExperiment)
counts <- matrix(rpois(1000000, lambda = 10), ncol=10000, nrow=100)
sce <- SingleCellExperiment(list(counts=counts))
sce<-pseudoga_parallel(sce)
}
}
