library(Resha)
context("Stemming")

test_that("Stemming works on dictionary words", {
  toks <- c("kitapçığında", "kitapçıdaki", "İstanbul'da", "Ataturk")
  stems <- wordStem(toks)
  expect_equal(length(stems), 4)
  expect_match(stems[1], "kitapçık", fixed = TRUE)
  expect_match(stems[2], "kitapçı", fixed = TRUE)
  expect_match(stems[3], "İstanbul", fixed = TRUE) # truncate to apostrophe
  expect_match(stems[4], "Ataturk", fixed = TRUE) # not in dictionary
})

test_that("Adding a single token stem mapping works", {
  toks <- c("kitapçığında", "kitapçıdaki", "Ataturk")
  stems <- wordStem(toks)
  expect_match(stems[1], "kitapçık", fixed = TRUE)
  expect_match(stems[2], "kitapçı", fixed = TRUE)
  expect_match(stems[3], "Ataturk", fixed = TRUE) # not in dictionary
  add_stem("Ataturk", "ATATURK")
  stems <- wordStem(toks)
  expect_match(stems[1], "kitapçık", fixed = TRUE)
  expect_match(stems[2], "kitapçı", fixed = TRUE)
  expect_match(stems[3], "ATATURK", fixed = TRUE) # now in dictionary
})
