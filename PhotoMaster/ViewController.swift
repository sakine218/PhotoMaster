//
//  ViewController.swift
//  PhotoMaster
//
//  Created by Sakine Nishibayashi on 2019/03/31.
//  Copyright © 2019 Sakine Nishibayashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onTappedCameraButton() {
        presentPickerController(sourceType: .camera)
    }
    
    @IBAction func onTappedAlubmButton() {
        presentPickerController(sourceType: .photoLibrary)
    }
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = info[.originalImage] as? UIImage
    }
    
    func drawText(image: UIImage) -> UIImage {
        let text = "LifeisTech!"
        
        let textFontAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 120)!, NSAttributedString.Key.foregroundColor: UIColor.red]
        
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let margin: CGFloat = 5.0
        let textRect = CGRect(x: margin, y: margin, width: image.size.width - margin, height: image.size.height - margin)
        text.draw(in: textRect, withAttributes: textFontAttributes)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func drawMaskImage(image: UIImage) -> UIImage {
        let maskImage = UIImage(named: "yarigai.png")!
        
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 50.0
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin, y: image.size.height - maskImage.size.height - margin, width: maskImage.size.width, height: maskImage.size.height)
        maskImage.draw(in: maskRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    @IBAction func onTappedTextButtn() {
        if photoImageView.image != nil {
            photoImageView.image = drawText(image: photoImageView.image!)
        } else {
            print("画像がありません")
        }
    }
    
    @IBAction func onTappedIllustButton() {
        if photoImageView.image != nil {
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        } else {
            print("画像がありません")
        }
    }
    
    @IBAction func onTappedUploadButton() {
        if photoImageView.image != nil {
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!, "#PhotoMaster"], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        } else {
            print("画像がありません")
        }
    }


}

