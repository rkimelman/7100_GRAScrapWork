# experiment
vowelPhonemes <- c("aa", "ae", "ah", "eh", "ey", "ih", "iy", "uw")
mappingsToData <- c("Q" , "\\{", "V", "E", "1", "I", "7", "u")
combo2 <- t(combn(vowelPhonemes, 2))
combo2 <- as.data.frame(combo2)
combo3 <- t(combn(vowelPhonemes, 3))
combo3 <- as.data.frame(combo3)

# obtain two random words with "aa" vowel sound

df <- read.csv(file = "pseudoworddata2.csv")
dfNew <- df[which(df$X.1=="4"),,]
# use random configurations to generate words, but always make each word have at least 1 phonological neighbor
# should each rhyming word have same number of syllables, and vowels occur in same positions? can code for that
# generalize above
iterationValue <- 1:56
iterationValue <- as.data.frame(iterationValue)
testFunction3Phonemes <- function(pronunciation){
  testIfPresent <- apply(iterationValue, 1, function(x){
    if(grepl(pronunciation, dfNew[x,2])){
      return(dfNew[x,2])
    }
    else{
      return(NA)
    }
  }
  )
  removeNA <- testIfPresent[!is.na(testIfPresent)]
  return(removeNA)
}
iteration <- 1:64
iteration <- as.data.frame(iteration)
singleVowelWords <- apply(length1, 1, function(x){
  return(testFunction3Phonemes(mappingsToData[x], iteration))
})
iteration <- 1:8
iteration <- as.data.frame(iteration)
get3Words <- apply(iteration, 1, function(x){
  return(sample(singleVowelWords[[x]], size = 3, replace = TRUE))
})
get3Words <- t(get3Words)
# these are the sets of words we will use for a single vowel internal rhyme
#-------------------------------------- The above code works -----------------------
length1 <- 1:length(mappingsToData)
length1 <- as.data.frame(length1)
# matches <- apply(length1, 1, function(x){
#   save <- testFunction(mappingsToData[x])
#   return(save)
# })
# getLengths <- apply(length1, 1, function(x){
#   return(length(unlist(matches[x])))
# })

library(gtools)
perms <- permutations(8,3)
lengthPerms <- 1:nrow(perms)
iteration <- as.data.frame(lengthPerms)
permsVowels <- apply(iteration, 1, function(x){
  return(c(vowelPhonemes[perms[x,1]], vowelPhonemes[perms[x,2]], vowelPhonemes[perms[x,3]]))
})
permsVowels2 <- as.data.frame(t(permsVowels))
permsPhonemes <- apply(iteration, 1, function(x){
  return(c(mappingsToData[perms[x,1]], mappingsToData[perms[x,2]], mappingsToData[perms[x,3]]))
})
permsPhonemes2 <- as.data.frame(t(permsPhonemes))

dfNew2 <- df[which(df$X.1=="4"),,]
iterationNew <- 1:nrow(dfNew2)
iterationNew <- as.data.frame(iterationNew)
testFunction4Phonemes <- function(pronunciation){
  testIfPresent <- apply(iterationNew, 1, function(x){
    if(grepl(pronunciation, dfNew2[x,2])){
      return(dfNew2[x,2])
    }
    else{
      return(NA)
    }
  }
  )
  removeNA <- testIfPresent[!is.na(testIfPresent)]
  return(removeNA)
}

mappingsToData2 <- rep(mappingsToData, 7)
length2 <- 1:length(mappingsToData2)
length2 <- as.data.frame(length2)
words1 <- apply(iteration, 1, function(x){
  return(testFunction4Phonemes(permsPhonemes2$V1[x]))
})
words2 <- apply(iteration, 1, function(x){
  return(testFunction4Phonemes(permsPhonemes2$V2[x]))
})
words3 <- apply(iteration, 1, function(x){
  return(testFunction4Phonemes(permsPhonemes2$V3[x]))
})
getWords1 <- apply(iteration, 1, function(x){
  return(sample(words1[[x]], size = 1))
})
getWords2 <- apply(iteration, 1, function(x){
  return(sample(words2[[x]], size = 1))
})
getWords3 <- apply(iteration, 1, function(x){
  return(sample(words3[[x]], size = 1))
})
getWords1 <- t(getWords1)
getWords2 <- t(getWords2)
getWords3 <- t(getWords3)
getWords1 <- as.vector(getWords1)
getWords2 <- as.vector(getWords2)
getWords3 <- as.vector(getWords3)
permsWords <- cbind(getWords1, getWords2, getWords3)
permsWords <- as.data.frame(permsWords)
# can also just do all in one with replace in permutations?
kuSymbols <- c("p", "t", "k", "b", "d", "g", "C", "J", "s", "S", "z", "Z", "f", "T", "v", "D", "h", "n", "m", "G", "l", "w", "y", "i", "I", "E", "e", "@", "a", "W", "Y", "^", "O", "o", "U", "u")
currentSy <- c("p", "t", "k", "b", "d", "g", "J", "_", "s", "S", "z", "Z", "f", "T", "v", "D", "h", "n", "m", "N", "l", "w", "y", "i", "I", "E",  "E", "\\{","Q", "6", "2", "V","4", "o", "U", "u")
uniqKuSy <- c("C", "J", "G", "e", "@", "a", "W", "Y", "\\^", "O")
uniqCur <-  c("J", "_", "N", "E", "\\{", "Q", "6", "2", "V", "4")

iteration <- 1:length(dfNew2)
iteration <- as.data.frame(iteration)
iteration2 <- 1:length(uniqKuSy)
iteration2 <- as.data.frame(iteration2)
checkEachLetter <- function(word, letterVector, letterReplace, lengthValue){
  save <- apply(lengthValue, 1, function(x){
    if(grepl(letterVector[x], word)){
      newWord <- gsub(letterVector[x], letterReplace[x], word)
      # save2 <- apply(lengthValue, 1, function(x){
      #   if(grepl(letterVector[x], newWord)){
      #     newWord <- gsub(letterVector[x], letterReplace[x], newWord)
      #     return(newWord)
      #   }
      # })
      return(newWord)
      
    }
  })
  return(save)
}
lengthUniqKuSy <- 1:length(uniqKuSy)
lengthUniqKuSy <- as.data.frame(lengthUniqKuSy)
iteration <- 1:nrow(dfNew2)
iteration <- as.data.frame(iteration)
replaceSymbols <- apply(iteration, 1 , function(x){
  checkEachLetter(dfNew2[x,,]$X, uniqCur, uniqKuSy, lengthUniqKuSy)
})

