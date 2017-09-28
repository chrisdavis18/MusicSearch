#  Music Search
## Comments
### The public API for retrieving song lyrics in http, which could cause some issues moving forward because of Apple's Security Standards
### The public API doesn't return valid JSON, even though that's the format specified, so I have a little hack in the FindLyrics class to handle this
### With more time, I would have loved th tap into MusicKit, maybe allow the user to open the song with the Music app or stream a preview
### Testing is a little skimpy, I'm somewhat new to it, and struggled to understand how to handle api calls from actions (typing in the searchBar)
### Also, the images displayed in the cells show be loaded in lazily, because of time constraints I'm only caching them to help speed things up

