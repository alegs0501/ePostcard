//
//  Postcard.swift
//  ePostcard
//
//  Created by Alejandro Gallardo on 26/03/2019.
//  Copyright © 2019 Alejandro Gallardo. All rights reserved.
//

import UIKit
import Foundation

class PostcardDAO {
    var front: UIImage?
    var back: UIImage?
    
    init(front: NSData, back: NSData) {
        self.front = UIImage(data: front as Data)
        self.back = UIImage(data: back as Data)
    }
    
    
}