getWords3 <- as.data.frame(getWords3)
colnames(permsWords) <- c("V1", "V2", "V3")
threeVowelCombos <- cbind(getWords3, permsWords)
iteration <- 1:nrow(threeVowelCombos)
iteration <- as.data.frame(iteration)
replaceSymbols <- apply(iteration, 1 , function(x){
  checkEachLetter(threeVowelCombos[x,1], uniqCur, uniqKuSy, lengthUniqKuSy)
})

# -------------------


replaceSymbols2 <- unlist(replaceSymbols)
replaceSymbols3 <- unlist(replaceSymbols2)
replaceSymbols2 <- as.data.frame(cbind(replaceSymbols))
replaceSymbolsAgainIndices <- apply(iteration, 1, function(x){
  if(length(unlist(replaceSymbols2[x,1][[1]])) > 1){
    return(x)
  }
})
replaceSymbolsAgainIndices <- unlist(replaceSymbolsAgainIndices)


replaceSymbolsAgainWords <- apply(iteration, 1, function(x){
  if(length(unlist(replaceSymbols2[x,1][[1]])) == 2){
    return(unlist(replaceSymbols2[x,1][[1]])[2])
  }
})
replaceSymbols3rdTimeIndices <- apply(iteration, 1, function(x){
  if(length(unlist(replaceSymbols2[x,1][[1]])) == 3){
    return(x)
  }
})
replaceSymbols3rdTimeWords <- apply(iteration, 1, function(x){
  if(length(unlist(replaceSymbols2[x,1][[1]])) == 3){
    return(unlist(replaceSymbols2[x,1][[1]])[3])
  }
})
iteration <- 1:nrow(replaceSymbols2)
iteration <- as.data.frame(iteration)
replaceSymbolsOnlyOnceWords <-  apply(iteration, 1, function(x){
  if(length(unlist(replaceSymbols2[x,1][[1]])) == 1){
    return(unlist(replaceSymbols2[x,1][[1]]))
  }
})



replaceSymbolsOnlyOnceWordsIndices <-  apply(iteration, 1, function(x){
  if(length(unlist(replaceSymbols2[x,1][[1]])) == 1){
    return(x)
  }
})

dontReplaceWordsIndices <- apply(iteration, 1, function(x){
  if(is.null(unlist(replaceSymbols2[x,1]))){
    return(x)
  }
})



dontReplaceWordsIndices <- unlist(dontReplaceWordsIndices)
replaceSymbolsOnlyOnceWordsIndices <- unlist(replaceSymbolsOnlyOnceWordsIndices)
replaceSymbolsOnlyOnceWords <- unlist(replaceSymbolsOnlyOnceWords)
replaceSymbols3rdTimeIndices <- unlist(replaceSymbols3rdTimeIndices)
replaceSymbols3rdTimeWords <- unlist(replaceSymbols3rdTimeWords)

threeVowelCombos2 <- threeVowelCombos
threeVowelCombos2[replaceSymbolsOnlyOnceWordsIndices,1] <- replaceSymbolsOnlyOnceWords

replaceSymbolsAgainWords <- unlist(replaceSymbolsAgainWords)
iteration <- 1:length(replaceSymbolsAgainWords)
iteration <- as.data.frame(iteration)
replaceSymbolsAgainWordsTranslation <- apply(iteration, 1 , function(x){
  checkEachLetter(replaceSymbolsAgainWords[x], uniqCur, uniqKuSy, lengthUniqKuSy)
})

replaceSymbolsAgainWordsTranslation <- unlist(replaceSymbolsAgainWordsTranslation)

iteration <- 1:length(replaceSymbols3rdTimeWords)
iteration <- as.data.frame(iteration)
replaceSymbols3rdTimeWordsTranslation <- checkEachLetter(replaceSymbols3rdTimeWords, uniqCur, uniqKuSy, lengthUniqKuSy)

replaceSymbols3rdTimeWordsTranslation <- unlist(replaceSymbols3rdTimeWordsTranslation)
replaceSymbols3rdTimeWordsTranslation <- replaceSymbols3rdTimeWordsTranslation[1]

# iteration <- 1:length(replaceSymbolsAgainWords)
# iteration <- as.data.frame(iteration)
# replaceSymbolsAgain <- apply(iteration, 1 , function(x){
#   checkEachLetter(replaceSymbolsAgainWords[x], uniqCur, uniqKuSy, lengthUniqKuSy)
# })
# replaceSymbolsAgain <- unlist(replaceSymbolsAgain)
threeVowelCombos2[replaceSymbolsAgainIndices,1] <- replaceSymbolsAgainWordsTranslation
threeVowelCombos2[replaceSymbols3rdTimeIndices,1] <- replaceSymbols3rdTimeWordsTranslation
listofFirstSetOfWords <- threeVowelCombos2[,1]
listofFirstSetOfWords <- toString(listofFirstSetOfWords)

iteration <- 1:length(threeVowelCombos2[,1])
iteration <- as.data.frame(iteration)
translateMiscellaneous <- apply(iteration, 1, function(x){
  if(grepl("1", threeVowelCombos2[x,1])){
    return(gsub("1", "ei", threeVowelCombos2[x,1]))
  }
  else{
    return(threeVowelCombos2[x,1])
  }
})

