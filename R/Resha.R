#' Resha: A package for stemming Turkish more gently than Snowball
#'
#' This package is an R version of Harun Reşit Zafer's resha stemmer for
#' Turkish, from which it takes its language resources.
#'
#' The main function is \code{\link{wordStem}} which takes a token or a
#' vector of tokens
#' and returns for each, either its stem from a look-up table, or the original
#' token if none can be found.  Tokens are truncated up to the first
#' apostrophe, if any, before stemming.
#'
#' You can add your own token-stem mappings either individually using
#' \code{\link{add_stem}} or as together using an input file using
#' \code{\link{add_stems}}.
#'
#' @docType package
#' @name Resha
NULL