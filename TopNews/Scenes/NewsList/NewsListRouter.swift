//
//  NewsListRouter.swift
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

@objc protocol NewsListRoutingLogic
{
    func routeToNewsDetailsPage()
}

protocol NewsListDataPassing
{
    var dataStore: NewsListDataStore? { get }
}

class NewsListRouter: NSObject, NewsListRoutingLogic, NewsListDataPassing
{
    weak var viewController: NewsListViewController?
    var dataStore: NewsListDataStore?
    
    // MARK: Routing
    
    func routeToNewsDetailsPage()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToNewsDetails(source: dataStore!, destination: &destinationDS )
        navigateToNewsDetails(source: viewController!, destination: destinationVC)
    }
    
    
    // MARK: Navigation
    
    func navigateToNewsDetails(source: NewsListViewController, destination: NewsDetailsViewController)
    {
        source.show(destination, sender: nil)
    }
    
    //MARK: Passing data
    
    func passDataToNewsDetails(source: NewsListDataStore, destination: inout NewsDetailsDataStore)
    {
        let selectedRow = viewController?.collectionView.indexPathsForSelectedItems?.first
        destination.news = source.newsList[selectedRow!.item]
    }
}