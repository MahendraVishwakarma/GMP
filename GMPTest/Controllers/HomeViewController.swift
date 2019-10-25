//
//  ViewController.swift
//  GMPTest
//
//  Created by Mahendra Vishwakarma on 25/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit
import Cloudinary

class HomeViewController: UIViewController , PassDataDelegate{
   
    
    var dropDownView = DropDownView()
    var selectedSize:ImageSizeIDs = .var300
    var arrdownloadImage = Array<ImageURLs>()
    @IBOutlet weak var collectionview: UICollectionView!
   
    
    @IBOutlet weak var lblSize: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
         
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        arrdownloadImage = Utils.savedURLS
        collectionview.reloadData()
    }
    @IBAction func btnAddImages(_ sender: Any) {
        addImage()
    }
    @IBAction func btnDropDown(_ sender: Any) {
        
       
        let heightt = self.dropDownView.frame.height == 0 ? Utils.dropHeight : 0
        dropDownView.productsName = Utils.getSizes()
        
        UIView.animate(withDuration: 0.1) {
            self.dropDownView.frame = CGRect(x: Int(self.dropDownView.frame.origin.x), y: Int(self.dropDownView.frame.origin.y), width: Int(self.dropDownView.frame.width), height: heightt)
          
        }
        
        self.dropDownView.updateProductNames()
        
    }
    func sendData(data: ImageSize) {
        selectedSize = data.id
        setSize()
    }
    
    func setSize(){
       lblSize.text = "Image Size:" + Utils.getStringSize(size: selectedSize.values)
    }
    
}

