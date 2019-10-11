//
//  ReceipeListWorker.swift
//  TopNews
//
//  Created by Sujata Chakraborty on 11/10/2019.
//  Copyright (c) 2019 Sujata Chakraborty. All rights reserved.
//

import Foundation


/**
 Below are the error codes, each error should have an error code from list below.
 */

public enum RBErrorCode : Int {
    
    //Represent Generic error
    case GeneralError = 100
    
    //Represent parse error
    case UnableToParseErrorJson
    
    //Represent server error
    case ServerError
    
    //Represent Network error
    case NetworkError
    
    //Represent Empty data error
    case EmptyData
}


let RBErrorDomainName = "RBError"

public class RBError : NSError {
    
    /**
     ErroCode type
     */
    
    public var errorCode = RBErrorCode(rawValue: 0)
    /**
     This error code, will need to triage issue. Should include while sending an error log message to ominture.
     */
    public var RBErrorCodeString: String? = ""
    /**
     The internal error description used for debuging and to loging error in ominture.
     */
    public var rbErrorInternalDescription: String? = ""
    /**
     The message to show the user, for example in a native alert popup.
     */
    public var rbErrorDescription: String? = ""
    
    /**
     additional information logged to Server.
     */
    public var rbErrorDebugInfo: String? = ""
    
    
    /**
     Init functions
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    public init(RBErrorCode errorCode: RBErrorCode) {
        super.init(domain: RBErrorDomainName, code: errorCode.rawValue, userInfo: nil)
        
        self.errorCode = errorCode
        RBErrorCodeString = RBError.mbEsrrorCodeString(for: errorCode)
    }
    
    public class func mbEsrrorCodeString(for rbErrorCode: RBErrorCode) -> String {
        
        var errorCode: String = "0000"
        
        switch rbErrorCode {
            
        case .GeneralError :
            errorCode = "MB01"
            
        case .UnableToParseErrorJson:
            errorCode = "MB02"
            
        case .ServerError:
            errorCode = "MB03"
            
            
        case .NetworkError:
            errorCode = "MB04"

        case .EmptyData:
            errorCode = "MB05"
        }
        return errorCode
    }
    
   
    
    
    
}
