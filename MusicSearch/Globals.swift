//
//  Globals.swift
//  MusicSearch
//
//  Created by Personal on 9/26/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation


enum Constants {
    
    static let songSearch = "https://itunes.apple.com/search?term="
    static let lyricsSearch = "http://lyrics.wikia.com/api.php?func=getSong&artist="
    static let lyricsView = "http://lyrics.wikia.com/"
    static let songTableViewCell = "songTableViewCell"
    static let lyricsViewController = "lyricsView"
    
    // Blue - #004da4
}

class Globals {
    
    // Singleton Setup
    static let sharedInstance = Globals()
    
    // Image Cache for Album Artwork
    let imageCache = NSCache<NSString, AnyObject>()

}
