//
//  SearchViewController.swift
//  MusicSearch
//
//  Created by Chris Davis on 9/26/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SongSearchProtocol {
    
    // MARK: - Variables
    var songs = [Song]()
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Actions
    
    // MARK: - Protocol Implmentations
    func searchResults(_ songs: [Song]?, error: Bool) {
        
        // Check for Error
        if(error) {
            
            let errorAlert = UIAlertController(title: "Error", message: "Something went wrong when searching for songs", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Got It!", style: .default, handler: nil)
            errorAlert.addAction(okAction)
            
            DispatchQueue.main.async {
                self.present(errorAlert, animated: true, completion: nil)
            }
            
        } else {
            
            self.songs = songs!
            // Update UI on Main Thread
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
            
        }
        
    }

    // MARK: - View Controller Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("MEMORY WARNING")
    }

    
    
    // MARK: - TableView Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.songTableViewCell, for: indexPath) as! SongTableViewCell
        
        // Set Cell Information
        cell.artistNameLabel.text = songs[indexPath.row].artistName
        cell.songNameLabel.text = songs[indexPath.row].trackName
        cell.albumNameLabel.text = songs[indexPath.row].albumName
        
        // Image
        let imagePath = songs[indexPath.row].albumImage
        cell.ablumImageView.loadImageUsingCache(withUrl: imagePath)
        
        return cell
        
    }
    

    
    // Table Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
    // Selected Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        // Push View Controller

        
        
        // Make API in Closure Block Since the Web View Will Be Presented
        // Because API Lyrics are Abbreviated
        
        let artist = songs[indexPath.row].artistName
        let song = songs[indexPath.row].trackName
        
        let lyrics = FindLyrics()
        lyrics.getLyricsURL(artist, song: song, completion: { success, link in

            // Successful Login
            if(success) {
                
                if(link != nil) {
                    
                    // Init View Controller and Values
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "lyricsView") as! LyricsViewController
                    vc.song = self.songs[indexPath.row]
                    vc.lyricsPath = link!
                    
                    // Push New View Controller
                    DispatchQueue.main.async {
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                    
                } else {
                    
                    // Show Error, No Lyrics Found
                    let errorAlert = UIAlertController(title: "Error", message: "We couldn't find the lyrics for the song you were requesting", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok!", style: .default, handler: nil)
                    errorAlert.addAction(okAction)
                    DispatchQueue.main.async {
                        self.present(errorAlert, animated: true, completion: nil)
                    }
                    
                    
                }
                
                


            } else {

                // Show Error, No Lyrics Found
                let errorAlert = UIAlertController(title: "Error", message: "We couldn't find the lyrics for the song you were requesting", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok!", style: .default, handler: nil)
                errorAlert.addAction(okAction)
                DispatchQueue.main.async {
                    self.present(errorAlert, animated: true, completion: nil)
                }

            }

        })

        
        
        
        
        
    }
    
    // MARK: - SearchBar Delegate
    // Perform Update to List if Text Changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // If searchText is empty, leave previous results
        // else update Results based on searchText
        if(searchText != ""){
            
            let search = SongSearch()
            search.delegate = self
            search.songsContaining(search: searchText)
            
        }
        
    }
    
    // Show Cancel Button
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    // Cancel Button Shows when searchBar is editing
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    // Search Button is switched to done button, since updates
    // Are done as text changes, done button will dismiss keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    // Resign First Repsonse
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }


}

