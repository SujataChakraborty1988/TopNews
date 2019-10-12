//
//  NewsDetailsViewControllerTest.swift
//  TopNews
//
//  Created by Sujata Chakraborty on 12/10/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

import XCTest
@testable import TopNews

class NewsDetailsViewControllerTest: XCTestCase {
    
    var currentControllerUnderTest : NewsDetailsViewController!
    var window: UIWindow!
    
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupListNewsViewController()
        
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    func setupListNewsViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        currentControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as? NewsDetailsViewController
    }
    
    func loadView()
    {
        window.addSubview(currentControllerUnderTest.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Test
    
    class NewsDetailsBusinessLogicSpy: NewsDetailsBusinessLogic
    {

        // MARK: news call expectations
        
        var fetchNewsCalled = false
        
        // MARK: Spied methods

        func fetchNewsDetails(request: NewsDetails.FetchNewsDetails.Request) {
            
            fetchNewsCalled = true
            
        }
    }
    
    
    // MARK: - Tests
    
    func testShouldFetchRecipWhenViewDidLoaded()
    {
        // Given
        let newsDetailsBusinessLogicSpy = NewsDetailsBusinessLogicSpy()
        currentControllerUnderTest.interactor = newsDetailsBusinessLogicSpy
        loadView()
        
        // When
        currentControllerUnderTest.viewDidLoad()
        
        // Then
        XCTAssert(newsDetailsBusinessLogicSpy.fetchNewsCalled, "Should fetch news right after the view loaded")
    }
    
    

}
