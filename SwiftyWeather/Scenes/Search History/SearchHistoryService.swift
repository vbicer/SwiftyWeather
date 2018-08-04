//
//  SearchHistoryService.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 4.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation
import RealmSwift

class SearchHistoryService {
    let realm = try! Realm()
    
    public func addToHistory(_ cityName: String){
        guard  !isCityExist(cityName) else {
            return
        }
        
        let city = CityEntity()
        city.name = cityName
        try! realm.write {
            realm.add(city)
        }
    }
    
    
    public func clearHistory(){
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
    public func getHistory() -> [String]{
        let cities = realm.objects(CityEntity.self)
        return cities.compactMap{$0.name}
    }
    
    
    public func isHistoryEmpty() -> Bool{
        return getHistory().isEmpty
    }
    
    
    private func isCityExist(_ city: String) -> Bool{
        let cities = realm.objects(CityEntity.self)
        let theCity = cities.first {$0.name?.lowercased() == city.lowercased()}
        return theCity == nil ? false : true
    }
}

class CityEntity: Object {
    @objc dynamic var name:String?
}
