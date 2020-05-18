library(pdftools)
library(tm)
library(tidyverse)
library(stringi)
library(readxl)
library(tools)

#Read Regex
getparam <- function(fp, Lab) {
  param <- read_excel(fp, sheet = "regex") %>% 
    filter(lab == Lab) %>% 
    select(name, search, row, RE, lab) 
  return(param)
}

#get filelist
getfiles <- function(pdfdir) {
  data_files <- list.files(pdfdir, "*.pdf|*.PDF", full.names = TRUE)
  return(data_files)
}

#Extract info for parameter
get_info <- function(p, pd) {
  tryCatch( {
    warn <- err <- NULL
    r <- min(grep(p[2], pd)) + as.numeric(p[3])
    result <- str_trim(str_match(pd[r], p[4])[,2])
    return(result)
    },
    warning = function(w) {
      warn <<- append(warn, conditionMessage(w))
      invokeRestart("muffleWarning")
    },
    error = function(cond) {
      return(NA)
    }
  )
}

#Extract info for each parameter and return data frame
extract_file <- function(filename, param, Lab) {
  pd <- pdf_text(filename) %>%
    readr::read_lines()
  param$result <-  apply(param, 1, FUN = get_info, pd)
  results <- param %>% 
    select(name, result) %>% 
    pivot_wider(names_from = name, values_from = result) %>% 
    mutate(Bestand = basename(filename)) %>% 
    mutate(lab = Lab)
  return(results)
}

#Extract info for each parameter and return data frame
extract_file2 <- function(filepath, filename, param, Lab) {
  pd <- pdf_text(filepath) %>%
    readr::read_lines()
  param$result <-  apply(param, 1, FUN = get_info, pd)
  results <- param %>% 
    select(name, result) %>% 
    pivot_wider(names_from = name, values_from = result) %>% 
    mutate(Bestand = filename) %>% 
    mutate(lab = Lab)
  return(results)
}

getlabdata <- function(Lab, pdfdir, csvdir, paramfile) {
  param <- getparam(paramfile, Lab)
  data_files <- getfiles(pdfdir)
  results <- lapply(data_files, param, Lab, FUN = extract_file)
  results <- bind_rows(results)
  write_csv(results, file.path(csvdir, "labdata.csv"))
}

getlabdata2 <- function(Lab, datapaths, datanames, param) {
  results <- mapply(FUN = extract_file2, 
                    datapaths, datanames, 
                    MoreArgs = list(param = param, Lab = Lab),
                    SIMPLIFY = FALSE)
  results <- bind_rows(results)
  return(results)
  }