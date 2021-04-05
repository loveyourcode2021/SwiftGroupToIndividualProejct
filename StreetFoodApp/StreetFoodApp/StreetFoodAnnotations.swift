//
//  StreetFoodAnnotations.swift
//  StreetFoodApp
//
//  Created by Dong Yeol Lee on 2021-04-03.
//
import UIKit
import Foundation
import CoreLocation
/*
 *
 let name: String
 let last: LastLocation?
 let phone: String?
 let url: String?
 let description: String?
 let identifier: String
 let email: String?
 init(coordinate:CLLocationCoordinate2D, title: String?, subtitle:String?, email:String?, phone:String?, url:String?){
 */
class StreetFoodAnnotations{
    var annotations1:[StreetFoodAnnotation] = []
    var annotations:[PizzaAnnotation] = []
    let repo = Repository()
    init(){
        testAnnotation()
        realData()
    }
    
    func realData(){
        let records = repo.fetchFoodtruck()
        print("Starting appending \(records.count)")
        for r in records
        {
            var location = CLLocationCoordinate2D(latitude: (r.latitude! as NSString).doubleValue, longitude: (r.longitude! as NSString).doubleValue)
            print("long =>\(location.latitude) \(location.longitude) ")
            if location.latitude  == 0.0 || location.longitude == 0.0{
                print("i was here")
                continue
            }
            
            
            annotations1.append(StreetFoodAnnotation(coordinate: location, title: r.name, subtitle: r.foodTruckID, email: r.email, phone: r.phoneNumber, url: r.website))
        }
        print("appending done")
    }
    func testAnnotation(){
        //fake starting
        var annotation = PizzaAnnotation( coordinate: CLLocationCoordinate2DMake(49.2864661 , -123.113481), title: "Pizza Margherita", subtitle: "Street Food Nationalized")
        //annotation.pizzaPhoto = #imageLiteral(resourceName: "Naples")
        annotation.deliveryRaidus = 30.0
        annotation.historyText = "Street Food Nationalized - The legend goes that King Umberto and Queen Margherita of Italy got tired of the royal food, which was always French. Looking for both something new and something Italian, in Naples they ordered a local pizzeria to make them pizza, which was up till then poor people's food.  The Queen loved a pizza of tomatoes, fresh mozzarella and basil so much the restaurant named the pizza after her. That the pizza was the colors of the Italian flag may not be a coinicidence. To this day to sell a true Neapolitan pizza, you must be certified by an association of pizza restaurants in Naples for the process and quality of ingredients."
        self.annotations.append(annotation)
        
        //New York
        annotation = PizzaAnnotation( coordinate: CLLocationCoordinate2DMake(49.2864661 , -123.113481), title: "New York Pizza", subtitle: "Pizza Comes to America")
        //annotation.pizzaPhoto = #imageLiteral(resourceName: "New York")
        annotation.deliveryRaidus = 30.0
        annotation.historyText = "The first known Pizza restaurant in the United States was in New York’s Little Italy. Gennaro Lombardi in 1905 opened his restaurant, but used a coal oven instead of a traditional wood burning oven, since coal was cheaper than wood in New York. New York Pizza breaks several traditions from its Italian ancestor. Most importantly it is sold in large slices, which meant whole pizzas were made larger than the traditional 14inch/35cm diameter. To make a larger pizza, a  higher gluten recipe is used for the crust, and the pizza is tossed in the air with a spinning motion to expand."
        annotations.append(annotation)
        
        //Chicago
        annotation = PizzaAnnotation( coordinate: CLLocationCoordinate2DMake(49.2864661 , -123.113481), title: "Chicago Deep Dish", subtitle: "No more flat crusts")
        //annotation.pizzaPhoto = #imageLiteral(resourceName: "Chicago")
        annotation.historyText = " In 1943, Ike Sewell changed the crust from the thin flatbread to a deep pan, adding traditional Italian/New York  ingredients. Sewell and his cook and eventual manager Rudy Malnati added a layer of sausage to the pan. Some believe the longer cooking time of 20 minutes to 45 minutes of the deep dish meant more beverage consumption, and a higher profit for the restaurant. Deep dish pizza caught on in Chicago, with many competitors in the area. With the 2 inch of deeper pizza crust, the order of ingredients can change between competitors, with a crust ranging in texture from cracker like to bread like and the cheese on top or on the sauce on top."
        annotations.append(annotation)
        
      
    }
}
