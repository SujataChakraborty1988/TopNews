
@testable import TopNews
import XCTest

struct Seeds
{
    struct TopNews
    {
        static let source = Source.init(name: "Source1")
        
        static let firstNews = News.init(source: source, title: "News title1", description: "News description", urlToImage: "urlImage", publishedAt: "2019-10-12T06:12:00Z", content: "content", url: "sampleurl")
        
        static let secondNews = News.init(source: source, title: "News title2", description: "News description2", urlToImage: "urlImage2", publishedAt: "2019-10-12T06:12:00Z", content: "content", url: "sampleurl")

        static let firstArticle = Articles.init(articles: [firstNews ,secondNews ])
    }
    
    
    
    struct StringTest
    {
        static let stringWithSpaces = "   stringwithBlankAtStartAndBack   "
        static let stringWithOutSpaces = "stringwithBlankAtStartAndBack"
        
    }

}
