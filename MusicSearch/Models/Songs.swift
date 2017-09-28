//
//  Songs.swift
//  MusicSearch
//
//  Created by Personal on 9/26/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation


struct Song {
    
    // TODO:  Add More Info For Streaming, Etc.
    let trackName: String
    let artistName: String
    let albumName: String
    let albumImage: String
    
    
}

extension Song {
    
    init?(json: [String: Any]) {
        guard let trackName = json["trackName"] as? String,
        let artistName = json["artistName"] as? String,
        let albumName = json["collectionName"] as? String,
        let albumImage = json["artworkUrl60"] as? String else {
            return nil
        }
        self.trackName = trackName
        self.artistName = artistName
        self.albumName = albumName
        self.albumImage = albumImage
    }
}

// JSON Object for Init

//{
//    "wrapperType": "track",
//    "kind": "song",
//    "artistId": 42616562,
//    "collectionId": 724835747,
//    "trackId": 724836473,
//    "artistName": "Nat King Cole",
//    "collectionName": "Unforgettable",
//    "trackName": "Unforgettable",
//    "collectionCensoredName": "Unforgettable",
//    "trackCensoredName": "Unforgettable",
//    "artistViewUrl": "https://itunes.apple.com/us/artist/nat-king-cole/id42616562?uo=4",
//    "collectionViewUrl": "https://itunes.apple.com/us/album/unforgettable/id724835747?i=724836473&uo=4",
//    "trackViewUrl": "https://itunes.apple.com/us/album/unforgettable/id724835747?i=724836473&uo=4",
//    "previewUrl": "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview71/v4/c3/18/dc/c318dcaf-2651-58db-93c4-ae0b35d07e3d/mzaf_1063315490498596897.plus.aac.p.m4a",
//    "artworkUrl30": "http://is5.mzstatic.com/image/thumb/Music4/v4/2d/37/a9/2d37a98c-c49e-c94a-966b-93d47386baf1/source/30x30bb.jpg",
//    "artworkUrl60": "http://is5.mzstatic.com/image/thumb/Music4/v4/2d/37/a9/2d37a98c-c49e-c94a-966b-93d47386baf1/source/60x60bb.jpg",
//    "artworkUrl100": "http://is5.mzstatic.com/image/thumb/Music4/v4/2d/37/a9/2d37a98c-c49e-c94a-966b-93d47386baf1/source/100x100bb.jpg",
//    "collectionPrice": 12.99,
//    "trackPrice": 1.29,
//    "releaseDate": "1951-10-01T08:00:00Z",
//    "collectionExplicitness": "notExplicit",
//    "trackExplicitness": "notExplicit",
//    "discCount": 1,
//    "discNumber": 1,
//    "trackCount": 25,
//    "trackNumber": 5,
//    "trackTimeMillis": 191933,
//    "country": "USA",
//    "currency": "USD",
//    "primaryGenreName": "Pop",
//    "isStreamable": true
//}

