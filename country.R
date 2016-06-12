library(rvest)
library(stringr)

#gets all the african countries
africa.raw <- read_html("http://www.lonelyplanet.com/places")
text <- vector()
for(i in 1:15){
  css = paste("#tab-africa > div:nth-child(",i,")", sep="")
  africa.elements <- africa.raw %>% html_node(css = css)
  text[i] <- html_text(africa.elements)
}

tmp <- str_replace_all(text, " ", "-")
tmp <- str_replace_all(tmp, "\n", " ")
tmp <- tolower(tmp)
tmp <- str_replace_all(tmp, "[ ]+", " ")
tmp <- str_trim(tmp)
tmp <- str_split(tmp, " ")
tmp <- lapply(tmp, FUN = function(x) { x <- x[-1]})

africa <- unlist(tmp)

#gets all the asian countries
asia.raw <- read_html("http://www.lonelyplanet.com/places")
text <- vector()
for(i in 1:15){
  css = paste("#tab-asia > div:nth-child(",i,")", sep="")
  asia.elements <- asia.raw %>% html_node(css = css)
  text[i] <- html_text(asia.elements)
}

tmp <- str_replace_all(text, " ", "-")
tmp <- str_replace_all(tmp, "\n", " ")
tmp <- tolower(tmp)
tmp <- str_replace_all(tmp, "[ ]+", " ")
tmp <- str_trim(tmp)
tmp <- str_split(tmp, " ")
tmp <- lapply(tmp, FUN = function(x) { x <- x[-1]})

asia <- unlist(tmp)
asia[26] <- "east-timor"
asia[16] <- "myanmar-burma"

#gets all the caribbean countries
caribbean.raw <- read_html("http://www.lonelyplanet.com/places")
text <- vector()
for(i in 1:15){
  css = paste("#tab-caribbean > div:nth-child(",i,")", sep="")
  caribbean.elements <- caribbean.raw %>% html_node(css = css)
  text[i] <- html_text(caribbean.elements)
}

tmp <- str_replace_all(text, " ", "-")
tmp <- str_replace_all(tmp, "\n", " ")
tmp <- tolower(tmp)
tmp <- str_replace_all(tmp, "[ ]+", " ")
tmp <- str_trim(tmp)
tmp <- str_split(tmp, " ")
tmp <- lapply(tmp, FUN = function(x) { x <- x[-1]})

caribbean <- unlist(tmp)

#gets all the central american countries
cAmerica.raw <- read_html("http://www.lonelyplanet.com/places")
text <- vector()
for(i in 1:26){
  css = paste("#tab-central-america > div:nth-child(",i,")", sep="")
  cAmerica.elements <- cAmerica.raw %>% html_node(css = css)
  text[i] <- html_text(cAmerica.elements)
}

tmp <- str_replace_all(text, " ", "-")
tmp <- str_replace_all(tmp, "\n", " ")
tmp <- tolower(tmp)
tmp <- str_replace_all(tmp, "[ ]+", " ")
tmp <- str_trim(tmp)
tmp <- str_split(tmp, " ")
tmp <- lapply(tmp, FUN = function(x) { x <- x[-1]})

cAmerica <- unlist(tmp)

#gets all the european countries
europe.raw <- read_html("http://www.lonelyplanet.com/places")
text <- vector()
for(i in 1:26){
  css = paste("#tab-europe > div:nth-child(",i,")", sep="")
  europe.elements <- europe.raw %>% html_node(css = css)
  text[i] <- html_text(europe.elements)
}

tmp <- str_replace_all(text, " ", "-")
tmp <- str_replace_all(tmp, "\n", " ")
tmp <- tolower(tmp)
tmp <- str_replace_all(tmp, "[ ]+", " ")
tmp <- str_trim(tmp)
tmp <- str_split(tmp, " ")
tmp <- lapply(tmp, FUN = function(x) { x <- x[-1]})

europe <- unlist(tmp)

#gets all the middle eastern countries
mEast.raw <- read_html("http://www.lonelyplanet.com/places")
text <- vector()
for(i in 1:26){
  css = paste("#tab-middle-east > div:nth-child(",i,")", sep="")
  mEast.elements <- mEast.raw %>% html_node(css = css)
  text[i] <- html_text(mEast.elements)
}

tmp <- str_replace_all(text, " ", "-")
tmp <- str_replace_all(tmp, "\n", " ")
tmp <- tolower(tmp)
tmp <- str_replace_all(tmp, "[ ]+", " ")
tmp <- str_trim(tmp)
tmp <- str_split(tmp, " ")
tmp <- lapply(tmp, FUN = function(x) { x <- x[-1]})

mEast <- unlist(tmp)

#gets all the north american countries
nAmerica.raw <- read_html("http://www.lonelyplanet.com/places")
text <- vector()
for(i in 1:26){
  css = paste("#tab-north-america > div:nth-child(",i,")", sep="")
  nAmerica.elements <- nAmerica.raw %>% html_node(css = css)
  text[i] <- html_text(nAmerica.elements)
}

tmp <- str_replace_all(text, " ", "-")
tmp <- str_replace_all(tmp, "\n", " ")
tmp <- tolower(tmp)
tmp <- str_replace_all(tmp, "[ ]+", " ")
tmp <- str_trim(tmp)
tmp <- str_split(tmp, " ")
tmp <- lapply(tmp, FUN = function(x) { x <- x[-1]})

nAmerica <- unlist(tmp)

#gets all the pacific countries
pacific.raw <- read_html("http://www.lonelyplanet.com/places")
text <- vector()
for(i in 1:26){
  css = paste("#tab-pacific > div:nth-child(",i,")", sep="")
  pacific.elements <- pacific.raw %>% html_node(css = css)
  text[i] <- html_text(pacific.elements)
}

tmp <- str_replace_all(text, " ", "-")
tmp <- str_replace_all(tmp, "\n", " ")
tmp <- tolower(tmp)
tmp <- str_replace_all(tmp, "[ ]+", " ")
tmp <- str_trim(tmp)
tmp <- str_split(tmp, " ")
tmp <- lapply(tmp, FUN = function(x) { x <- x[-1]})

pacific <- unlist(tmp)

#gets all the south american countries
sAmerica.raw <- read_html("http://www.lonelyplanet.com/places")
text <- vector()
for(i in 1:26){
  css = paste("#tab-south-america > div:nth-child(",i,")", sep="")
  sAmerica.elements <- sAmerica.raw %>% html_node(css = css)
  text[i] <- html_text(sAmerica.elements)
}

tmp <- str_replace_all(text, " ", "-")
tmp <- str_replace_all(tmp, "\n", " ")
tmp <- tolower(tmp)
tmp <- str_replace_all(tmp, "[ ]+", " ")
tmp <- str_trim(tmp)
tmp <- str_split(tmp, " ")
tmp <- lapply(tmp, FUN = function(x) { x <- x[-1]})

sAmerica <- unlist(tmp)


##combines them all together
world <- c(africa, asia, caribbean, cAmerica, europe, mEast, nAmerica, pacific, sAmerica)
#cleans off the & sign
world <- str_replace_all(world, "&", "and")

worldB <- str_replace_all(world, "-", " ")
worldB <- str_replace_all(worldB, "\\bthe", "")
worldB <- str_trim(worldB)

world <- c(world, "myanmar-burma", "myanmar-burma", "east-timor")
worldB <- c(worldB, "myanmar", "burma", "timor este")

country <- data.frame(country = worldB, countryLP = world)
save(country, "country.RData")
