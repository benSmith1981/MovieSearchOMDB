//
//  Manager.swift
//  OMDBMovies
//
//  Created by Ben Smith on 07/05/16.
//  Copyright © 2016 Ben Smith. All rights reserved.
//

import Foundation

class Manager: NSObject {

    static let sharedInstance = Manager()
    var userInfo: BodyDataDictionary = [:]

    private override init() {
        print("Only initialised once only")
    }
    /**
     Helper method to create an NSURLRequest with it's required httpHeader, httpBody and the httpMethod request and return it to be executed, it has a timeout so that any network requests taking to long throw an error, also we replace illegal characters with escape characters so that the request can convert the path to a URL
     
     - parameter path: String,
     - parameter body: BodyDataDictionary?,
     - parameter httpHeader: [String:String],
     - parameter httpMethod: httpMethods
     - return NSURLRequest, the request created to be executed by makeRequest
     */
    func setupRequest(path: NSURL, body: BodyDataDictionary?, httpHeader: [String:String], httpMethod: httpMethods) throws -> NSURLRequest {
        
        //remove illegal characters in url
        //specific to swift 3
//        let escapedAddress = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let request = NSMutableURLRequest(url: path as URL)

        request.allHTTPHeaderFields = httpHeader //["Content-Type": "application/json", "Yona-Password": password]
        
        if let body = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions(rawValue: 0))
        }
        
        request.httpMethod = httpMethod.description
        request.timeoutInterval = OMDBConstants.timeout
        
        return request
    }
    
}

//MARK: - User Manager methods
extension Manager {
    
    /**
     This is a generic method that can make any request to OMBD API. It creates a request with the given parameters and an NSURLSession, then executes the session and gets the responses passing it back as an NSError 
     
     - parameter path: String, The required path to the API service that the user wants to access
     - parameter body: BodyDataDictionary?, The data dictionary of [String: AnyObject] type
     - parameter httpMethod: httpMethods, the http methods that you can do on the API stored in the enum
     - parameter httpHeader:[String:String], the header set to a JSON type
     - parameter onCompletion:APIServiceResponse The response from the API service, giving success or fail, dictionary response and any error
     */
    func makeRequest(path: NSURL, body: BodyDataDictionary?, httpMethod: httpMethods, httpHeader:[String:String], onCompletion: @escaping APIServiceResponse)
    {
        do{
            let request = try setupRequest(path: path, body: body, httpHeader: httpHeader, httpMethod: httpMethod)
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                if error != nil{ //network error issue
                    //return the block on the main thread so that any UI is displayed on this thread
                    DispatchQueue.main.async() {
                        onCompletion(false, nil, error as NSError?)
                        return
                    }
                }
                if response != nil {
                    if data != nil {
                        do{
                            let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                            let requestResult = APIServiceManager.sharedInstance.setServerCodeMessage(json: jsonData  as? BodyDataDictionary, error: error as NSError?)
                            if requestResult.success == false{
                                //This passes back the errors we retrieve, looks in the different optionals which may or may not be nil
                                let userInfo = [
                                    NSLocalizedDescriptionKey: requestResult.errorMessage ??  "Unknown Error"
                                ]
                            
                                //Create our own OMDB error, set the domain to the code to either the system error code or the ombderror code (600), also make sure the userInfo dictionary is set to the error message returned (either Ombd error, or if that doesn't exist the system error
                                let omdbError = NSError(domain: requestResult.domain, code: requestResult.errorCode, userInfo: userInfo)
                                //return the block on the main thread so that any UI is displayed on this thread
                                DispatchQueue.main.async() {
                                    onCompletion(requestResult.success, jsonData as? BodyDataDictionary, omdbError)
                                }
                            } else {
                                //return the block on the main thread so that any UI is displayed on this thread
                                DispatchQueue.main.async() {
                                    onCompletion(requestResult.success, jsonData as? BodyDataDictionary, nil)
                                }
                            }
                        } catch let error as NSError{ //issue with json serialisation
                            //return the block on the main thread so that any UI is displayed on this thread
                            DispatchQueue.main.async() {
                                onCompletion(false, nil, error)
                                return
                            }
                        }
                        
                    }
                }
            })
            task.resume()
        } catch let error as NSError{ //issue with the request setup
            //return the block on the main thread so that any UI is displayed on this thread
            DispatchQueue.main.async() {
                onCompletion(false, nil, error)
            }
            
        }
    }
}
