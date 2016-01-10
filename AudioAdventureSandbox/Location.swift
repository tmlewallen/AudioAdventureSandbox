//
//  Location.swift
//  AudioAdventureSandbox
//
//  Created by Thomas on 1/7/16.
//  Copyright © 2016 Thomas. All rights reserved.
//

import UIKit

class Location: NSObject {

    let name : String
    let rawData : NSDictionary
    var audioURL : NSURL!
    var paths = [Direction : Location?](minimumCapacity: 4)
    
    enum Direction : Int {
        case NORTH = 0
        case SOUTH
        case EAST
        case WEST
    }
    
    init(name: String, audio : String, data : NSDictionary){
        self.name = name
        self.rawData = data
        if let temp = NSBundle.mainBundle().pathForResource(audio, ofType: nil) {
            self.audioURL = NSURL(fileURLWithPath: temp)
        }
        else {
            print("ERROR in \(name)")
        }
    }
    
    func goNorth() -> Location? {
        if let path = self.paths[.NORTH]{
            return path
        }
        return nil
    }
    
    func goEast() -> Location? {
        if let path = self.paths[.EAST]{
            return path
        }
        return nil
    }
    
    func goWest() ->Location? {
        if let path = self.paths[.WEST]{
            return path
        }
        return nil
    }
    
    func goSouth() ->Location? {
        if let path = self.paths[.SOUTH]{
            return path
        }
        return nil
    }
    
    func setNorthPath(location : Location){
        self.paths[.NORTH] = location
    }
    
    func setEastPath(location : Location){
        self.paths[.EAST] = location
    }
    
    func setWestPath(location : Location){
        self.paths[.WEST] = location
    }
    
    func setSouthPath(location : Location){
        self.paths[.SOUTH] = location
    }

}
