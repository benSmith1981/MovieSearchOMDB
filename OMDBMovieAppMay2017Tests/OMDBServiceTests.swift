//
//  OMDBServiceTests.swift
//  UItableJSONSerialisation
//
//  Created by Ben Smith on 29/01/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import XCTest
@testable import UItableJSONSerialisation

class OMDBServiceTests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testsearchMovieGenericFailsByPassingABadPath() {
        let path = "wwsfdsf3£££"
//        OMDBSearchService.sharedInstance.searchMovieGeneric(path: path) { (
//                                                                            success,
//                                                                            message,
//                                                                            code,
//                                                                            result,
//                                                                            resultArray,
//                                                                            totalResults) in
//            XCTAssertFalse(success, message!)
        
    }
    
    func testSearchOMDBByTitle() {
        //
//        OMDBSearchService.sharedInstance.searchOMDBDatabaseByTitle(searchString: "Game of Thrones",
//                                                                   page: 1,
//                                                                   movieType: movieTypes.series.description) {
//            (success, errorMessage, errorCodeString, movie, movies, totalPages) in
//            XCTAssert(success)
//        }
    }
    
}
