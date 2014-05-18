# README
The program reads a text file from the stdin and produces a concordance of all the words in the text. Test inputs are provided in the directory `test_docs`
## Requirements
* ruby (developed and tested on ruby 2.1.1)

## Instructions
To run the program, the following command can be used.

`ruby test_client.rb`

## Overview
The algorithm can be broken down into the following parts.
* Extract sentences from the given text by using a single white space, period (dot) and a capital letter as the sentence delimiter.
* Extract words from each sentence by sanitizing the punctuation symbols like comma, exclamation mark, quotation marks, asterick etc. However, punctuation symbols inside a word are preserved. E.g. index-of, it's etc.
* The algorithm also considers some of the commonly used latin abbreviations like e.g., etc., a.m., p.m. etc. If the word matches a known abbreviation, the leading or trailing punctuations are not removed. The abbreviations used in the program are taken from [this wikipedia page](http://en.wikipedia.org/wiki/List_of_Latin_abbreviations)
* Finally the word is added to a result hash, storing the count and line of occurrence.

## Limitations
The program makes certain assumptions about the structure of sentences and usage of words.
* The program assumes that a sentence always begins with a capital letter and ends with a period. 
* The program ignores abbreviations spanning across multiple words with spaces. E.g. pro tem.