translateMiscellaneous2 <- apply(iteration, 1, function(x){
  if(grepl("7", translateMiscellaneous[x])){
    return(gsub("7", "i", translateMiscellaneous[x]))
  }
  else{
    return(translateMiscellaneous[x])
  }
})
translateMiscellaneous3 <- apply(iteration, 1, function(x){
  if(grepl("1", threeVowelCombos2[x,2])){
    return(gsub("1", "ei", threeVowelCombos2[x,2]))
  }
  else{
    return(threeVowelCombos2[x,2])
  }
})

translateMiscellaneous4 <- apply(iteration, 1, function(x){
  if(grepl("7", translateMiscellaneous3[x])){
    return(gsub("7", "i", translateMiscellaneous3[x]))
  }
  else{
    return(translateMiscellaneous3[x])
  }
})
translateMiscellaneous5 <- apply(iteration, 1, function(x){
  if(grepl("1", threeVowelCombos2[x,3])){
    return(gsub("1", "ei", threeVowelCombos2[x,3]))
  }
  else{
    return(threeVowelCombos2[x,3])
  }
})

translateMiscellaneous6 <- apply(iteration, 1, function(x){
  if(grepl("7", translateMiscellaneous5[x])){
    return(gsub("7", "i", translateMiscellaneous5[x]))
  }
  else{
    return(translateMiscellaneous5[x])
  }
})

finalTranslation <- toString(translateMiscellaneous2)
finalTranslation2 <- toString(translateMiscellaneous4)
finalTranslation3 <- toString(translateMiscellaneous6)

threeVowelCombosDFFirstColumn <- as.data.frame(translateMiscellaneous2)
threeVowelCombosDFSecondColumn <- as.data.frame(translateMiscellaneous4)
threeVowelCombosDFThirdColumn <- as.data.frame(translateMiscellaneous6)

threeVowelCombosDF1 <- cbind(threeVowelCombosDFFirstColumn, threeVowelCombosDFSecondColumn, threeVowelCombosDFThirdColumn)
#write.csv(threeVowelCombosDF1,"threeVowelCombos1.csv", row.names = FALSE)
# saved the one below in a previous run (below when we set permsPhonemes2)
#write.csv(threeVowelCombosDF2,"threeVowelCombos2.csv", row.names = FALSE)


first50RhymingStimuliData <- read.csv(file = 'vowelRhymeCombosAndData/first50RhymingStimuliData.csv')

iteration <- 1:50
iteration2 <- 1:9
iteration <- as.data.frame(iteration)
iteration2 <- as.data.frame(iteration2)
replace <- apply(iteration, 1, function(x){
  returnValue <- apply(iteration2, 1, function(y){
    if(is.na(first50RhymingStimuliData[x,y]) || first50RhymingStimuliData[x,y] == ""){
      return(sample(allWords$X,1))
    }
    else{
      return(first50RhymingStimuliData[x,y])
    }
  })
  return(returnValue)
})
replaceData1 <- as.data.frame(t(replace))



first14EndTwoVowelRhymingStimuliData <- read.csv(file = 'vowelRhymeCombosAndData/first14EndTwoVowelRhymingStimuliData.csv')
iteration <- 1:28
iteration2 <- 1:7
iteration <- as.data.frame(iteration)
iteration2 <- as.data.frame(iteration2)

addWords <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(x){
    return(sample(df[,,]$X,1))
  })
})

addWords <- cbind(addWords)
addWords <- t(addWords)
addWords <- as.data.frame(addWords)

replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  save <- apply(iteration2, 1, function(y){
    return(checkEachLetter2(addWords[x,y], kuUniq, IPAUniq, iteration2))
  })
  return(save)
})

replaceKuSymbolsIPA <- cbind(replaceKuSymbolsIPA)
replaceKuSymbolsIPA <- t(replaceKuSymbolsIPA)
replaceKuSymbolsIPA <- as.data.frame(replaceKuSymbolsIPA)

first14EndTwoVowelRhymingStimuliData[1:28,1:7] <- replaceKuSymbolsIPA
iteration2 <- 1:9
iteration2 <- as.data.frame(iteration2)
first14EndTwoVowelRhymingStimuliData <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    return(unlist(first14EndTwoVowelRhymingStimuliData[x,y]))
  })
})

first14EndTwoVowelRhymingStimuliData <- cbind(first14EndTwoVowelRhymingStimuliData)
first14EndTwoVowelRhymingStimuliData <- t(first14EndTwoVowelRhymingStimuliData)
first14EndTwoVowelRhymingStimuliData <- as.data.frame(first14EndTwoVowelRhymingStimuliData)


#write.csv(first14EndTwoVowelRhymingStimuliData,"vowelRhymeCombosAndData/first14EndTwoVowelRhymingStimuliData.csv", row.names = FALSE)

# iteration <- 1:28
# iteration2 <- 1:9
# iteration <- as.data.frame(iteration)
# iteration2 <- as.data.frame(iteration2)
# replace <- apply(iteration, 1, function(x){
#   returnValue <- apply(iteration2, 1, function(y){
#     if(is.na(first14EndTwoVowelRhymingStimuliData[x,y]) || first14EndTwoVowelRhymingStimuliData[x,y] == ""){
#       return(sample(allWords$X,1))
#     }
#     else{
#       return(first14EndTwoVowelRhymingStimuliData[x,y])
#     }
#   })
#   return(returnValue)
# })
# replaceData2 <- as.data.frame(t(replace))

first36internalThreeVowelRhymingStimuliData <- read.csv(file = 'vowelRhymeCombosAndData/first36internalThreeVowelRhymingStimuliData.csv')

iteration <- 1:36
iteration2 <- 1:9
iteration <- as.data.frame(iteration)
iteration2 <- as.data.frame(iteration2)
replace <- apply(iteration, 1, function(x){
  returnValue <- apply(iteration2, 1, function(y){
    if(is.na(first36internalThreeVowelRhymingStimuliData[x,y]) || first36internalThreeVowelRhymingStimuliData[x,y] == ""){
      return(sample(allWords$X,1))
    }
    else{
      return(first36internalThreeVowelRhymingStimuliData[x,y])
    }
  })
  return(returnValue)
})
replaceData3 <- as.data.frame(t(replace))

