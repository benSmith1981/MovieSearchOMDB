//
//  OMDBSearchController.swift
//  OMDBMovies
//
//  Created by Ben Smith on 12/05/16.
//  Copyright © 2016 Ben Smith. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Search Scheduler
extension OMBDListTableViewController: UISearchResultsUpdating{
    
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        //Filter content for search
        if searchController.isActive && (searchController.searchBar.text?.characters.count)! >= 2 && self.currentSearchText != searchController.searchBar.text {
            self.episodes = []
            let searchBar = searchController.searchBar
            self.scheduledSearch(searchBar: searchController.searchBar,page: self.currentPage, scope: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        }
    }

    
    func scheduledSearch(searchBar: UISearchBar, page: Int, scope: String = "") {
        let popTime = DispatchTime.init(uptimeNanoseconds: OMDBConstants.SEARCH_DELAY_IN_MS * NSEC_PER_MSEC)
        
        //the value of text is retained in the thread we spawn off main queue
        let text = searchBar.text ?? ""
        
        DispatchQueue.main.asyncAfter(deadline: popTime) { 
            if text == searchBar.text {
                let scope = self.determineScope(scopeTitle: searchBar.scopeButtonTitles![self.selectedScope])
                self.doSearch(searchString: text, page: self.currentPage, movieTypeScope: scope)
            }
        }
    }
}

// MARK: - Search Delegate

extension OMBDListTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.currentPage = 1 //when we start typing reset the current page to 1 as new results will be loaded
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.returnKeyType = UIReturnKeyType.done // because of the update search results automatically being fired keyboard must say done not search
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchController.isActive && (searchController.searchBar.text?.characters.count)! >= 2 && self.currentSearchText != searchController.searchBar.text {
            self.episodes = []
            let searchBar = searchController.searchBar
            let text = searchBar.text ?? ""
            if text == searchBar.text {
                let scope = self.determineScope(scopeTitle: searchBar.scopeButtonTitles![self.selectedScope])
                self.doSearch(searchString: text, page: self.currentPage, movieTypeScope: scope)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //Filter content for search
        self.selectedScope = selectedScope
        self.currentPage = 1
        self.episodes = [] //reset our search results
        if searchController.isActive && (searchController.searchBar.text?.characters.count)! >= 2 {
            let scope = determineScope(scopeTitle: searchBar.scopeButtonTitles![selectedScope])
            self.doSearch(searchString: (searchController.searchBar.text)!, page: self.currentPage, movieTypeScope: scope)
        }
    }
    
    /** Because of localizable strings the titles are differen to the parameters needed in the OMDB API, so we need to filter what title we have (in whatever language) and return the correct parameter
     - parameter scopeTitle: String Scope title from the search bar
     - return String The scope string title
     */
    func determineScope(scopeTitle: String) -> String {
        var scope: String
        switch scopeTitle {
        case movieTypesTitles.movie.description:
            scope = movieTypes.movie.description
        case movieTypesTitles.all.description:
            scope = movieTypes.all.description
        case movieTypesTitles.series.description:
            scope = movieTypes.series.description
        case movieTypesTitles.episode.description:
            scope = movieTypes.episode.description
        default:
            scope = movieTypes.all.description
        }
        return scope
    }
}

// MARK: - Search Function

extension OMBDListTableViewController {
    /**
     This is called by the search scheduler and calls the OMDB search functions to get a list of results
     - parameter searchString: String, The search string the title of the film in this case
     - parameter page: Int, the page number we want to get from the server, this is calculated from the total pages returned on the search
     - parameter movieTypeScope: String Movie, Episode, Series or All scope type to refine a search
     */
    func doSearch(searchString: String, page: Int, movieTypeScope: String = "") {
        //set current search text
        self.currentSearchText = searchString
        
        OMDBSearchService.sharedInstance.searchOMDBDatabaseByTitle(searchString: searchString, page: page, movieType: movieTypeScope) { (success, errorMessage, errorCodeString, movie, movies, totalPages) in
            
            self.totalPages = totalPages! //force unwrap as we know will be zero or another INT
            
            if success {
                if let movies = movies {
                    self.episodes += movies
                }
            }
        }
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.reloadData()
        
    }
}
