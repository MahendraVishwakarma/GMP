//
//  Common.swift
//  GMPTest
//
//  Created by Mahendra Vishwakarma on 25/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

class Utils{
   static let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
        (44)
    static let dropHeight = 150
    static  var savedURLS = Array<ImageURLs>()
    static func getNewPublicId() ->String{
        
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return "Test"+"(\(String((0..<6).map{ _ in letters.randomElement()! })))"
    }
    
    static func getStringSize(size:Int) ->String {
        if(size == 30) {
            return "30x03"
        }else if(size == 300) {
            return "300x400"
        }else if(size == 600) {
            return "600x800"
        }
        
        return "0"
    }
    
    static func getIntSize(size:Int) ->(Int , Int) {
        if(size == 30) {
            return (30, 30)
        }else if(size == 300) {
            return (300, 400)
        }else if(size == 600) {
            return (600, 800)
        }
        
        return (0,0)
    }
    
    static func getSizes() ->[ImageSize] {
        let obj1 =  ImageSize(size: ImageSizeIDs.var30.values , id: ImageSizeIDs.var30)
        let obj2 =  ImageSize(size: ImageSizeIDs.var300.values , id: ImageSizeIDs.var300)
        let obj3 =  ImageSize(size: ImageSizeIDs.var600.values , id: ImageSizeIDs.var600)
        return [obj1, obj2 ,obj3]
    }
    
   
    
}


class Cloudary{
    static let cName = "dgy7s0gbn"
    static let api_key = "554993467335985"
    static let secret_key = "4bhpWBubUTrdR0acXHovMB2IVc0"
    static let environmental_variable = "cloudinary://554993467335985:4bhpWBubUTrdR0acXHovMB2IVc0@dgy7s0gbn/"
}
