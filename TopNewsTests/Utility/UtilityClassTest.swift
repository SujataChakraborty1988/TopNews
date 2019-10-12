//
//  StringShortcutTest.swift
//  MBloggingTests
//
//  Created by Sujata Chakraborty on 28/09/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

@testable import TopNews
import XCTest

class UtilityClassTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        super.tearDown()
    }


    
    func testStringtoDateConversion()
    {
        let dateFormatterInstance = DateFormatter()
        let inputDate = Seeds.UtilityTest.stringDateInput
        
        dateFormatterInstance.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatterInstance.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatterInstance.date(from:inputDate)  ?? Date()
        
        XCTAssertTrue(UtilityClass.stringToDateFormat(dateInString: inputDate) == date, "dates are not same")
    }
    
    
    func testFindDifferenceBetweenDatesForOneHour()
    {
        let dateFormatterInstance = DateFormatter()
        let inputDate = Seeds.UtilityTest.stringDateInput
        let inputDateOneHour = Seeds.UtilityTest.stringDateOneHourInput

        
        dateFormatterInstance.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatterInstance.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatterInstance.date(from:inputDate)  ?? Date()
        
        let targetDate = dateFormatterInstance.date(from:inputDateOneHour)  ?? Date()

        let outputStr = UtilityClass.findDifference(FromTime: targetDate, toDate: date)
        
        XCTAssertTrue(outputStr == "an hour ago", "dates are not same")
    }
    
    func testFindDifferenceBetweenDatesForMoreHour()
    {
        let dateFormatterInstance = DateFormatter()
        let inputDate = Seeds.UtilityTest.stringDateInput
        let inputDateOneHour = Seeds.UtilityTest.stringDateTwoHourInput
        
        
        dateFormatterInstance.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatterInstance.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatterInstance.date(from:inputDate)  ?? Date()
        
        let targetDate = dateFormatterInstance.date(from:inputDateOneHour)  ?? Date()
        
        let outputStr = UtilityClass.findDifference(FromTime: targetDate, toDate: date)
        
        XCTAssertTrue(outputStr == "2 hours ago", "dates are not same")
    }
    
    
    func testFindDifferenceBetweenDatesForMoreMinutes()
    {
        let dateFormatterInstance = DateFormatter()
        let inputDate = Seeds.UtilityTest.stringDateInput
        let inputDateOneHour = Seeds.UtilityTest.stringDateTwoMinInput
        
        
        dateFormatterInstance.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatterInstance.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatterInstance.date(from:inputDate)  ?? Date()
        
        let targetDate = dateFormatterInstance.date(from:inputDateOneHour)  ?? Date()
        
        let outputStr = UtilityClass.findDifference(FromTime: targetDate, toDate: date)
        
        XCTAssertTrue(outputStr == "2 minutes ago", "dates are not same")
    }
    
    func testFindDifferenceBetweenDatesForOneMinutes()
    {
        let dateFormatterInstance = DateFormatter()
        let inputDate = Seeds.UtilityTest.stringDateInput
        let inputDateOneHour = Seeds.UtilityTest.stringDateOneMinInput
        
        
        dateFormatterInstance.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatterInstance.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatterInstance.date(from:inputDate)  ?? Date()
        
        let targetDate = dateFormatterInstance.date(from:inputDateOneHour)  ?? Date()
        
        let outputStr = UtilityClass.findDifference(FromTime: targetDate, toDate: date)
        
        XCTAssertTrue(outputStr == "a minute ago", "dates are not same")
    }
    
    func testFindDifferenceBetweenDatesForOneSecond()
    {
        let dateFormatterInstance = DateFormatter()
        let inputDate = Seeds.UtilityTest.stringDateInput
        let inputDateOneHour = Seeds.UtilityTest.stringDateInputOneSec
        
        
        dateFormatterInstance.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatterInstance.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatterInstance.date(from:inputDate)  ?? Date()
        
        let targetDate = dateFormatterInstance.date(from:inputDateOneHour)  ?? Date()
        
        let outputStr = UtilityClass.findDifference(FromTime: targetDate, toDate: date)
        
        XCTAssertTrue(outputStr == "a second ago", "dates are not same")
    }
    
    
    func testFindDifferenceBetweenDatesForMoreSecond()
    {
        let dateFormatterInstance = DateFormatter()
        let inputDate = Seeds.UtilityTest.stringDateInput
        let inputDateOneHour = Seeds.UtilityTest.stringDateSecInput
        
        
        dateFormatterInstance.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatterInstance.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatterInstance.date(from:inputDate)  ?? Date()
        
        let targetDate = dateFormatterInstance.date(from:inputDateOneHour)  ?? Date()
        
        let outputStr = UtilityClass.findDifference(FromTime: targetDate, toDate: date)
        
        XCTAssertTrue(outputStr == "30 seconds ago", "dates are not same")
    }
    
   

}
