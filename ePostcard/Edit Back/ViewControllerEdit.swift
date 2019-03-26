//
//  ViewControllerEdit.swift
//  ePostcard
//
//  Created by Alejandro Gallardo on 26/03/2019.
//  Copyright © 2019 Alejandro Gallardo. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerEdit: UIViewController {

    @IBOutlet weak var imageBack: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageBack.image = image
    }
    
    func createData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let postcardEntity = NSEntityDescription.entity(forEntityName: "Postcard", in: managedContext)
        
        let postcard = NSManagedObject(entity: postcardEntity!, insertInto: managedContext)
        let front: NSData =  PostcardReference.front?.pngData()! as! NSData
        let back: NSData = imageBack.image?.pngData() as! NSData
        
        postcard.setValue(front, forKey: "front")
        postcard.setValue(back, forKey: "back")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't save \(error)")
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        createData()
    }
    

}
