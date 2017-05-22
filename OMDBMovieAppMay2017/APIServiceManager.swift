//
//  APIServiceManager.swift
//  OMDBMovies
//
//  Created by Ben Smith on 07/05/16.
//  Copyright © 2016 Ben Smith. All rights reserved.
//

import Foundation
import SystemConfiguration


class APIServiceManager {
    static let sharedInstance = APIServiceManager()
      
    private init() {}
    
    /**
     Calls the manager to make a standard http request using the httpHeader json type, this requires the users password that is stored in the keychain:
     ["Content-Type": "application/json", "Accept-Language": language]
     
     - parameter body: BodyDataDictionary?, the body of the req uest required by some calls, can be nil
     - parameter path: String, the path to the API service call
     - parameter httpMethod: httpMethods, the httpmethod enum (post, get , put, delete)
     - parameter onCompletion:APIServiceResponse The response from the API service, giving success or fail, dictionary response and any error
     */
    func callRequestWithAPIServiceResponse(body: BodyDataDictionary?, path: NSURL, httpMethod: httpMethods, onCompletion:@escaping APIServiceResponse){
        
        //incase the server can return different languages send it the language
        let langId = Locale.current.languageCode
        let countryId = Locale.current.regionCode
        let language = "\(String(describing: langId))-\(String(describing: countryId))"
        
        let httpHeader = ["Content-Type": "application/json", "Accept-Language": language]
        Manager.sharedInstance.makeRequest(path: path, body: nil, httpMethod: httpMethod, httpHeader: httpHeader, onCompletion: onCompletion)
    }

    /**
     Setups up the messages from the server so the UI knows what is going wrong or right
     
     - parameter json:BodyDataDictionary?, the body of the messages from server, if there is an error then there is a message or code key in response
     - parameter error: NSError?, the http response code we need to check (200-204 success, other is fail
     - return requestResult A struct used for error requests containing our codes and messages of the error
     */
    func setServerCodeMessage(json:BodyDataDictionary?, error: NSError?) -> requestResult{
        //If there is a json response and we have the key Error then we know there is and
        if let jsonUnwrapped = json,
            let message = jsonUnwrapped[serverResponseKeys.Error.description] as? String{
                return requestResult.init(success: false, errorMessage: message, errorCode: responseCodes.omdbErrorCode.rawValue, domain: .ombdErrorDomain)
                
        } else if let error = error {
            //for any error between 500 to 599 return server problem, else return network error
            if case responseCodes.serverProblem500.rawValue ... responseCodes.serverProblem599.rawValue = error.code {
                return requestResult.init(success: false, errorMessage: responseMessages.serverProblem.description, errorCode: error.code, domain: .networkErrorDomain)
            } else {
                //if there is possibly any other just return the systems error
                return requestResult.init(success: false, errorMessage: responseMessages.networkConnectionProblem.description, errorCode: error.code, domain: .networkErrorDomain)
            }
        }
        //success so return that with a success domain
        return requestResult.init(success: true, errorMessage: responseMessages.success.description, errorCode: responseCodes.ok200.rawValue, domain: .successDomain)
    }
    
    /** Converts the error string from the code
     parameter error: NSError? error found
     return String the converted error string from the code
     */
    func getErrorCodeDescription(error: NSError?) -> String {
        if let error = error {
            if error.code == responseCodes.omdbErrorCode.rawValue {
                return responseMessages.ombdError.description
            } else {
                return responseMessages.networkConnectionProblem.description
            }
        }
        return "No Error Code"
    }
 }
