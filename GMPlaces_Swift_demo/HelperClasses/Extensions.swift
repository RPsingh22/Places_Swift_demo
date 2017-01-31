//
//  Extensions.swift
//  GMPlaces_Swift_demo
//
//  Created by Cerebrum on 30/01/17.
//  Copyright © 2017 Cerebrum. All rights reserved.
//
//@Class: This is a extenstion of string

import UIKit

extension String
{
    //MARK:- This method is use to remove spaces and new line character from string
    
    func removeWhiteSpaces() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    //MARK:- This method is use to get particular substring from a string
    
    func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advanced(by: nsRange.location)
        let to16 = from16.advanced(by: nsRange.length)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
            return from ..< to
        }
        return nil
    }
}
