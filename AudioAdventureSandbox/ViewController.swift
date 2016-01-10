//
//  ViewController.swift
//  AudioAdventureSandbox
//
//  Created by Thomas on 1/4/16.
//  Copyright © 2016 Thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let map = Map(isDemo: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTap.numberOfTapsRequired = 2
        
        let tap = UITapGestureRecognizer(target: self, action: "singleTap:")
        tap.numberOfTapsRequired = 1
        tap.requireGestureRecognizerToFail(doubleTap)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeDown)
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeUp)
        self.view.addGestureRecognizer(tap)
        self.view.addGestureRecognizer(doubleTap)
        map.setupAudio()
        map.playAudio()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func singleTap(tap : UIGestureRecognizer){
        map.action()
    }
    
    func doubleTap(tap : UIGestureRecognizer){
        map.playAudio()
    }

    func swipe(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            map.go(swipeGesture.direction)
        }
    }
    
    
}

