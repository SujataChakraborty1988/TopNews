//
//  NewsListPresenterTests.swift
//  TopNewsTests
//
//  Created by Sujata Chakraborty on 12/10/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

import XCTest
@testable import TopNews


class NewsListPresenterTests: XCTestCase {
   
    // MARK: - Subject under test
    var presenterUnderTest : NewsListPresenter!
    
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
        presenterUnderTest = NewsListPresenter()
    }
    
    // MARK: - Test doubles
    
    class NewsListDisplayLogicSpy: NewsListDisplayLogic
    {
        
        // MARK: Method call expectations
        
        var displayFetchedNewsCalled = false
        var errorCallBackWhileFetchingNewsList = false
        
        // MARK: Argument expectations
        
        var viewModel: NewsList.FetchNews.ViewModel!
        
        
        func displayNewsList(viewModel: NewsList.FetchNews.ViewModel) {
            
            self.viewModel = viewModel
            displayFetchedNewsCalled = true
        }
        
        func receivedError(error: RBError) {
           
            errorCallBackWhileFetchingNewsList = true
        }
        
        
    }
    
    // MARK: - Tests
    
    func testPresentFetchedNewsListShouldFormatFetchedNewsForDisplay()
    {
        // Given
        let newsListDisplayLogicSpy = NewsListDisplayLogicSpy()
        presenterUnderTest.viewController = newsListDisplayLogicSpy
        
        let firstNews = Seeds.TopNews.firstNews
        
        
        let response = NewsList.FetchNews.Response.init(news: [firstNews])
        presenterUnderTest.presentNewsList(response: response)
        
        // Then
        let displayedNewsList = newsListDisplayLogicSpy.viewModel.NewsDetails
        

        for displayedNews in displayedNewsList
        {
            XCTAssertEqual(displayedNews.title, "News title1", "Presenting fetched news should properly format news title")
            XCTAssertEqual(displayedNews.content, "content", "Presenting fetched news should properly format news content")
            XCTAssertEqual(displayedNews.source, "From: Source1", "Presenting fetched news should properly format news url")

        }
    }
    
    func testPresentFetchedNewsShouldAskViewControllerToDisplayFetchedNews()
    {
        // Given
        let newsListDisplayLogicSpy = NewsListDisplayLogicSpy()
        presenterUnderTest.viewController = newsListDisplayLogicSpy
        
        // When
        let news = [Seeds.TopNews.firstNews]
        let response = NewsList.FetchNews.Response.init(news: news)
        presenterUnderTest.presentNewsList(response: response)
        
        // Then
        XCTAssert(newsListDisplayLogicSpy.displayFetchedNewsCalled, "Presenting fetched news should ask view controller to display them")
    }
    
    
    
}
