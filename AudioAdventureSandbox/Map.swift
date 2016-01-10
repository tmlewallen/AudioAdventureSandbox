//
//  Map.swift
//  AudioAdventureSandbox
//
//  Created by Thomas on 1/7/16.
//  Copyright © 2016 Thomas. All rights reserved.
//

import UIKit
import AVFoundation

class Map: NSObject {
    
    let entryPoint : Location
    var currentLocation : Location
    var audioPlayer : AVAudioPlayer!
    
    init(isDemo : Bool) {
        if isDemo {
            let one = Location(name: "One", audio: "One.m4a", data: NSDictionary())
            let two = Location(name: "Two", audio: "Two.m4a", data: NSDictionary())
            let three = Location(name: "Three", audio: "Three.m4a", data: NSDictionary())
            one.setNorthPath(two)
            two.setSouthPath(one)
            two.setNorthPath(three)
            three.setSouthPath(two)
            entryPoint = one
            currentLocation = entryPoint
        }
        else {
            let mb = MapBuilder(configFile: "aa")
            if let startingPoint = mb.build() {
                entryPoint = startingPoint
                currentLocation = entryPoint
            }
            else {
                NSLog("Error in building map")
                entryPoint = Location(name: "One", audio: "One.m4a", data: NSDictionary())
                currentLocation = entryPoint
            }
        }
    }
    
    func setupAudio(){
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL: currentLocation.audioURL)
        }
        catch {
            NSLog("An Error Occurred")
        }
        
    }
    
    func action(){
        NSLog("Action")
    }
    
    func playAudio(){
        audioPlayer.play()
        NSLog(currentLocation.name)
    }
    
    func go(direction : UISwipeGestureRecognizerDirection){
        switch (direction){
        case UISwipeGestureRecognizerDirection.Right:
            NSLog("Right")
            if let nextLocation = currentLocation.goEast(){
                currentLocation = nextLocation
                setupAudio()
                playAudio()
            }
        case UISwipeGestureRecognizerDirection.Down:
            NSLog("Down")
            if let nextLocation = currentLocation.goSouth(){
                currentLocation = nextLocation
                setupAudio()
                playAudio()
            }
        case UISwipeGestureRecognizerDirection.Left:
            NSLog("Left")
            if let nextLocation = currentLocation.goWest(){
                currentLocation = nextLocation
                setupAudio()
                playAudio()
            }
        case UISwipeGestureRecognizerDirection.Up:
            NSLog("Up")
            if let nextLocation = currentLocation.goNorth(){
                currentLocation = nextLocation
                setupAudio()
                playAudio()
            }
        default:
            print("Unrecognized swipe")
        }
    }
}