first100Rhymes <- rbind(replaceData1, replaceData2, replaceData3)

#write.csv(first100Rhymes,"vowelRhymeCombosAndData/first100RhymesFinal.csv", row.names = FALSE)

first50EndThreeVowelRhymingStimuliData <- read.csv(file = 'vowelRhymeCombosAndData/first50EndThreeVowelRhymingStimuliData.csv')

iteration <- 1:100
iteration2 <- 1:9
iteration <- as.data.frame(iteration)
iteration2 <- as.data.frame(iteration2)
replace <- apply(iteration, 1, function(x){
  returnValue <- apply(iteration2, 1, function(y){
    if(is.na(first50EndThreeVowelRhymingStimuliData[x,y]) || first50EndThreeVowelRhymingStimuliData[x,y] == ""){
      return(sample(allWords$X,1))
    }
    else{
      return(first50EndThreeVowelRhymingStimuliData[x,y])
    }
  })
  return(returnValue)
})
replaceData4 <- as.data.frame(t(replace))

first50SplitThreeVowelRhymingStimuliData <- read.csv(file = 'vowelRhymeCombosAndData/first50SplitThreeVowelRhymingStimuliData.csv')

iteration <- 1:100
iteration2 <- 1:9
iteration <- as.data.frame(iteration)
iteration2 <- as.data.frame(iteration2)
replace <- apply(iteration, 1, function(x){
  returnValue <- apply(iteration2, 1, function(y){
    if(is.na(first50SplitThreeVowelRhymingStimuliData[x,y]) || first50SplitThreeVowelRhymingStimuliData[x,y] == ""){
      return(sample(allWords$X,1))
    }
    else{
      return(first50SplitThreeVowelRhymingStimuliData[x,y])
    }
  })
  return(returnValue)
})
replaceData5 <- as.data.frame(t(replace))

second100Rhymes <- rbind(replaceData4, replaceData5)

# write.csv(second100Rhymes,"vowelRhymeCombosAndData/second100RhymesFinal.csv", row.names = FALSE)

iteration <- 1:(50)
iteration2 <- 1:9
iteration <- as.data.frame(iteration)
iteration2 <- as.data.frame(iteration2)

first50NonRhymingData <- apply(iteration, 1, function(x){
  returnValue <- apply(iteration2, 1, function(x){
    return(sample(df[,,]$X,1))
  })
  return(returnValue)  
})

first50NonRhymingData <- as.data.frame(t(first50NonRhymingData))
write.csv(first50NonRhymingData,"vowelRhymeCombosAndData/first50NonRhymingData.csv", row.names = FALSE)

second50InternalThreeVowelRhymingStimuliData <- read.csv(file = 'vowelRhymeCombosAndData/second50InternalThreeVowelRhymingStimuliData.csv')

allWords <- df[-(1:7),,]

oneVowelRhymeCombos <- read.csv(file = 'vowelRhymeCombosAndData/oneVowelRhymeCombos.csv')

threeVowelCombosDF2 <- read.csv(file = 'threeVowelCombos2.csv')

# convert current configuration to IPA and then read in to https://itinerarium.github.io/phoneme-synthesis/

kuSymbolsAll <- c("C", "J", "G", "e", "@", "a", "W", "Y", "\\^", "O", "p", "t", "k", "b", "d",
                  "g", "C", "J", "s", "S", "z", "Z", "f", "T", "v", "D", "h", "n", "m", "G", "l", "w", "y", "i", "I", "E", "e", "@", "a", "W", "Y", "^", "O", "o", "U", "u")
kuSymbols <- c("p", "t", "k", "b", "d", "g", "C", "J", "s", "S", "z", "Z", "f", "T", "v", "D", "h", "n", "m", "G", "l", "w", "y", "i", "I", "E", "e", "@", "a", "W", "Y", "^", "O", "o", "U", "u")

kuIPAMapping <- c("p", "t", "k", "b", "d", "g", "tS", "dZ", "s", "S", "z", "Z", "f", "T", "v", "D", "h", "n", "m", "N", "l", "w", "j", "i", "I", "E", "e", "aa", "a", "aU", "aI", "V", "OI", "o", "U", "u")

kuUniq <- c("C", "J", "G", "y", "@", "W", "Y", "\\^", "O")
IPAUniq <- c("tS", "dZ", "N", "j", "aa", "aU", "aI", "V", "OI")

replaceCount <- function(word, letterVector, lengthValue){
  save <- apply(lengthValue, 1, function(x){
    if(grepl(letterVector[x], word)){
      # save2 <- apply(lengthValue, 1, function(x){
      #   if(grepl(letterVector[x], newWord)){
      #     newWord <- gsub(letterVector[x], letterReplace[x], newWord)
      #     return(newWord)
      #   }
      # })
      return(1)
      
    }
  })
  return(save)
}
iteration <- 1:(900)
iteration <- as.data.frame(iteration)
iteration2 <- 1:length(kuUniq)
iteration2 <- as.data.frame(iteration2)
second50InternalThreeVowelRhymingStimuliDataList <- unlist(second50InternalThreeVowelRhymingStimuliData)
replaceKuWithIPAIndicesTotals <- apply(iteration, 1, function(x){
  return(replaceCount(second50InternalThreeVowelRhymingStimuliDataList[x], kuUniq, iteration2))
})
findTotalsEachWord <- apply(iteration, 1, function(x){
  return(unlist(replaceKuWithIPAIndicesTotals[[x]]))
})
iteration <- 1:100
iteration <- as.data.frame(iteration)
findTotalsEachWord2 <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    return(findTotalsEachWord[[x+y]])
  })
  return(save)
})

findTotalsEachWord3 <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    if(y == 1 || y == 2 || y == 3 || y == 7 || y == 8 || y == 9){
      return(findTotalsEachWord2[[x]][[y]])
    }
  })
})

findTotalsEachWordDf <- cbind(findTotalsEachWord3)



