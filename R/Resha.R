#' Resha: A package for stemming Turkish more gently than Snowball
#'
#' This package is an R version of Harun Reşit Zafer's resha stemmer for
#' Turkish, from which it takes its language resources.
#'
#' The main function is \link{\code{stem}} which take a vector of tokens
#' and returns for each, either its stem from a look-up table, or if none
#' can be found the original token.  Tokens are truncated up to the first
#' apostrophe, if any, before stemming.
#'
#' You can add your own token-stem mappings either individually using
#' \link{\code{add_stem}} or as together using an input file using
#' \link{\code{add_stems}}.
#'
#' @docType package
#' @name Resha

NULL