//
//  StringExtentions.swift
//  Calculator Layout iOS13
//
//  Created by Valmir Torres on 11/10/19.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

extension String {
    func onlyDigits () -> String {
        var text = ""
        self.forEach({c in
            if c == "0" || c == "1" || c == "2" || c == "3" || c == "4"
                || c == "5" || c == "6" || c == "7" || c == "8" || c == "9" {
                text += String(c)
            }
        })
        
        return text
    }
    
    func isFalseDouble () -> Bool {
        return self.contains(".0") && self.last == "0"
    }
}
