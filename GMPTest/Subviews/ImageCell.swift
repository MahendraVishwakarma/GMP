//
//  ImageCell.swift
//  GMPTest
//
//  Created by Mahendra Vishwakarma on 25/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit
import Cloudinary

class ImageCell: UICollectionViewCell {

    let config = CLDConfiguration(cloudName: Cloudary.cName, secure: true)
    @IBOutlet weak var imageview: UIImageView!
    var selectedSize:ImageSizeIDs!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage(info:ImageURLs){
        
        let cloudinary = CLDCloudinary(configuration: config)
        let name =  info.url+".png"
        let imgSize = Utils.getIntSize(size: selectedSize.values)
        
        guard let url = cloudinary.createUrl()
            .setTransformation(CLDTransformation()
                .setWidth(imgSize.0).setHeight(imgSize.1))
            .generate(name) else{
                return
        }
        
         let perr = url.components(separatedBy: "v1")
        
        let durl = (perr.first ?? "") + "v1" + (perr.last ?? "").dropFirst()
        
        cloudinary.cachePolicy = CLDImageCachePolicy.disk
        cloudinary.cacheMaxDiskCapacity = 50 * 1024 * 1024
        
        let downloader:CLDDownloader = cloudinary.createDownloader()
        
        downloader.fetchImage(durl) { (image, error) in
            if(error == nil){
                DispatchQueue.main.async {
                     self.imageview.image = image
                }
               
            }
        }

    }
    
}
