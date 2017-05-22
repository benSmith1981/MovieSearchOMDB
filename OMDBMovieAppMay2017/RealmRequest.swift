//
//  RealmRequest.swift
//  OMDB
//
//  Created by Ivo  Nederlof on 02-02-17.
//  Copyright © 2017 Dutch Melon. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRequest {
    
    static let sharedInstance = RealmRequest()
    private init() {}
    
    func getMovieHistory() -> Results<RealmSearchObject> {
        //don't know how to fix this forced try
        let realm = try! Realm()
        return realm.objects(RealmSearchObject.self)
    }
}
