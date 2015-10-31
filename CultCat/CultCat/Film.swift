//
//  Film.swift
//  CultCat
//
//  Created by Михаил on 31.10.15.
//  Copyright © 2015 Mihail. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON
import MagicalRecord

@objc(Film)
class Film: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var rate: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var imageUrl: String?
    @NSManaged var genre: String
    @NSManaged var rating: NSNumber?
    @NSManaged var duration: NSNumber?
    
    var questions = [Question]()
    
    
    static func getRunningFilms() -> [Film] {
        return getFilmsWithUrl("https://api.kinohod.ru/api/data/1/eed7c723-0b90-3fc9-a3bc-bf235e907b35/running.json.gz")
    }
    
    static func getFilmsWithUrl(urlString: String) -> [Film] {
        var result = [Film]()
        let url = NSURL(string: urlString)
        if url == nil {
            return result
        }
        
        let compressedData = NSData(contentsOfURL: url!)
        let data = try! compressedData!.gunzippedData()
        
        let jsonOb: JSON = JSON(data: data)
        for filmOb in jsonOb.arrayValue {
            let film = Film.MR_createEntity() as! Film
            film.name = filmOb["title"].stringValue
            print(Int(filmOb["rating"].doubleValue))
            film.rate = Int(filmOb["rating"].doubleValue)
            film.rating = 1.0
            film.genre = ""
            for g in filmOb["genres"].arrayValue {
                if film.genre != "" {
                    film.genre = film.genre + ", "
                }
                film.genre = g["name"].stringValue
            }
            film.imageUrl = ""
            film.duration = filmOb["duration"].doubleValue
            
            print(film.name)
            result.append(film)
        }
        return result
    }
}