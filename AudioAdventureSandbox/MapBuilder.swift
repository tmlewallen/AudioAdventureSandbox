//
//  MapBuilder.swift
//  AudioAdventureSandbox
//
//  Created by Thomas on 1/9/16.
//  Copyright © 2016 Thomas. All rights reserved.
//

import Foundation

enum ConfigError : ErrorType {
    case InvalidFormatError
    case MissingFieldError
    case MapBuilderFailureError
}

class MapBuilder {
    
    var jsonResult : NSDictionary!
    var locationArray : Array<NSDictionary>!
    var locationDict : [String : Location] = [String : Location]()
    var entrance : String!
    
    
    init(configFile : String) {
        if let path = NSBundle.mainBundle().pathForResource(configFile, ofType : "json"){
            do {
                let jsonData = try NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
                jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? NSDictionary
                if let val = jsonResult[configFile] as? Array<NSDictionary> {
                    locationArray = val
                }
                else{
                    throw ConfigError.InvalidFormatError
                }
            }
            catch ConfigError.InvalidFormatError {
                NSLog("Format is incorrect")
            }
            catch {
                NSLog("Error in reading configFile \(configFile)... Aborting...")
            }
        }
    }
    
    func build() -> Location? {
        buildLocationDictionary()
        connectLocations()
        guard let startingPoint = locationDict[entrance] else {
            return nil
        }
        return startingPoint
    }
    
    private func connectLocations(){
        for (name,location) in locationDict {
            do {
                guard let paths = location.rawData["paths"] as? NSDictionary else {
                    throw ConfigError.MissingFieldError
                }
                for (key,val) in paths {
                    guard let val = val as? String else{
                        throw ConfigError.InvalidFormatError
                    }
                    guard let destination = locationDict[val] else {
                        throw ConfigError.InvalidFormatError
                    }
                    guard let key = key as? String else {
                        throw ConfigError.InvalidFormatError
                    }
                    switch key{
                    case "north" :
                        location.setNorthPath(destination)
                    case "south" :
                        location.setSouthPath(destination)
                    case "east" :
                        location.setEastPath(destination)
                    case "west" :
                        location.setWestPath(destination)
                    default :
                        NSLog("Invalid Direction in location : \(name)")
                        throw ConfigError.MissingFieldError
                    }
                }
            }
            catch {
                NSLog("Error in \(location.description): connection failed")
            }
        }
    }
    
    private func buildLocationDictionary() {
        for location in locationArray {
            do {
                guard let name = location["name"] as? String else {
                    throw ConfigError.MissingFieldError
                }
                guard let audio = location["audio"] as? String else {
                    throw ConfigError.MissingFieldError
                }
                guard let _ = location["paths"] as? NSDictionary else {
                    throw ConfigError.MissingFieldError
                }
                if let entrance = location["entrance"] as? Bool {
                    if entrance {
                        self.entrance = name
                    }
                }
                locationDict[name] = Location(name: name, audio: audio, data : location)
            }
            catch {
                NSLog("Error in \(location.description): Invalid Formatting")
            }
        }
        NSLog(locationDict.description)
    }
}