//
//  Cloudary.swift
//  GMPTest
//
//  Created by Mahendra Vishwakarma on 25/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation


enum ImageSizeIDs {
    case var30
    case var300
    case var600
    
    var values:Int{
        switch self{
        case .var30: return 30
        case .var300: return 300
        case .var600: return 600
        }
    }
}
