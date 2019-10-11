//
//  String+Shortcut.swift
//  TopNews
//
//  Created by Sujata Chakraborty on 11/10/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

import Foundation


extension String {
    
    func trim() -> String
    {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
