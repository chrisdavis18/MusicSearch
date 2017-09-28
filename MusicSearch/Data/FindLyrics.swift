//
//  FindLyrics.swift
//  MusicSearch
//
//  Created by Chris Davis on 9/26/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation

class FindLyrics {
    
    // API Call to Query For Lyrics To see If Available
    func getLyricsURL(_ artist: String, song: String, completion: @escaping (_ success: Bool, _ lyricsURL: String?) -> Void) {
        
        var requestString = Constants.lyricsSearch + artist + "&song=" + song + "&fmt=json"
        // Generally this gets encoded to a %20, unless www/x-form-encoded
        // So ideally I would have created a form-encode extension to this work to
        // clean things up a little bit
        requestString = requestString.replacingOccurrences(of: " ", with: "+")
        
        // Create Request -> Make sure no failures on URL
        let url = URL(string: requestString)
        
        // Mark Sure URL Was Created
        if(url != nil) {
            
            let request = URLRequest(url: url!)
            // Perform Request
            URLSession.shared.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
                
                // Check for Data
                guard let data = data else {
                    completion(false, nil)
                    return
                }
                
                // Convert to String in Order to Start Forming this to JSON
                guard let dataString = String(data: data, encoding: .utf8) else {
                    completion(false, nil)
                    return
                }
                
                // Replace ' with " in order to work on achieving valid JSON
                let jsonString = dataString.replacingOccurrences(of: "\'", with: "\"")
                
                // Remove Beginning Portion in order to get valid JSON
                let newString = jsonString.replacingOccurrences(of: "song = ", with: "")
                
                // Convert String Back to Data and Serialize Object
                let newData = newString.data(using: .utf8)
                var dict = NSDictionary()
                do {
                    dict = try JSONSerialization.jsonObject(with: newData!, options: []) as! NSDictionary
                } catch let error as NSError {
                    
                    print("Error Serializing: \(error.localizedDescription)")
                    completion(false, nil)
                    
                }
                
                
                // Get Lyrics Key -> Since There Is No Error Handling with this API
                // Compare Lyrics to "Not found" -> If It Matches Error, Else Pass the Link
                guard let lyrics = dict.object(forKey: "lyrics") as? String else {
                    
                    print("Error Getting Lyrics Key")
                    completion(false, nil)
                    return
                }
                
                // Lyrics Aren't Found
                if(lyrics == "Not found") {
                    
                    print("Lyrics Not Found")
                    completion(false, nil)
                    
                } else { // Lyrics Are Found
                    
                    print("Lyrics Found!")
                    completion(true, dict.object(forKey: "url") as? String)
                    
                }
                
                
            }).resume()
            
        } else {
            // Error Creating URL
            completion(false, nil)
            
        }
        
    }
    
    
        
    
}
