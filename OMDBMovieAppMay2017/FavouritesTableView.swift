//
//  FavouritesTableView.swift
//  UItableJSONSerialisation
//
//  Created by Ben Smith on 02/02/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import RealmSwift

class FavouritesTableView: UITableViewController {

    var notificationToken: NotificationToken?
    var history: Results<RealmSearchObject> = RealmRequest.sharedInstance.getMovieHistory(){
        didSet{
            //everytime savedarticles is added to or deleted from table is refreshed
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.history = RealmRequest.sharedInstance.getMovieHistory()
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "MovieCell")
        
        self.notificationToken = self.history.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.history = RealmRequest.sharedInstance.getMovieHistory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return history.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = self.tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let searchSaved = history[indexPath.row]
        cell.favouriteButton.isHidden = true
        cell.setRealmDataForView(movieData: searchSaved)
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let currentItem = history[indexPath.row]
            RealmDeleteService.sharedInstance.deleteSpecificObject(currentItem)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

}
