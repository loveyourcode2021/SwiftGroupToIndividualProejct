//
//  StreetFoodAnnotation.swift
//  StreetFoodApp
//
//  Created by Dong Yeol Lee on 2021-04-03.
//

import UIKit
import MapKit
/**
 let name: String
 let last: LastLocation?
 let phone: String?
 let url: String?
 let description: String?
 let identifier: String
 let email: String?
 */
class StreetFoodAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var identfier = "Pin"
    var email: String? = ""
    var phone: String? = "000-000-0000"
    var url:String? = ""
    init(coordinate:CLLocationCoordinate2D, title: String?, subtitle:String?, email:String?, phone:String?, url:String?){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.email = email
        self.phone = phone
        self.url = url
    }
}
