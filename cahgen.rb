#!/usr/bin/env ruby

# Turns a list of questions or answers for CaH into PDF pages
# 
# Usage:
# cahgen -q questions.txt
# cahgen -a answers.txt
#
# If no file is supplied, reads questions and answers from STDIN.
# 
# Questions and answers are delimited by newlines. In order to have a multiline
# question or answer, finish the line with a backslash.

# Rubygem includes
require "prawn"
require "trollop"

# Library includes
require "./lib/inputfile"
require "./lib/blank_input"
require "./lib/question_pdf"
require "./lib/answer_pdf"

opts = Trollop.options do
  opt :question, "These should be formatted as questions"
  opt :answer, "These should be formatted as answers"
  opt :blank, "Make a blank sheet"
  opt :single, "Make a single card"
end

input = if opts[:blank]
  BlankInput.new
elsif ARGV.size > 0
  InputFile.from_file ARGV.shift
else
  InputFile.from_stdin
end

output_class = if opts[:question]
  QuestionPDF
else
  AnswerPDF
end

output = output_class.new(input)

output.render!