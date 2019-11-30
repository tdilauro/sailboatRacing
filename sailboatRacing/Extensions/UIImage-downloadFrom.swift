//
//  UIImage-downloadFrom.swift
//  jsonData
//
//  Created by Tim DiLauro on 11/19/19.
//  Copyright © 2019 Five Lions. All rights reserved.
//

import UIKit

extension UIImage {

    convenience init?(downloadFrom urlString: String) {
        if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
            self.init(data: data)
        } else {
            return nil
        }
    }

}