iteration <- 1:900
iteration <- as.data.frame(iteration)
replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  checkEachLetter(second50InternalThreeVowelRhymingStimuliDataList[[x]], kuUniq, IPAUniq, iteration2)
})
iteration <- 1:100
iteration <- as.data.frame(iteration)
# function right below is fixed
replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  save <- apply(iteration2, 1, function(y){
    return(checkEachLetter(second50InternalThreeVowelRhymingStimuliData[x,y], kuUniq, IPAUniq, iteration2))
  })
  return(save)
})
replaceKuSymbolsIPADf <- cbind(replaceKuSymbolsIPA)

replaceKuSymbolsIPADf2 <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    if(is.null(unlist(replaceKuSymbolsIPADf[x,]$replaceKuSymbolsIPA[[y]]))){
      return(NA)
    }
    else{
      return(unlist(replaceKuSymbolsIPADf[x,]$replaceKuSymbolsIPA[[y]]))
    }
  })
  return(save)
})

replaceKuSymbolsIPADf2 <- cbind(replaceKuSymbolsIPADf2)
replaceKuSymbolsIPADf2 <- t(replaceKuSymbolsIPADf2)
replaceKuSymbolsIPADf2 <- as.data.frame(replaceKuSymbolsIPADf2)

replaceKuSymbolsIPADf3 <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    if(is.na(replaceKuSymbolsIPADf2[x,y])){
      return(NA)
    }
    else{
      return(c(x,y))
    }
  })
  return(save)
})
replaceKuSymbolsIPADf4 <- apply(iteration, 1, function(x){
  if(any(is.na(replaceKuSymbolsIPADf3[[x]]) == FALSE)){
    return(x)
  }
  else{
    return(0)
  }
})
  indices <- which(!is.na(replaceKuSymbolsIPADf3))
indicesReplace <- replaceKuSymbolsIPADf3[[indices]]
replaceKuSymbolsIPADf3 <- t(replaceKuSymbolsIPADf3)
replaceKuSymbolsIPADfNumberOne <- as.data.frame(replaceKuSymbolsIPADf3)

# ------------- do the above again to replace for a second time but beginning data is dfNumberOne and ending function is dfNumberTwo
replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  save <- apply(iteration2, 1, function(y){
    return(checkEachLetter(replaceKuSymbolsIPADNumberOne[x,y], kuUniq, IPAUniq, iteration2))
  })
  return(save)
})
replaceKuSymbolsIPADf <- cbind(replaceKuSymbolsIPA)

replaceKuSymbolsIPADf2 <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    if(is.null(unlist(replaceKuSymbolsIPADf[x,]$replaceKuSymbolsIPA[[y]]))){
      return(NA)
    }
    else{
      return(unlist(replaceKuSymbolsIPADf[x,]$replaceKuSymbolsIPA[[y]]))
    }
  })
  return(save)
})

replaceKuSymbolsIPADf2 <- cbind(replaceKuSymbolsIPADf2)
replaceKuSymbolsIPADf2 <- t(replaceKuSymbolsIPADf2)
replaceKuSymbolsIPADf2 <- as.data.frame(replaceKuSymbolsIPADf2)

replaceKuSymbolsIPADf3 <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    if(is.null(unlist(replaceKuSymbolsIPADf2[x,]$replaceKuSymbolsIPADf2[[y]]))){
      return(NA)
    }
    else{
      return(unlist(replaceKuSymbolsIPADf2[x,]$replaceKuSymbolsIPADf2[[y]][1]))
    }
  })
  return(save)
})
replaceKuSymbolsIPADf3 <- t(replaceKuSymbolsIPADf3)
replaceKuSymbolsIPADfNumberTwo <- as.data.frame(replaceKuSymbolsIPADf3)
# ----------
iteration3 <- 0:5
iteration3 <- as.data.frame(iteration3)
replaceKuSymbolsIPADf4 <- apply(iteration, 1, function(x){
  save <- apply(iteration3, 1, function(y){
    return(replaceKuSymbolsIPADf3[x+y])
  })
  return(save)
})

replaceKuSymbolsIPADf4 <- cbind(replaceKuSymbolsIPADf4)
replaceKuSymbolsIPADf4 <- apply(iteration, 1, function(x){
  if(!is.null(unlist(replaceKuSymbolsIPADf4[x,]$replaceKuSymbolsIPADf4))){
    return(unlist(replaceKuSymbolsIPADf4[x,]))
  }
})


indices <- replaceKuSymbolsIPADf4

NAtoNull <- function(x) {
  x <- NULL
  return(x)
}

replaceKuSymbolsIPADf5 <- apply(iteration, 1, function(x){
    if(all(is.na(replaceKuSymbolsIPADf2[x,]))){
      save <- apply(iteration2, 1, function(y){
        NAtoNull(replaceKuSymbolsIPADf2[x,y])
      })
    }
    else{
      save <- apply(iteration2, 1, function(y){
        return(replaceKuSymbolsIPADf2[x,y])
      })
    }
  return(save)
})

replaceKuSymbolsIPADf5 <- cbind(replaceKuSymbolsIPADf5)

replaceKuSymbolsIPADf6 <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    if(is.null(replaceKuSymbolsIPADf5[x,]$replaceKuSymbolsIPADf5)){
      return("z")
    }
    else{
      return(replaceKuSymbolsIPADf5[[x]][y])
    }
  })
    
})

replaceKuSymbolsIPADf6 <- apply(iteration, 1 , function(x){
  if(indices[x] != 0){
    save <- apply(iteration2, 1, function(y){
    if(all(is.na(replaceKuSymbolsIPADf2[x,y]))){
      if(length(unlist(replaceKuSymbolsIPADf2[x,y])) > 1){
        checkEachLetter(replaceKuSymbolsIPADf2[x,y][[1]][2], kuUniq, IPAUniq, iteration2)
      }
      if(is.na(replaceKuSymbolsIPADf2[x,y])){
        return(second50InternalThreeVowelRhymingStimuliData[x,y])
      }
      else{
        return(replaceKuSymbolsIPADf2[x,y])
      }
    }
    else{
      return(second50InternalThreeVowelRhymingStimuliData[x,y])
    }
    })
  }
  else{
    save <- apply(iteration2, 1, function(y){
      return(second50InternalThreeVowelRhymingStimuliData[x,y])
    })
  }
  return(save)
})

