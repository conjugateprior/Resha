reshaEnv <- new.env()

get_resha <- function(){
  resha <- get0("resha", envir=reshaEnv)
  if (is.null(resha)){
    message("Constructing the stemmer")
    resha <- hashmap::hashmap(resha_data$token, resha_data$stem)
    assign("resha", resha, reshaEnv)
  }
  resha
}

#' Stem Turkish tokens
#'
#' This function attempts to stem Turkish tokens using a look-up table (derived
#' from Nuve) as a fast substitute for more complex but more accurate
#' morphological analysis.  If tokens contain an apostrophe, only characters
#' before are stemmed and the remainder discarded.
#'
#' This code should work the same way as the original Java implementation.
#'
#' @param x A token or a vector of tokens
#'
#' @return A stemmed token or vector of stemmed tokens, or the originals if no stems could be found
#' @export
#'
#' @examples
#'   toks <- c("kitapçığında", "kitapçıdaki", "İstanbul'da")
#'   stem(toks)
#'   # "kitapçık" "kitapçı"  "İstanbul"
#'
#' @references
#'
#' Resha: \url{https://github.com/hrzafer/resha-turkish-stemmer}
#'
#' Nuve: \url{https://github.com/hrzafer/nuve}
#'
stem <- function(x){
  resha <- get_resha() # or construct it as necessary
  trunc_match <- regexpr("'", x)
  trunc <- trunc_match > -1
  x[trunc] <- substr(x[trunc], 1, trunc_match[trunc]-1)
  res <- resha[[x]]
  no_stem <- which(is.na(res))
  res[no_stem] <- x[no_stem]
  res
}

#' Add a single token-stem mapping
#'
#' This overwrites or augments the package's existing token to stem mapping.
#'
#' @param token A new token
#' @param stem Its stem
#'
#' @return Nothing
#' @export
#'
#' @examples
#' add_stem("zürriyetindensin", "zürriyet")
#'
add_stem <- function(token, stem){
  resha <- get_resha()
  resha[[token]] <- stem
}


#' Add a file of new token-stems pairs
#'
#' The file should have lines of the form <token>[tab]<stem>. Empty lines and
#' lines starting with # will be ignored.  An example of the correct format
#' is \code{system.file("extdata", "manual.dict", package = "Resha")}
#'
#' Note that changes to the token-stem mapping are not maintained
#' between package loadings.
#'
#' @param fname Name of the file
#'
#' @return Nothing
#' @export
#'
#' @examples
#' newfile <- system.file("extdata", "manual.dict", package = "Resha")
#' add_stems(newfile)
#'
add_stems <- function(fname){
  lns <- readLines(fname)
  lns <- lns[lns != "" & substr(lns, 1, 1) != "#"]
  m <- matrix(unlist(strsplit(lns, "\\W")), nrow=2)
  resha <- get_resha()
  resha$insert(m[1,], m[2,])
}
