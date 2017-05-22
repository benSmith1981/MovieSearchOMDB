//
//  OMDBConstants.swift
//  OMDBMovies
//
//  Created by Ben Smith on 07/05/16.
//  Copyright © 2016 Ben Smith. All rights reserved.
//

import Foundation

typealias errorMessage = String?
typealias errorCode = String?
typealias totalResults = Int

/**
 The basic structure of a JSON response or a body required in a request
 */
public typealias BodyDataDictionary = [String: AnyObject]

/** This is the response from the API Service giving raw JSON and any error, this is the middle layer response that any implementation of OMDBs API has to unwrap the error and store the data nicely to return in an object
 */
typealias APIServiceResponse = (Bool, BodyDataDictionary?, NSError?) -> Void

/** This is the response body passing back data to the UI, before we do this we have already got the result or the results of the search and give it back in a nice object, also if there are any errors then these have been unwrapped in a user friendly way, we also give back the total pages so we can load more results
 */
typealias APIMovieResponse = (Bool, errorMessage, errorCode, DetailObject?, [Search]?, totalResults?) -> Void

struct OMDBConstants {

    //the timeout for the request
    static let timeout: TimeInterval = 20
    
    //Max  many pages or results the server can show in one response
    static let pagesPerRequest = 10
    
    //search delay time
    static let SEARCH_DELAY_IN_MS: UInt64 = 500
}
