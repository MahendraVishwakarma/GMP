//
//  UploadImageViewController.swift
//  GMPTest
//
//  Created by Mahendra Vishwakarma on 25/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit
import Cloudinary

class UploadImageViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    var image:UIImage!
    @IBOutlet weak var progress: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.image = image
        progress.isHidden = true
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadImage(_ sender: Any) {
         progress.isHidden = false
        let config = CLDConfiguration(cloudName: Cloudary.cName, secure: true)
        let cloudinary = CLDCloudinary(configuration: config)
        let params = CLDUploadRequestParams()
            .setUploadPreset("f1d79nhc").setPublicId(Utils.getNewPublicId()).setTags("test")
        guard let data = image.pngData() else{
            return
        }
        cloudinary.createUploader().upload(data: data, uploadPreset: "f1d79nhc", params: params, progress: { (prog) in
            
             print(prog.fractionCompleted)
             print(prog.totalUnitCount)
            self.progress.progress = Float(prog.fractionCompleted)
            
        }) { (result, error) in
            
            if(result == nil){
                self.generateError(msg: error?.localizedDescription ?? "", heading: "Failed")
                self.progress.progress = 0.0
                return
            }
            
           
            let version = result?.version ?? ""
            let pID  = result?.publicId ?? ""
            var part = "\(version)/\(pID)"
            part = part.replacingOccurrences(of: ")", with: "%29")
            part = part.replacingOccurrences(of: "(", with: "%28")
            
             let url = ImageURLs(url:  part)
            Utils.savedURLS.append(url)
            
            self.generateError(msg: "your image uploaded successfully", heading: "Success👍")
            
        }
        
    }
    
    func generateError(msg:String, heading:String){
        let alert = UIAlertController(title: heading, message: msg, preferredStyle: .alert)
        let acr = UIAlertAction(title: "OK", style: .cancel) { (alrt) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(acr)
        self.present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
