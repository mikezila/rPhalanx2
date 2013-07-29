# rPhalanx2

## What is this?
It's a very early and equally poor re-make of the SNES/GBA/ancient Sharp PC game Phalanx.  A game that is mostly famous for having an old guy with a banjo on the north american SNES box art.

## Why 2?
This is my second attempt at remaking the game, or at least its engine.  This version includes support for gamestates, object tagging, and is generally much cleaner than my initial attempt.  The first time I did things quickly to make cheap progress, this time I did things correctly.  Well, more correctly.

## Why?
Just as a programming exercise, for fun.  I don't actually plan to turn this into a full game.  If I do I'll be changing the name and replacing the art obviously.  I'm mainly sharing so that other beginner Rubyists can see the code and draw inspiration from it.  Or steal bits of it.  I don't know or care about licenses, so any code in this project is yours to use however you want.  This doesn't apply to the art, since that was lifted from an SNES game.

## Requirements
Just Ruby and the Gosu gem.  If you're on Windows use Ruby 1.9.3, as Gosu doesn't work with Ruby 2.0 on Windows yet.  Just do...

     gem install gosu

I presume it'll work on Ruby 2.0 as well if you're using OS X or Linux, but I haven't tested it.  Windows users can use the .exe as well, which can be used even if you don't have Ruby and Gosu installed.

## Known Issues
I don't do resource loading like I should, so it might not work for you due to working directory nonsense.  Sorry.  I'll fix that at some point.  If you use the included .exe on Windows it'll probably work fine.

## What are the controls?
They're not really worth documenting yet, since there's no game to speak of.  You can move with the arrows and fire shots with spacebar.  There are no other keys right now.
