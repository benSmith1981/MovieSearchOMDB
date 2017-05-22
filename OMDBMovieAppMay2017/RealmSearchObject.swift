//
//  RealmSearchObject.swift
//  UItableJSONSerialisation
//
//  Created by Ben Smith on 03/02/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import Foundation

import RealmSwift

class RealmSearchObject: Object {
    dynamic var title : String?
    dynamic var year : String?
    dynamic var imdbID : String?
    dynamic var type : String?
    dynamic var poster : String?

}

extension RealmSearchObject {
    func realmModelFromSearchObject(searchObject:Search)
    {
        title = searchObject.title
        year = searchObject.year
        imdbID = searchObject.imdbID
        type = searchObject.type
        poster = searchObject.poster
    }
}
