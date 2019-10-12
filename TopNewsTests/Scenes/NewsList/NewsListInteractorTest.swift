//
//  NewsListInteractorTest.swift
//  TopNews
//
//  Created by Sujata Chakraborty on 12/10/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

import XCTest
@testable import TopNews

class NewsListInteractorTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var interactorUnderTest: NewsListInteractor!
    
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
        interactorUnderTest = NewsListInteractor()
    }
    
    // MARK: - Test doubles
    
    class NewsListPresentationLogicSpy: NewsListPresentationLogic
    {
        
        
        // MARK: Method call expectations
        
        var presentNewsListCalled = false
        var presentErrorDisplayCalled = false
        
        func presentNewsList(response: NewsList.FetchNews.Response) {
            
            presentNewsListCalled = true
        }
        
        func presentError(error: RBError) {
            
            presentErrorDisplayCalled = true
        }
        
    }
    
    class NewsWorkerSpy: NewsListWorker
    {
        // MARK: Method call expectations
        
        var fetchNewsCalled = false
        
        // MARK: Spied methods
        
        override func fetchNewsList(url: String, pageSize: Int, pageNumber: Int, completionHandler: @escaping (Articles?, RBError?) -> Void) {
            
            fetchNewsCalled = true
            completionHandler(Seeds.TopNews.firstArticle , nil)
        }
        
        
    }
    
    class NewsWorkerErrorSpy : NewsListWorker
    {
        // MARK: Method call expectations
        
        var fetchNewsCalled = false
        
        // MARK: Spied methods
        
        override func fetchNewsList(url: String, pageSize: Int, pageNumber: Int, completionHandler: @escaping (Articles?, RBError?) -> Void) {
            
            fetchNewsCalled = true
            
            let error = RBError.init(RBErrorCode: .ServerError)
            completionHandler(nil ,error )
        }
        
    }
    
    
    
    // MARK: - Tests
    
    func testFetchNewsShouldAskNewsWorkerToFetchNewsAndPresenterToFormatResult()
    {
        // Given
        let newsPresentationLogicSpy = NewsListPresentationLogicSpy()
        interactorUnderTest.presenter = newsPresentationLogicSpy
        let newsWorkerSpy = NewsWorkerSpy.init()
        interactorUnderTest.worker = newsWorkerSpy
        
        // When
        let request = NewsList.FetchNews.Request.init(pageSize: 21, pageNumber: 1)
        interactorUnderTest.fetchNewsList(request: request)
        
        // Then
        XCTAssert(newsWorkerSpy.fetchNewsCalled, "fetchNewsList() should ask NewsWorker to fetch news")
    }
    
    
    
    
    func testFetchNewsShouldAskNewsWorkerToFetchNewsAndPresenterToShowError()
    {
        // Given
        let newsPresentationLogicSpy = NewsListPresentationLogicSpy()
        interactorUnderTest.presenter = newsPresentationLogicSpy
        let newsWorkerSpy = NewsWorkerErrorSpy.init()
        interactorUnderTest.worker = newsWorkerSpy
        
        // When
        let request = NewsList.FetchNews.Request.init(pageSize: 21, pageNumber: 1)
        interactorUnderTest.fetchNewsList(request: request)
        
        // Then
        XCTAssert(newsWorkerSpy.fetchNewsCalled, "fetchNewsList() should ask newsWorker to fetch news")
    }
    
    
    
    
}
