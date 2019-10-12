//
//  NewsDetailsInteractorTest.swift
//  TopNews
//
//  Created by Sujata Chakraborty on 12/10/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

import XCTest
@testable import TopNews

class NewsDetailsInteractorTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var interactorUnderTest: NewsDetailsInteractor!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupNewsListInteractor()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupNewsListInteractor()
    {
        interactorUnderTest = NewsDetailsInteractor()
    }
    
    // MARK: - Test doubles
    
    class NewsDetailsPresentationLogicSpy: NewsDetailsPresentationLogic
    {
        
        // MARK: Method call expectations
        
        var presentNewsListCalled = false
        
        func presentNewsDetails(response: NewsDetails.FetchNewsDetails.Response) {
            
            presentNewsListCalled = true
            
        }
        
    }
    
    
    
    // MARK: - Tests
    
    func testGetNewsDetailsShouldAskPresenterToFormatResult()
    {
        // Given
        let newsDetailsPresentationspy = NewsDetailsPresentationLogicSpy()
        interactorUnderTest.presenter = newsDetailsPresentationspy
        interactorUnderTest.news = Seeds.TopNews.firstNews
        
        // When
        let request = NewsDetails.FetchNewsDetails.Request()
        interactorUnderTest.fetchNewsDetails(request: request)
        
        // Then
        XCTAssert(newsDetailsPresentationspy.presentNewsListCalled, "fetchNewsDetails() should ask presenter to format the news details")
    }
    
    
    
    
}
