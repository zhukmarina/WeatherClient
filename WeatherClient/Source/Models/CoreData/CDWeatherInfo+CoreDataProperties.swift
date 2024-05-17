//
//  CDWeatherInfo+CoreDataProperties.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 15.05.2024.
//
//

import Foundation
import CoreData


extension CDWeatherInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWeatherInfo> {
        return NSFetchRequest<CDWeatherInfo>(entityName: "CDWeatherInfo")
    }

    @NSManaged public var cityName: String
    @NSManaged public var humidity: Int32
    @NSManaged public var id: Int32
    @NSManaged public var pressure: Int32
    @NSManaged public var temperature: Double
    @NSManaged public var wind: Double
    @NSManaged public var dt: Int32
    @NSManaged public var relationship: CDWeatherDetails?

}

extension CDWeatherInfo : Identifiable {

}
