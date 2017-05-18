library(Resha)
context("Stemming")

test_that("Stemming works on dictionary words", {
  toks <- c("kitapçığında", "kitapçıdaki", "İstanbul'da",
            "Atatürk", "Atatürk'ün")
  stems <- wordStem(toks)
  expect_equal(length(stems), 5)
  expect_match(stems[1], "kitapçık", fixed = TRUE)
  expect_match(stems[2], "kitapçı", fixed = TRUE)
  expect_match(stems[3], "İstanbul", fixed = TRUE) # truncate to apostrophe
  expect_match(stems[4], "Atatürk", fixed = TRUE) # not in dictionary
  expect_match(stems[5], "Atatürk", fixed = TRUE) # not in dictionary w apostrophe
})

test_that("Adding a single token stem mapping works", {
  toks <- c("kitapçığında", "kitapçıdaki", "Atatürk")
  stems <- wordStem(toks)
  expect_match(stems[1], "kitapçık", fixed = TRUE)
  expect_match(stems[2], "kitapçı", fixed = TRUE)
  expect_match(stems[3], "Atatürk", fixed = TRUE) # not in dictionary
  add_stem("Atatürk", "ATATURK")
  stems <- wordStem(toks)
  expect_match(stems[1], "kitapçık", fixed = TRUE)
  expect_match(stems[2], "kitapçı", fixed = TRUE)
  expect_match(stems[3], "ATATURK", fixed = TRUE) # now in dictionary
})

test_that("Adding a file full of token stem mappings works", {
  tstfile <- tempfile()
  writeLines(text = c("# New tokens and their stems", "Atatürk\tAtAtUrK"),
             con=tstfile)
  add_stems(tstfile)
  toks <- c("kitapçıdaki", "Atatürk")
  stems <- wordStem(toks)
  expect_match(stems[1], "kitapçı", fixed = TRUE)
  expect_match(stems[2], "AtAtUrK", fixed = TRUE) # now in dictionary
})
