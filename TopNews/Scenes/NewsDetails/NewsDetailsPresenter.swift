//
//  NewsDetailsPresenter.swift
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

protocol NewsDetailsPresentationLogic
{
  func presentNewsDetails(response: NewsDetails.FetchNewsDetails.Response)
}

class NewsDetailsPresenter: NewsDetailsPresentationLogic
{
  weak var viewController: NewsDetailsDisplayLogic?
  
  // MARK: Do something
  
    func presentNewsDetails(response: NewsDetails.FetchNewsDetails.Response)
    {
        
        if let url =  response.news.url
        {
            let title = response.news.title ?? ""
            
            let displayedNews = NewsDetails.FetchNewsDetails.ViewModel.DisplayNews.init(title: title, url: url)
            
            
            let viewModel = NewsDetails.FetchNewsDetails.ViewModel.init(newsDetails: displayedNews)
            viewController?.displayNewsDetails(viewModel: viewModel)
        }
        else
        {
            viewController?.displayError()
        }
    }
}
