//
//  SongSearch.swift
//  MusicSearch
//
//  Created by Chris Davis on 9/26/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation

protocol SongSearchProtocol: class {
    func searchResults(_ songs: [Song]?, error: Bool)
}

class SongSearch: NSObject, URLSessionDelegate {
    
    // Delegate to Update Search Results
    weak var delegate: SongSearchProtocol?
    
    // API Function to Return Songs Containing Search Text
    func songsContaining(search: String) {
        
        // Create Request String
        var requestString = Constants.songSearch + search
        requestString = requestString.replacingOccurrences(of: " ", with: "+")
        let request = URLRequest(url: URL(string: requestString)!)

        URLSession.shared.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            // Check for Error
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("Error in Song Search \(error!.localizedDescription))")
                self.delegate?.searchResults(nil, error: true)
                return
            }
            
        
            // Cast to Dictionary from JSON Response
            var dict: NSDictionary = NSDictionary()
            do {
                dict = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                
            } catch let error as NSError {
                
                print("Error Serializing: \(error.localizedDescription)")
                self.delegate?.searchResults(nil, error: true)
                
            }
            
            
            // Fetch Results Array
            guard let results = dict.object(forKey: "results") as? NSArray else {
                self.delegate?.searchResults(nil, error: true)
                return
            }
            
            // Create Array of Songs to Passed via Delegate
            var songs = [Song]()
            for i in 0..<results.count {
//                print(results[i])
                let song = Song.init(json: results[i] as! [String: Any])
                // Mark sure songs has valid info
                if(song != nil){
                    songs.append(song!)
                }
            }
            // Pass Back Songs
            self.delegate?.searchResults(songs, error: false)
            
            
        }).resume()
        
        
    }
    
}
