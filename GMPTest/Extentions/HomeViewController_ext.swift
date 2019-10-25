//
//  HomeViewController_ext.swift
//  GMPTest
//
//  Created by Mahendra Vishwakarma on 25/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation
import UIKit
import Cloudinary

extension HomeViewController{
    
    func initialSetup(){
        setSize()
       
        dropDownView = DropDownView(frame: CGRect(x: 10, y: Utils.topBarHeight+10, width: self.view.frame.width-20, height: 0))
        dropDownView.delegate = self
        self.view.addSubview(dropDownView)
        //downloadImage()
        collectionview.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "itemCell")
    }
    func addImage(){
        
        let pickerController = UIImagePickerController()
        let optionMenu = UIAlertController(title: nil, message: "Choose resource to take photo", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
            {
                pickerController.delegate = self
                pickerController.sourceType = UIImagePickerController.SourceType.camera
                pickerController.allowsEditing = false
                self.present(pickerController, animated: true, completion: nil)
            }
            
        })
        
        
        let gallery = UIAlertAction(title: "Gallery", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        
        optionMenu.addAction(camera)
        optionMenu.addAction(gallery)
        optionMenu.addAction(cancel)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
}

extension HomeViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        
       guard let objectUplader = self.storyboard?.instantiateViewController(withIdentifier: "UploadImageViewController") as? UploadImageViewController else {
            return
        }
        objectUplader.image = image
        self.navigationController?.pushViewController(objectUplader, animated: true)
        dismiss(animated:true, completion: nil)
    }
    
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated:true, completion: nil)
    }
}

extension HomeViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrdownloadImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? ImageCell else {
            return ImageCell()
        }
        cell.selectedSize = selectedSize
        cell.setImage(info: arrdownloadImage[indexPath.row])
        return cell
    }
}

extension HomeViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size =  UIScreen.main.bounds.width/3 - 30/2
        return CGSize(width: size, height: size)
        
    }
}




extension UIView {
    func setFrameInView(_ container: UIView!) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
