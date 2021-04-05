//
//  PizzaAnnotation.swift
//  PizzaHistoryMap
//
//  Created by Steven Lipton on 7/18/17.
//  Copyright © 2017 Steven Lipton. All rights reserved.
//

import UIKit
import MapKit

class PizzaAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var identfier = "Pin"
    var historyText = ""
    var pizzaPhoto:UIImage! = nil
    var deliveryRaidus:CLLocationDistance! = nil
    init(coordinate:CLLocationCoordinate2D, title: String?, subtitle:String?){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