replaceKuSymbolsIPADf6 <- cbind(replaceKuSymbolsIPADf6)
replaceKuSymbolsIPADf6 <- as.data.frame(replaceKuSymbolsIPADf6)
replaceKuSymbolsIPADf6 <- t(replaceKuSymbolsIPADf6)

replace <- apply(iteration, 1, function(x){
  returnValue <- apply(iteration2, 1, function(y){
    if(is.na(replaceKuSymbolsIPADf6[x,y])){
      return(sample(allWords$X,1))
    }
    else{
      return(replaceKuSymbolsIPADf6[x,y])
    }
  })
  return(returnValue)
})

findTotalsEachWord4 <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    if(length(findTotalsEachWordDf[x,]$findTotalsEachWord3[[1]] > 1)){
      return()
    }
  }
  )})

replace <- t(replace)
replace <- as.data.frame(replace)
checkEachLetter2 <- function(word, letterVector, letterReplace, lengthValue){
  index <- apply(lengthValue, 1, function(x){
    if(grepl(letterVector[x], word)){
      newWord <- gsub(letterVector[x], letterReplace[x], word)
      # save2 <- apply(lengthValue, 1, function(x){
      #   if(grepl(letterVector[x], newWord)){
      #     newWord <- gsub(letterVector[x], letterReplace[x], newWord)
      #     return(newWord)
      #   }
      # })
      return(x)
    }
  })
  index <- unlist(index)
  # index2 <- lapply(iteration2,1, function(x){
  #   if(!is.null(index[[x]])){
  #     
  #   }
  # })
  save <- apply(lengthValue, 1, function(x){
    if(grepl(letterVector[x], word)){
      newWord <- gsub(letterVector[x], letterReplace[x], word)
      # save2 <- apply(lengthValue, 1, function(x){
      #   if(grepl(letterVector[x], newWord)){
      #     newWord <- gsub(letterVector[x], letterReplace[x], newWord)
      #     return(newWord)
      #   }
      # })
      return(newWord)
    }
  })
  # save <- as.character(save)
  if(is.null(save) ){
    save <- word
    index <- 1
  }
  return(save[index])
}
replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  save2 <- apply(iteration2, 1, function(y){
    checkEachLetter2(replace[x,y], kuUniq, IPAUniq, iteration2)
  })
  return(save2)
})
replaceKuSymbolsIPA <- cbind(replaceKuSymbolsIPA)
replaceKuSymbolsIPA <- as.data.frame(replaceKuSymbolsIPA)

replaceKuSymbolsIPA2 <- apply(iteration, 1 , function(x){
  if(is.list(replaceKuSymbolsIPA[x,][[1]])){
    return(as.character(replaceKuSymbolsIPA[x,][[1]]))
  }
  else{
    return(replaceKuSymbolsIPA[x,][[1]])
  }
})

replaceKuSymbolsIPA8 <- cbind(replaceKuSymbolsIPA2)
replaceKuSymbolsIPA8 <- t(replaceKuSymbolsIPA2)
replaceKuSymbolsIPA8 <- as.data.frame(replaceKuSymbolsIPA8)

#write.csv(replaceKuSymbolsIPA8,"IPAFORMAT_second50InternalThreeVowelRhymingStimuliData.csv", row.names = FALSE)

# ----------------------------------------      the above takes care of first 50 rhyming stimuli          --------------------------------------------------

first50SplitThreeVowelRhymingStimuliData

replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  save <- apply(iteration2, 1, function(y){
    return(checkEachLetter2(first50SplitThreeVowelRhymingStimuliData[x,y], kuUniq, IPAUniq, iteration2))
  })
  return(save)
})
replaceKuSymbolsIPADf <- cbind(replaceKuSymbolsIPA)
replaceKuSymbolsIPADf <- as.data.frame(replaceKuSymbolsIPADf)

replaceKuSymbolsIPADf2 <- apply(iteration, 1, function(x){
  return(unlist(replaceKuSymbolsIPADf[x,][[1]]))
})

replaceKuSymbolsIPADf2 <- cbind(replaceKuSymbolsIPADf2)
replaceKuSymbolsIPADf2 <- t(replaceKuSymbolsIPADf2)
replaceKuSymbolsIPADf2 <- as.data.frame(replaceKuSymbolsIPADf2)

# write.csv(replaceKuSymbolsIPADf2,"IPAFORMAT_first50SplitThreeVowelRhymingStimuliData.csv", row.names = FALSE)

# -----------------------------------# -----------------------------------# -----------------------------------# -----------------------------------

first14EndTwoVowelRhymingStimuliData <- read.csv(file = "vowelRhymeCombosAndData/first14EndTwoVowelRhymingStimuliData.csv")
iteration <- 1:28
iteration <- as.data.frame(iteration)
replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  save <- apply(iteration2, 1, function(y){
    return(checkEachLetter2(first14EndTwoVowelRhymingStimuliData[x,y], kuUniq, IPAUniq, iteration2))
  })
  return(save)
})
replaceKuSymbolsIPADf <- cbind(replaceKuSymbolsIPA)
replaceKuSymbolsIPADf <- t(replaceKuSymbolsIPADf)
replaceKuSymbolsIPADf <- as.data.frame(replaceKuSymbolsIPADf)

replaceKuSymbolsIPADf2 <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    return(unlist(replaceKuSymbolsIPADf[x,y][[1]]))
  })
  return(save) 
})

replaceKuSymbolsIPADf2 <- cbind(replaceKuSymbolsIPADf2)
replaceKuSymbolsIPADf2 <- t(replaceKuSymbolsIPADf2)
replaceKuSymbolsIPADf2 <- as.data.frame(replaceKuSymbolsIPADf2)

