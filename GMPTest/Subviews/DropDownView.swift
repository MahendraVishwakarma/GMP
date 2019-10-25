//
//  DropDownView.swift
//  ActAssignment
//
//  Created by Mahendra Vishwakarma on 24/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit

class DropDownView: UIView {

    let xibName = "DropDownView"
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var tableview: UITableView!
    var productsName:Array<ImageSize>!
    var selectedCountry:ImageSize!
    weak var delegate: PassDataDelegate!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func setupframe() {
        let topBarHeight = self.frame.origin.y
        let heightt = self.frame.height == 0 ?  Utils.dropHeight : 0
        
       // UIView.animate(withDuration: 0.1) {
            self.frame = CGRect(x: Int(self.frame.origin.x), y: Int(topBarHeight), width: Int(self.frame.width), height: heightt)
       // }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialization()
    }
    
    func initialization() {
        Bundle.main.loadNibNamed(xibName, owner: self, options: nil)
        containerView.setFrameInView(self)
        tableview.register(UINib(nibName: "SizeCell", bundle: nil), forCellReuseIdentifier: "products")
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.green.cgColor
        self.layer.borderWidth = 0.6
        
    }
    
    func updateProductNames(){
        tableview.reloadData()
    }
    
}

extension DropDownView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsName != nil ? productsName.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "products", for: indexPath) as? SizeCell else{
            return SizeCell()
        }
        cell.setData(prodName: "\(productsName[indexPath.row].size)")
        return cell
        
    }
}

extension DropDownView:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       selectedCountry = productsName[indexPath.row]
        setupframe()
        if(selectedCountry != nil){
            delegate.sendData(data: selectedCountry)
        }
    }
}
