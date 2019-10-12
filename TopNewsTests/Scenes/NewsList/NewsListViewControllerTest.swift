//
//  NewsListViewControllerTest.swift
//  TopNews
//
//  Created by Sujata Chakraborty on 12/10/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

import XCTest
@testable import TopNews

class NewsListViewControllerTest: XCTestCase {
    
    var currentControllerUnderTest : NewsListViewController!
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
        currentControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "NewsListViewController") as? NewsListViewController
    }
    
    func loadView()
    {
        window.addSubview(currentControllerUnderTest.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Test
    
    class NewsListBusinessLogicSpy: NewsListBusinessLogic
    {

        var news: [News]?
        
        // MARK: news call expectations
        
        var fetchNewsCalled = false
        
        // MARK: Spied methods

        func fetchNewsList(request: NewsList.FetchNews.Request) {
            
            fetchNewsCalled = true

        }
    }
    
    class CollectionViewViewSpy : UICollectionView
    {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: Spied methods
        
        override func reloadData()
        {
            reloadDataCalled = true
        }
    }
    

    
    // MARK: - Tests
    
    func testShouldFetchRecipWhenViewDidLoaded()
    {
        // Given
        let newsListBusinessLogicSpy = NewsListBusinessLogicSpy()
        currentControllerUnderTest.interactor = newsListBusinessLogicSpy
        loadView()
        
        // When
        currentControllerUnderTest.viewWillAppear(true)
        
        // Then
        XCTAssert(newsListBusinessLogicSpy.fetchNewsCalled, "Should fetch news right after the view loaded")
    }
    
    func testShouldDisplayFetchedNews()
    {
        // Given
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: 200, height: 200)
        
        let collectionViewSpy = CollectionViewViewSpy.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: flowLayout)
        currentControllerUnderTest.collectionView = collectionViewSpy
        
        // When
        let displayedNews = [NewsList.FetchNews.ViewModel.DisplayNews.init(title: "newsTitle", imageURL: "imsgeURL", content: "content", description: "description", time: "time", source: "source")]
        
        let viewModel = NewsList.FetchNews.ViewModel.init(NewsDetails: displayedNews)
        currentControllerUnderTest.displayNewsList(viewModel: viewModel)
        
        // Then
        XCTAssert(collectionViewSpy.reloadDataCalled, "Displaying fetched news should reload the collection view")
    }
    
    func testAfterFetchingCompleteDataNoMoreDataShouldFetch()
    {
        // Given
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: 200, height: 200)
        
        let collectionViewSpy = CollectionViewViewSpy.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: flowLayout)
        collectionViewSpy.collectionViewLayout = flowLayout
        currentControllerUnderTest.collectionView = collectionViewSpy
        
        
        // When
        let error = RBError.init(RBErrorCode: .EmptyData)
        currentControllerUnderTest.receivedError(error: error)
        
        // Then
        XCTAssertFalse(collectionViewSpy.reloadDataCalled, "Displaying fetched news should not reload collectionview")
        
    }
    

    func testNumberOfRowsInAnySectionShouldEqaulNumberOfNewsToDisplay()
    {
        // Given
        let testDisplayNews = [NewsList.FetchNews.ViewModel.DisplayNews.init(title: "newsTitle", imageURL: "imsgeURL", content: "content", description: "description", time: "time", source: "source")]
        
        currentControllerUnderTest.displayedNews = testDisplayNews
        
        // When
        let numberOfRows = currentControllerUnderTest.collectionView.numberOfItems(inSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, testDisplayNews.count, "The number of collection view rows should equal the number of news to display")
    }
    
    

}
