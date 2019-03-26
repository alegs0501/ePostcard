//
//  ViewController.swift
//  ePostcard
//
//  Created by Alejandro Gallardo on 26/03/2019.
//  Copyright © 2019 Alejandro Gallardo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var list = [PostcardDAO]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        retrieveData()
        collectionView.dataSource = self
    }
    
    // MARK: - Collection View Data Source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMain", for: indexPath) as! CollectionViewCellMain
        
        cell.postcardImage.image = list[indexPath.row].front
        
        return cell
    }
    
    func retrieveData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Postcard")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let postcard = PostcardDAO(front: data.value(forKey: "front") as! NSData, back: data.value(forKey: "back") as! NSData)
                list.append(postcard)
            }
        } catch  {
            print("Data Receive Fail")
        }
    }
    
    @IBAction func unwindToMainController(segue: UIStoryboardSegue) {
        if list.count > 0 {
            list.removeAll()
        }
        retrieveData()
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewPostcard" {
            if let indexPath = collectionView.indexPathsForSelectedItems{
                // Pass the selected object to the new view controller.
                let iPath: NSIndexPath = indexPath[0] as NSIndexPath
                PostcardReference.front = list[iPath.row].front
                PostcardReference.back = list[iPath.row].back
                
                
            }
        }
    }


}

