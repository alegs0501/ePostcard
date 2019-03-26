//
//  ViewControllerFront.swift
//  ePostcard
//
//  Created by Alejandro Gallardo on 26/03/2019.
//  Copyright © 2019 Alejandro Gallardo. All rights reserved.
//

import UIKit

class ViewControllerFront: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var filtersScrollView: UIScrollView!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var CIFilterNames = [
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.isEnabled = false

    }
    
    func loadFilters() {
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 70
        let buttonHeight: CGFloat = 70
        let gapBetweenButtons: CGFloat = 5
        
        var itemCount = 0
        
        for i in 0..<CIFilterNames.count {
            itemCount = i
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.addTarget(self, action: #selector(ViewControllerFront.filterButtonTapped(_sender:)), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: imageView.image!)
            let filter = CIFilter(name: "\(CIFilterNames[i])" )
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
            let imageForButton = UIImage(cgImage: filteredImageRef!);
            
            // Assign filtered image to the button
            filterButton.setBackgroundImage(imageForButton, for: .normal)
            
            // Add Buttons in the Scroll View
            xCoord +=  buttonWidth + gapBetweenButtons
            filtersScrollView.addSubview(filterButton)
        } // END FOR LOOP
        
        
        // Resize Scroll View
        filtersScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount + 2), height: yCoord)
    }
    
    @objc func filterButtonTapped(_sender: UIButton) {
        let button = _sender as UIButton
        
        imageView.image = button.backgroundImage(for: UIControl.State.normal)
    }
    
    @IBAction func loadImage(_ sender: Any) {
        presentImagePicker()
    }
    
    @IBAction func done(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        PostcardReference.front = imageView.image
    }
    
}

// MARK: - UINavigationControllerDelegate
extension ViewControllerFront: UINavigationControllerDelegate {
}

// MARK: - UIImagePickerControllerDelegate
extension ViewControllerFront: UIImagePickerControllerDelegate {
    func presentImagePicker() {
        
        let imagePickerActionSheet = UIAlertController(title: "Take/Upload Image",
                                                       message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                                             style: .default) { (alert) -> Void in
                                                let imagePicker = UIImagePickerController()
                                                imagePicker.delegate = self
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker, animated: true)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        
        let libraryButton = UIAlertAction(title: "Choose Existing",
                                          style: .default) { (alert) -> Void in
                                            let imagePicker = UIImagePickerController()
                                            imagePicker.delegate = self
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker, animated: true)
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        
        present(imagePickerActionSheet, animated: true)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Error: \(info)")
            return
        }
        
        let scaledImage = selectedImage.scaleImage(640)
        
        
        dismiss(animated: true, completion: nil)
        imageView.image = selectedImage
        loadFilters()
        doneButton.isEnabled = true
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UIImage extension
extension UIImage {
    func scaleImage(_ maxDimension: CGFloat) -> UIImage? {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        
        if size.width > size.height {
            let scaleFactor = size.height / size.width
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            let scaleFactor = size.width / size.height
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}
