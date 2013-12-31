# cahgen.rb

PDF generator for Cards Against Humanity

## What is Cards Against Humanity?

It's a [terrible game](http://cardsagainsthumanity.com/).

## What else do I need?

```
gem install prawn
gem install trollop
```

And you're good to go!

## How does it work?

Make a text file, and put each question or answer on a separate line. A file with a bunch of questions might look like this:

```
Git hooks are a secret breeding ground for _____.
______ helps me code until the wee hours of the morning.
```

If you want line breaks in your questions, use a backslash (\) character. Two line breaks is two backslashes. Three line breaks is...you get the idea.

Now all you need to do is run `cahgen`:

```
ruby cahgen.rb --answers answerfile.txt
```

## I thought Cards Against Humanity used white and black cards to differentiate between questions and answers

They do! But I like my printer's ink cartridge and want some left, so instead I'm using punctuation.

## Where's my output file?

It should be labelled "output.pdf".

## Can I change that?

Sure! I mean, you just need to change where `PDFFile` outputs to.

## What else will this do?

Uh, if you put a #hashtag in a card name, it will look in the `icons` directory for a corrsponding image. If said image exists, it will use this image in place of the default image. So you can do editions of cards.