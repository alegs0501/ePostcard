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
        
        imageBack.isHidden = true
        
        
        //Gestures for front image
        imageFront.isUserInteractionEnabled = true
        let swipeGestureFrontRight = UISwipeGestureRecognizer(target: self, action: #selector(self.getSwipeActionFront(_ :)))
        swipeGestureFrontRight.direction = .right
        self.imageFront.addGestureRecognizer(swipeGestureFrontRight)
        
        let swipeGestureFrontLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.getSwipeActionFront(_ :)))
        swipeGestureFrontLeft.direction = .left
        self.imageFront.addGestureRecognizer(swipeGestureFrontLeft)
        
        //Gestures for back image
        imageBack.isUserInteractionEnabled = true
        let swipeGestureBackRight = UISwipeGestureRecognizer(target: self, action: #selector(self.getSwipeActionBack(_ :)))
        swipeGestureBackRight.direction = .right
        self.imageBack.addGestureRecognizer(swipeGestureBackRight)
        
        let swipeGestureBackLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.getSwipeActionBack(_ :)))
        swipeGestureBackLeft.direction = .left
        self.imageBack.addGestureRecognizer(swipeGestureBackLeft)
        
    }
    
    @objc func getSwipeActionFront(_ recognizer: UISwipeGestureRecognizer) {
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .easeOut, animations: nil)
        animator.addAnimations {
            print(recognizer.direction)
            self.imageFront.isHidden = true
            self.imageBack.isHidden = false
        }
        animator.startAnimation()
    }
    
    @objc func getSwipeActionBack(_ recognizer: UISwipeGestureRecognizer) {
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .easeOut, animations: nil)
        animator.addAnimations {
            print(recognizer.direction)
            self.imageBack.isHidden = true
            self.imageFront.isHidden = false
        }
        animator.startAnimation()
        
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
