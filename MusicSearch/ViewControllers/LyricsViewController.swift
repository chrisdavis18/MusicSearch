//
//  LyricsViewController.swift
//  MusicSearch
//
//  Created by Personal on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit
import WebKit

class LyricsViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var songContentView: UIView!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!

    // MARK: - Variables
    var song: Song!
    var lyricsPath: String!
    

    // MARK: - View Controller Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set Navigation Title
        self.navigationController?.navigationItem.title = "Lyrics"
        
        // WebView Scroll Delegate - For Scroll Detection
        self.webView.scrollView.delegate = self
        
        // Set View Properties
        songNameLabel.text = song.trackName
        artistNameLabel.text = song.artistName
        albumNameLabel.text = song.albumName
        songImageView.loadImageUsingCache(withUrl: song.albumImage)
        
      
        // Create URL for Webview
        let request = URLRequest(url: URL(string: lyricsPath)!)
        webView.load(request)
        
    }

    
    // MARK: - ScrollView Delegates for Showing/Hiding View
    // Hide View
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Show Content View
        DispatchQueue.main.async {
            self.songContentView.isHidden = false
        }
        
    }
    
    
    // Show View
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Hide Content View
        DispatchQueue.main.async {
                self.songContentView.isHidden = true
        }
    }
    
    
}
