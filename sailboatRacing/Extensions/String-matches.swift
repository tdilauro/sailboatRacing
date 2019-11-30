//
//  String-matches.swift
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import Foundation

extension String {

    func matches(_ regex: String, options: NSString.CompareOptions = .regularExpression) -> Bool {
        return self.range(of: regex, options: options, range: nil, locale: nil) != nil
    }

}