#write.csv(replaceKuSymbolsIPADf2,"IPAFORMAT_first14EndTwoVowelRhymingStimuliData.csv", row.names = FALSE)

first36internalThreeVowelRhymingStimuliData <- read.csv("vowelRhymeCombosAndData/first36internalThreeVowelRhymingStimuliData.csv")

iteration <- 1:36
iteration <- as.data.frame(iteration)
replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  save <- apply(iteration2, 1, function(y){
    return(checkEachLetter2(first36internalThreeVowelRhymingStimuliData[x,y], kuUniq, IPAUniq, iteration2))
  })
  return(save)
})

replaceKuSymbolsIPADf <- cbind(replaceKuSymbolsIPA)

replaceKuSymbolsIPA2 <- apply(iteration, 1, function(x){
  return(unlist(replaceKuSymbolsIPADf[x,]))
})

replaceKuSymbolsIPADf2 <- cbind(replaceKuSymbolsIPA2)
replaceKuSymbolsIPADf2[32,]$replaceKuSymbolsIPA2[7] <- "kVndZ"
replaceKuSymbolsIPADf2[32,]$replaceKuSymbolsIPA2 <- replaceKuSymbolsIPADf2[32,]$replaceKuSymbolsIPA2[-8]
replaceKuSymbolsIPADf2 <- as.data.frame(replaceKuSymbolsIPADf2)

replaceKuSymbolsIPA3 <- apply(iteration, 1, function(x){
  return(unlist(replaceKuSymbolsIPADf2[x,]))
})

replaceKuSymbolsIPA3 <- t(replaceKuSymbolsIPA3)
replaceKuSymbolsIPA3 <- as.data.frame(replaceKuSymbolsIPA3)

#write.csv(replaceKuSymbolsIPA3,"IPAFORMAT_first36internalThreeVowelRhymingStimuliData.csv", row.names = FALSE)

# ------------------------------------------------------------------------------------

first50EndThreeVowelRhymingStimuliData <- read.csv(file = "vowelRhymeCombosAndData/IPAfirst50EndThreeVowelRhymingStimuliData.csv")

iteration <- 1:100
iteration <- as.data.frame(iteration)
replaceKuSymbolsKu <- apply(iteration, 1 , function(x){
  save <- apply(iteration2, 1, function(y){
    return(checkEachLetter2(first50EndThreeVowelRhymingStimuliData[x,y], IPAUniq, kuUniq, iteration2))
  })
  return(save)
})

replaceKuSymbolsIPADf <- cbind(replaceKuSymbolsKu)

replaceKuSymbolsIPA2 <- apply(iteration, 1, function(x){
  return(as.character(unlist(replaceKuSymbolsIPADf[x,])))
})

replaceKuSymbolsIPADf <- cbind(replaceKuSymbolsIPA2)
replaceKuSymbolsIPADf <- as.data.frame(replaceKuSymbolsIPADf)

# replaceKuSymbolsIPADf[24,7] <- "brVtS"
# replaceKuSymbolsIPADf
# 
# replaceKuSymbolsIPADf[34,7] <- "daaldZ"
# replaceKuSymbolsIPADf
# 
# replaceKuSymbolsIPADf[66,7] <- "kVldZ"
# replaceKuSymbolsIPADf

# replaceKuSymbolsIPA2 <- cbind(replaceKuSymbolsIPA2)
# replaceKuSymbolsIPA2 <- t(replaceKuSymbolsIPA2)
# replaceKuSymbolsIPA2 <- as.data.frame(replaceKuSymbolsIPA2)

write.csv(replaceKuSymbolsIPADf,"vowelRhymeCombosAndData/first50EndThreeVowelRhymingStimuliData.csv", row.names = FALSE)

# --------------------------------------------------------------------------------------------------------

first50NonRhymingData <- read.csv(file = "vowelRhymeCombosAndData/first50NonRhymingData.csv")
iteration <- 1:50
iteration <- as.data.frame(iteration)
replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  save <- apply(iteration2, 1, function(y){
    return(checkEachLetter2(first50NonRhymingData[x,y], kuUniq, IPAUniq, iteration2))
  })
  return(save)
})

replaceKuSymbolsIPADf <- cbind(replaceKuSymbolsIPA)

replaceKuSymbolsIPADf2 <- apply(iteration, 1, function(x){
  return(unlist(replaceKuSymbolsIPADf[x,]))
})

replaceKuSymbolsIPADf3 <- t(replaceKuSymbolsIPADf2)
replaceKuSymbolsIPADf3 <- cbind(replaceKuSymbolsIPADf3)
replaceKuSymbolsIPADf4 <- as.data.frame(replaceKuSymbolsIPADf3)

#write.csv(replaceKuSymbolsIPADf4,"IPAFORMAT_first50NonRhymingStimuliData.csv", row.names = FALSE)

second50NonRhymingData <- read.csv(file = "vowelRhymeCombosAndData/second50NonRhymingData.csv")
iteration <- 1:50
iteration <- as.data.frame(iteration)
replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  save <- apply(iteration2, 1, function(y){
    return(checkEachLetter2(second50NonRhymingData[x,y], kuUniq, IPAUniq, iteration2))
  })
  return(save)
})

replaceKuSymbolsIPADf <- cbind(replaceKuSymbolsIPA)
replaceKuSymbolsIPADf2 <- t(replaceKuSymbolsIPADf)
replaceKuSymbolsIPADf5 <- as.data.frame(replaceKuSymbolsIPADf5)

#write.csv(replaceKuSymbolsIPADf5,"IPAFORMAT_second50NonRhymingStimuliData.csv", row.names = FALSE)

third50NonRhymingData <- read.csv(file = "vowelRhymeCombosAndData/third50NonRhymingData.csv")

iteration <- 1:50
iteration <- as.data.frame(iteration)
replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  save <- apply(iteration2, 1, function(y){
    return(checkEachLetter2(third50NonRhymingData[x,y], kuUniq, IPAUniq, iteration2))
  })
  return(save)
})

