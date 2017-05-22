//
//  RealmWrite.swift
//  OMDB
//
//  Created by Ben Smith on 10/05/16.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWrite {
    
    static let sharedInstance = RealmWrite()
    
    private var overTotalHistory : Bool = false
    
    private init() {}
    
    
    
    private func checkIfAlreadyExist() {
    
    }
    
    private func checkIfExtends(_ i: Int, max:Int) -> Bool {
        
        if i < max {
            overTotalHistory = true
        }
        return overTotalHistory
    }
    
    
    
    /// Writes the movie to coredata, for visual table when opening app
    ///
    /// - Parameters:
    ///   - title: The main movie/serie title
    ///   - imdbID: imdb id for checking
    ///   - poster: the poster url for getting the
    public func writeSearchHistory(searchObjectToStore: Search) {
        
        let realmSearchObject = RealmSearchObject()
        
        realmSearchObject.realmModelFromSearchObject(searchObject: searchObjectToStore)
        do {
            let realm = try Realm(),
                total = realm.objects(RealmSearchObject.self).count
            if checkIfExtends(total, max: 20) {
                try realm.write {
                    realm.add(realmSearchObject)
                }
                print("total in history : \(total)")

            } else {
                print("exceeded max -> Deleted first of array, it has a total of : \(total)")
            }
        } catch {
            print("Realm read write error")
        }


    }
}
