//
//  UtilityClass.swift
//  TopNews
//
//  Created by Sujata Chakraborty on 11/10/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

import Foundation


class UtilityClass
{
    
    public static var dateFormatterInstance = DateFormatter()
    
    //MARK : Date Converstion Utility functions
    
    /**
     
     The function will be used to convert "2017-12-05T02:18:18.571Z" string DateFormat
     
     */
    class func stringToDateFormat(dateInString : String) -> Date?
    {
        UtilityClass.dateFormatterInstance.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        UtilityClass.dateFormatterInstance.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = UtilityClass.dateFormatterInstance.date(from:dateInString)
        return date
        
    }
    
    
    /**
     
     The function will be used to convert Time difference from two Given Time
     It returns in String format
     
     */
    
    class func findDifference(FromTime:Date , toDate : Date) -> String
    {
        let elapsed = FromTime.timeIntervalSince(toDate)
        
        let timeInterval = NSInteger(elapsed)
        
        let hours = (timeInterval / 3600)
        let seconds = timeInterval % 60
        let minutes = (timeInterval / 60) % 60
        
        if hours > 0
        {
            if hours == 1
            {
                return "an hour ago"
            }
            else
            {
                let outputTimeDiff = String(hours) + " hours ago"
                return outputTimeDiff
                
            }
        }
        else if (minutes > 0)
        {
            if minutes == 1
            {
                return "a minute ago"
            }
            else
            {
                let outputTimeDiff = String(minutes) + " minutes ago"
                return outputTimeDiff
                
            }
        }
        else if (seconds > 0)
        {
            if seconds == 1
            {
                return "a second ago"
            }
            else
            {
                let outputTimeDiff = String(seconds) + " seconds ago"
                return outputTimeDiff
                
            }
            
        }
        else
        {
            return Constants.kJustNowConstant
        }
        
    }
    
    
}
