//
//  NewsDetailsPresenterTests.swift
//  TopNewsTests
//
//  Created by Sujata Chakraborty on 12/10/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

import XCTest
@testable import TopNews


class NewsDetailsPresenterTests: XCTestCase {
    
    // MARK: - Subject under test
    var presenterUnderTest : NewsDetailsPresenter!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupNewsPresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupNewsPresenter()
    {
        presenterUnderTest = NewsDetailsPresenter()
    }
    
    // MARK: - Test doubles
    
    class NewsDetailsDisplayLogicSpy: NewsDetailsDisplayLogic
    {
        
        // MARK: Method call expectations
        
        var displayFetchedNewsCalled = false
        var displayErrorCalled = false
        var viewModel: NewsDetails.FetchNewsDetails.ViewModel!
        
        
        func displayNewsDetails(viewModel: NewsDetails.FetchNewsDetails.ViewModel) {
            
            self.viewModel = viewModel
            displayFetchedNewsCalled = true
        }
        
        func displayError() {
            
            displayErrorCalled = true
        }
        
        
        func displayNewsList(viewModel: NewsList.FetchNews.ViewModel) {
            
            displayFetchedNewsCalled = true
        }
        
    }
    
    // MARK: - Tests
    
    func testPresentFetchedNewsListShouldFormatFetchedNewsForDisplay()
    {
        // Given
        let newsDetailsDisplayLogicSpy = NewsDetailsDisplayLogicSpy()
        presenterUnderTest.viewController = newsDetailsDisplayLogicSpy
        
        let firstNews = Seeds.TopNews.firstNews
        
        
        let response = NewsDetails.FetchNewsDetails.Response.init(news: firstNews)
        presenterUnderTest.presentNewsDetails(response: response)
        
        // Then
        let displayedNewsList = newsDetailsDisplayLogicSpy.viewModel.newsDetails
        
        
        XCTAssertEqual(displayedNewsList.title, "News title1", "Presenting fetched news should properly format news title")
        XCTAssertEqual(displayedNewsList.url, "sampleurl", "Presenting fetched news should properly format news url")
        
    }
    
    func testPresentFetchedNewsShouldAskViewControllerToDisplayFetchedNews()
    {
        // Given
        let newsDetailsDisplayLogicSpy = NewsDetailsDisplayLogicSpy()
        presenterUnderTest.viewController = newsDetailsDisplayLogicSpy
        
        let firstNews = Seeds.TopNews.firstNews
        
        
        let response = NewsDetails.FetchNewsDetails.Response.init(news: firstNews)
        presenterUnderTest.presentNewsDetails(response: response)
        
        
        // Then
        XCTAssert(newsDetailsDisplayLogicSpy.displayFetchedNewsCalled, "Presenting fetched news should ask view controller to display it")
    }
    
    
    
}
