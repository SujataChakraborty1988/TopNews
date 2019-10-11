//
//  NewsDetailsInteractor.swift
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

protocol NewsDetailsBusinessLogic
{
  func fetchNewsDetails(request: NewsDetails.FetchNewsDetails.Request)
}

protocol NewsDetailsDataStore
{
    var news : News! { get set }

}

class NewsDetailsInteractor: NewsDetailsBusinessLogic, NewsDetailsDataStore
{
    var presenter: NewsDetailsPresentationLogic?
    var worker: NewsDetailsWorker?
    var news : News!
  
    // MARK: Collect required new details data and share to Presenter
    
    func fetchNewsDetails(request: NewsDetails.FetchNewsDetails.Request)
    {
        
        let response = NewsDetails.FetchNewsDetails.Response.init(news: news)
        presenter?.presentNewsDetails(response: response)
    }
}
