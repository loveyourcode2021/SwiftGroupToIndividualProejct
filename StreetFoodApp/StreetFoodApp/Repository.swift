//
//  Repository.swift
//  StreetFoodApp
//
//  Created by Dong Yeol Lee on 2021-04-01.
//
import UIKit
import CoreData
import Foundation

class Repository {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var foodTruck:[FoodTruck]?
    var vendors: [String: FoodTruckAPI] = [:]
    
    func seedData(){
        let networker = Networker.shared
        
        networker.getFoodTruck{ (vendors, error) -> (Void) in
            if let _ = error {
              print("error")
              return
            }
            
            guard let vendors = vendors else {
                print("error foodtrucks are not foodtruck")
                return
            }
            self.vendors = vendors
            
            // reload the collection view
            DispatchQueue.main.async {
                for (_, foodtruck) in self.vendors {

                    let temp_truck = FoodTruck(context: self.context)
                    
                    let long = foodtruck.last?.longitude ?? 0.0
                    let lat = foodtruck.last?.latitude ?? 0.0
                    print(long,lat)
                    if let phone = foodtruck.phone {
                        temp_truck.phoneNumber = phone
                    }
                    if let description = foodtruck.description {
                        temp_truck.truckDescription = description
                    }
                    if let url = foodtruck.url {
                        temp_truck.website = url
                    }
                    if let email = foodtruck.email {
                        temp_truck.email = email
                    }
                    
                    temp_truck.foodTruckID = foodtruck.identifier
                    temp_truck.latitude = String(format: "%f", lat)
                    temp_truck.longitude = String(format: "%f", long)
                    temp_truck.name = foodtruck.name
                    temp_truck.operating = false
                    
                    
                    self.foodTruck?.append(temp_truck)
                    
                    try! self.context.save()
                }
            }
            
        }
      
    }
    
    
    func deleteData() {
        let appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodTruck")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                }
            }
        } catch let error as NSError {
            print("Deleted all my data in myEntity error : \(error) \(error.userInfo)")
        }
    }

  


    //after fetching the api pass data into here
    //upload them into sqlite
    func fetchFoodtruck() -> [FoodTruck] {
        do{
            let request = FoodTruck.fetchRequest() as NSFetchRequest<FoodTruck>
            self.foodTruck  = try! context.fetch(request)
            print("fechting and counting")
            print(self.foodTruck?.count)
            print("fetching is done")
            return self.foodTruck!
          
        }
        catch {
            print("could not fetch data")
        }
    }
}