replaceKuSymbolsIPADf <- cbind(replaceKuSymbolsIPA)

replaceKuSymbolsIPA3 <- apply(iteration, 1, function(x){
  return(unlist(replaceKuSymbolsIPADf[x,]))
})

replaceKuSymbolsIPADf4 <- cbind(replaceKuSymbolsIPA3)
replaceKuSymbolsIPADf5 <- t(replaceKuSymbolsIPADf4)
replaceKuSymbolsIPADf5 <- as.data.frame(replaceKuSymbolsIPADf5)

#write.csv(replaceKuSymbolsIPADf5,"IPAFORMAT_third50NonRhymingStimuliData.csv", row.names = FALSE)

fourth50NonRhymingData <- read.csv(file = "vowelRhymeCombosAndData/fourth50NonRhymingData.csv")

iteration <- 1:50
iteration <- as.data.frame(iteration)
replaceKuSymbolsIPA <- apply(iteration, 1 , function(x){
  save <- apply(iteration2, 1, function(y){
    return(checkEachLetter2(fourth50NonRhymingData[x,y], kuUniq, IPAUniq, iteration2))
  })
  return(save)
})

replaceKuSymbolsIPADf <- cbind(replaceKuSymbolsIPA)
replaceKuSymbolsIPADf <- t(replaceKuSymbolsIPADf)

replaceKuSymbolsIPA3 <- apply(iteration, 1, function(x){
  return(unlist(replaceKuSymbolsIPADf[x,]))
})

replaceKuSymbolsIPADf4 <- cbind(replaceKuSymbolsIPA3)
replaceKuSymbolsIPADf5 <- t(replaceKuSymbolsIPADf4)
replaceKuSymbolsIPADf5 <- as.data.frame(replaceKuSymbolsIPADf5)

#write.csv(replaceKuSymbolsIPADf5,"IPAFORMAT_fourth50NonRhymingStimuliData.csv", row.names = FALSE)

first14EndTwoVowelRhymingStimuliData <- read.csv(file = 'vowelRhymeCombosAndData/first14EndTwoVowelRhymingStimuliData.csv')

iteration <- 1:28
iteration <- as.data.frame(iteration)
iteration2 <- 1:9
iteration2 <- as.data.frame(iteration2)
first14EndTwoVowelRhymingStimuliData2 <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    if(is.na(first14EndTwoVowelRhymingStimuliData[x,y])){
      return(sample(df[,,]$X,1))
    }
    else{
      return(first14EndTwoVowelRhymingStimuliData[x,y])
    }
  })
})

first14EndTwoVowelRhymingStimuliData2 <- cbind(first14EndTwoVowelRhymingStimuliData2)
first14EndTwoVowelRhymingStimuliData2 <- t(first14EndTwoVowelRhymingStimuliData2)
first14EndTwoVowelRhymingStimuliData2 <- as.data.frame(first14EndTwoVowelRhymingStimuliData2)

first14EndTwoVowelRhymingStimuliData3 <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    if(y < 7){
      return(checkEachLetter2(third50NonRhymingData[x,y], kuUniq, IPAUniq, iteration2))
    }
    else{
      return(first14EndTwoVowelRhymingStimuliData2[x,y])
    }
  })
  return(save)
})

first14EndTwoVowelRhymingStimuliData4 <- cbind(first14EndTwoVowelRhymingStimuliData3)

replaceKuSymbolsIPA3 <- apply(iteration, 1, function(x){
  return(unlist(first14EndTwoVowelRhymingStimuliData4[x,]))
})

first14EndTwoVowelRhymingStimuliData5 <- t(replaceKuSymbolsIPA3)
first14EndTwoVowelRhymingStimuliData5 <- as.data.frame(first14EndTwoVowelRhymingStimuliData5)
#write.csv(replaceKuSymbolsIPADf5,"vowelRhymeCombosAndData/first14EndTwoVowelRhymingStimuliData.csv", row.names = FALSE)

first50EndThreeVowelRhymingStimuliData <- read.csv(file = "vowelRhymeCombosAndData/IPAFORMAT_first50EndThreeVowelRhymingStimuliData.csv")
iteration <- 1:100
iteration <- as.data.frame(iteration)
iteration2 <- 1:9
iteration2 <- as.data.frame(iteration2)
first50EndThreeVowelRhymingStimuliData <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    if(is.na(first50EndThreeVowelRhymingStimuliData[x,y])){
      return(sample(df[,,]$X,1))
    }
    else{
      return(first50EndThreeVowelRhymingStimuliData[x,y])
    }
  })
})

first50EndThreeVowelRhymingStimuliData <- cbind(first50EndThreeVowelRhymingStimuliData)
first50EndThreeVowelRhymingStimuliData <- t(first50EndThreeVowelRhymingStimuliData)
first50EndThreeVowelRhymingStimuliData <- as.data.frame(first50EndThreeVowelRhymingStimuliData)

first50EndThreeVowelRhymingStimuliData <- apply(iteration, 1, function(x){
  save <- apply(iteration2, 1, function(y){
    if(y < 7){
      return(checkEachLetter2(first50EndThreeVowelRhymingStimuliData[x,y], kuUniq, IPAUniq, iteration2))
    }
    else{
      return(first50EndThreeVowelRhymingStimuliData[x,y])
    }
  })
  return(save)
})

first50EndThreeVowelRhymingStimuliData <- cbind(first50EndThreeVowelRhymingStimuliData)

replaceKuSymbolsIPA3 <- apply(iteration, 1, function(x){
  return(unlist(first50EndThreeVowelRhymingStimuliData[x,]))
})
first50EndThreeVowelRhymingStimuliData <- t(replaceKuSymbolsIPA3)
first50EndThreeVowelRhymingStimuliData <- as.data.frame(first50EndThreeVowelRhymingStimuliData)

#write.csv(first50EndThreeVowelRhymingStimuliData,"vowelRhymeCombosAndData/IPAfirst50EndThreeVowelRhymingStimuliData.csv", row.names = FALSE)


