//
//  Extensions.swift
//  MusicSearch
//
//  Created by Personal on 9/26/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        
        // check cached image
        if let cachedImage = Globals.sharedInstance.imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                self.image = #imageLiteral(resourceName: "notAvailable")
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    Globals.sharedInstance.imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}

extension String {
    
    func convertForLyricView() -> String {
        
        var string = self
        
        string = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        string = string.replacingOccurrences(of: "%20", with: "_")
        string = string.replacingOccurrences(of: "!", with: "%21")
        string = string.replacingOccurrences(of: " ", with: "_")
    
        return string
        
    }
    
}
