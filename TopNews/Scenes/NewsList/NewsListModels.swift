//
//  NewsListModels.swift
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

enum NewsList
{
  // MARK: Use cases
  
  enum FetchNews
  {
    struct Request
    {
        var pageSize = Constants.kDefaultPageSize
        var pageNumber = 0

    }
    struct Response
    {
        var news: [News]

    }
    struct ViewModel
    {
        
        struct DisplayNews
        {
            var title          : String
            var imageURL       : String
            var content        : String
            var description    : String
            var time           : String
            var source         : String

        }
        var NewsDetails        : [DisplayNews]
    }
  }
}