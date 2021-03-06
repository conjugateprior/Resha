% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Resha.R
\docType{package}
\name{Resha}
\alias{Resha}
\alias{Resha-package}
\title{Resha: A package for stemming Turkish more gently than Snowball}
\description{
This package is an R version of Harun Reşit Zafer's resha stemmer for
Turkish, from which it takes its language resources.
}
\details{
The main function is \code{\link{wordStem}} which takes a token or a
vector of tokens and returns for each, either its stem from a look-up table, or the original
token if none can be found.  Tokens are truncated up to the first
apostrophe, if any, before stemming.

You can add your own token-stem mappings either individually using
\code{\link{add_stem}} or as together using an input file using
\code{\link{add_stems}}.
}
