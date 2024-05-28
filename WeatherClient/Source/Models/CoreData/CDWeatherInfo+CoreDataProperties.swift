//
//  CDWeatherInfo+CoreDataProperties.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 28.05.2024.
//
//

import Foundation
import CoreData


extension CDWeatherInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWeatherInfo> {
        return NSFetchRequest<CDWeatherInfo>(entityName: "CDWeatherInfo")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var dt: Double
    @NSManaged public var humidity: Int32
    @NSManaged public var id: Int32
    @NSManaged public var pressure: Int32
    @NSManaged public var speed: Double
    @NSManaged public var temperature: Double
    @NSManaged public var weatherDetails: NSSet?

}

// MARK: Generated accessors for weatherDetails
extension CDWeatherInfo {

    @objc(addWeatherDetailsObject:)
    @NSManaged public func addToWeatherDetails(_ value: CDWeatherDetails)

    @objc(removeWeatherDetailsObject:)
    @NSManaged public func removeFromWeatherDetails(_ value: CDWeatherDetails)

    @objc(addWeatherDetails:)
    @NSManaged public func addToWeatherDetails(_ values: NSSet)

    @objc(removeWeatherDetails:)
    @NSManaged public func removeFromWeatherDetails(_ values: NSSet)

}

extension CDWeatherInfo : Identifiable {

}
