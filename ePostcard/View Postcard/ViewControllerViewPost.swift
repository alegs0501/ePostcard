//
//  ViewControllerViewPost.swift
//  ePostcard
//
//  Created by Alejandro Gallardo on 26/03/2019.
//  Copyright © 2019 Alejandro Gallardo. All rights reserved.
//

import UIKit

class ViewControllerViewPost: UIViewController {
    
    @IBOutlet weak var imageFront: UIImageView!
    @IBOutlet weak var imageBack: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageFront.image = PostcardReference.front
        imageBack.image = PostcardReference.back
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
