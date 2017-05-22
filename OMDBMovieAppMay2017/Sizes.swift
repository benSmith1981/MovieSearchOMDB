//
//  Sizes.swift
//  OMDB
//
//  Created by Ben Smith on 10/05/16.
//  Copyright © 2016 Ben Smith. All rights reserved.
//

import UIKit
import Foundation

struct Size {
    // Calculate percentage
    func percentage(of:CGFloat, percentage: CGFloat ) -> CGFloat {
        return percentage * of/100
    }
  
}
