//
//  NewsListWorker.swift
//  TopNews
//
//  Created by Sujata Chakraborty on 11/10/2019.
//  Copyright (c) 2019 Sujata Chakraborty. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class NewsListWorker
{
    
    var dataTask: URLSessionDataTask?
    
    
    func fetchNewsList(url: String, pageSize : Int, pageNumber : Int , completionHandler: @escaping (_: Articles?, _: RBError?) -> Void)
    {
        
        guard NetworkManager.sharedInstance.isInternetAccessible == true else {
            
            let nError = RBError.init(RBErrorCode: RBErrorCode.NetworkError)
            nError.rbErrorDebugInfo = "Network absent while fetching news"
            completionHandler(nil , nError)
            
            return
        }
        
        
        if let url = CreateURLToFetchNews(pageNumber: pageNumber, pageSize: pageSize)
        {
            
            dataTask =
                BaseWorkerClass.sessionManager.dataTask(with: url) { [weak self] data, response, error in
                    defer {
                        self?.dataTask = nil
                    }
                    if let error = error {
                        //need to handle error
                        
                        let rbError = RBError.init(RBErrorCode: RBErrorCode.ServerError)
                        rbError.rbErrorDebugInfo = error.localizedDescription + "problem for News list for page index \(pageNumber)"
                        completionHandler(nil , rbError)
                        
                    } else if
                        let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == Constants.kServerSuccessResponseCode {
                        
                        DispatchQueue.main.async {
                            do
                            {
                                let decoder = JSONDecoder()
                                let newsList = try decoder.decode(Articles.self, from: data)
                                
                                completionHandler(newsList , nil)
                                
                            }
                            catch let jsonErr {
                                
                                let rbError = RBError.init(RBErrorCode: RBErrorCode.UnableToParseErrorJson)
                                rbError.rbErrorDebugInfo = jsonErr.localizedDescription + "problem for News list for page index \(pageNumber)"
                                completionHandler(nil , rbError)
                            }
                        }
                    }
                    else
                    {
                        let rbError = RBError.init(RBErrorCode: RBErrorCode.ServerError)
                        rbError.rbErrorDebugInfo = "Data issue News list for page index \(pageNumber)"
                        completionHandler(nil , rbError)
                    }
            }
            dataTask?.resume()
        }
        else
        {
            let rbError = RBError.init(RBErrorCode: RBErrorCode.GeneralError)
            rbError.rbErrorDebugInfo = "problem with URL while fetching request for News list for page index \(pageNumber)"
            completionHandler(nil , rbError)
        }
        
    }
    
    
    func CreateURLToFetchNews(pageNumber : Int ,pageSize : Int )  -> URL?
    {
        let concatenatedURL = ServerConstants.kNewsURL
        
        var orderQuery = "country=" + ServerConstants.kCountry + "&apiKey=" + ServerConstants.kAPIKey
        orderQuery =  orderQuery +  "&" + "pageSize=" + String(pageSize) +  "&" + "page=" + String(pageNumber)
        
        
        if var urlComponents = URLComponents(string: concatenatedURL) {
            urlComponents.query =  orderQuery
            
            return urlComponents.url
        }
        
        return nil
    }
}
