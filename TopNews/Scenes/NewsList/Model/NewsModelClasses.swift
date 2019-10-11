//
//  News.swift
//  TopNews
//
//  Created by Sujata Chakraborty on 11/10/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

import Foundation


class News : Decodable
{
    let source       : Source?
    let title        : String?
    let description  : String?
    let urlToImage   : String?
    let publishedAt  : String?
    let content      : String?
    let url          : String?
}

class Source : Decodable
{
    let name : String?
}

class Articles : Decodable
{
    let articles : [News]?
}
