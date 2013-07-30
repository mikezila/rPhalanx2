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

I presume it'll work on Ruby 2.0 as well if you're using OS X or Linux, but I haven't tested it.

## Known Issues
I don't do resource loading like I should, so it might not work for you due to working directory nonsense.  Sorry.  I'll fix that at some point.

## What are the controls?
They're not really worth documenting yet, since there's no game to speak of.  You can move with the arrows and fire shots with spacebar.  Press B to cycle through the three levels of movement boost.  There are no other keys right now.  You can destroy the enemies, but no more will spawn, and your health just keeps going negative instead of you blowing up.  Like I said, not really a game yet.

## What's so special about this?
Nothing really.  I am somewhat proud of the tagging system I'm using, even if it is very simple.  Every game object has a list of plain text tags.  Things like "shot", "enemy_ship", or "asparagus".  Since all gameobjects are stored in the same array (with singlular exception of the player's own bullets) you can iterate over the array and send method calls to just the objects you want by checking for the tags you want.  The performance of this is surprisingly decent, so long as the number of objects checking for tags each frame is under a hundred or so, and the total number of objects is under about a thousand.  Even the most hell-ish bullet hell wouldn't have that many enemies on screen at a time, so I'd say it's fine for smaller games.

I got the inspriation from Unity3D, which uses a similar tagging system.  This isn't anything super-clever, but I wanted to see if it would work well in Ruby game.  So long as you are smart with it and don't go overboard it seems to work well.
