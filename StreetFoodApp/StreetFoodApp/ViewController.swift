//
//  ViewController.swift
//  StreetFoodApp
//
//  Created by Dong Yeol Lee on 2021-03-22.
//

import UIKit
import CoreData
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var coordinate2D = CLLocationCoordinate2DMake(40.8367321, 14.2468856)
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var repo = Repository()
    var camera  = MKMapCamera()
    var heading = 0.0
    var initPosition  = CLLocation(latitude: 49.28242, longitude:-123.119187)
   

    func setupCoreLocation(){
        switch CLLocationManager.authorizationStatus(){
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case . authorizedAlways:
            enableLocationServices()
        default:
            break
        }
        
    }
    
    func enableLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            mapView.setUserTrackingMode(.follow, animated: true)
        }
        if CLLocationManager.headingAvailable(){
            locationManager.startUpdatingHeading()
        }else{
            print("heading not avaiable")
        }
    }
    
    func disableLocationServies(){
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func SetLocation(_ sender: Any) {
        setupCoreLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        mapConfig()
        //set camera near Vancouver
        mapView.centerToLocation(initPosition)
        let region = MKCoordinateRegion(
          center: initPosition.coordinate,
          latitudinalMeters: 50000,
          longitudinalMeters: 60000)
         mapView.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        //wipe out all data
        //repo.deleteData()
        //seed all data from api
        self.repo.seedData()
        self.mapView.addAnnotations(StreetFoodAnnotations().annotations1)
     
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: - Delegates
    //Mark: Annotation delegates
    func mapView(_ mapView:MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView?
    {

        var annotationView = MKAnnotationView()
        guard let annotation = annotation as? StreetFoodAnnotation else {
            return nil
        }
        print("Pizza \(annotation.title)")
        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identfier)  as? MKPinAnnotationView {
            annotationView = dequedView
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identfier)
        }
        //annotationView.pinTintColor = UIColor.blue
        annotationView.image  = UIImage(named: "pizza pin")
        annotationView.canShowCallout = true
        print(annotation.subtitle)
        let paragraph = UILabel()
        paragraph.numberOfLines = 0
        paragraph.font = UIFont.preferredFont(forTextStyle: .caption1)
        paragraph.text = annotation.title
        print("paragraph \(paragraph.text)")
        paragraph.numberOfLines = 1
        paragraph.adjustsFontSizeToFitWidth = true
        annotationView.detailCalloutAccessoryView = paragraph

        annotationView.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "pizza pin"))
        annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vc = AnnotationDetailViewController(nibName: "AnnotationDetailViewController", bundle: nil)

      
        vc.annotation = view.annotation as! StreetFoodAnnotation
        present(vc, animated: true, completion: nil)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading.magneticHeading
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("authorized")
        case .denied, .restricted:
            print("not authorized")
        default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        coordinate2D = location.coordinate
        let speedString = "\(location.speed * 2.23694) mph"
        let headingString = " Heading: \(heading)"
        let courseString = headingString + " at " + speedString
        print(courseString)
        let displayString = "\(location.timestamp) Coord:\(coordinate2D) Alt:\(location.altitude) meters"
        print(displayString)
        let pizzaPin = PizzaAnnotation(coordinate: coordinate2D, title: displayString, subtitle: "")
        updateMapRegion(rangeSpan: 200)
        mapView.addAnnotation(pizzaPin)
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 3000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

private extension ViewController {
    func mapConfig()
    {
        self.locationManager.requestAlwaysAuthorization()

            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }

            mapView.delegate = self
            mapView.mapType = .standard
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true

            if let coor = mapView.userLocation.location?.coordinate{
                mapView.setCenter(coor, animated: true)
            }
   
    }
    
    func updateMapRegion(rangeSpan:CLLocationDistance){
        let region = MKCoordinateRegion(center: coordinate2D, latitudinalMeters: rangeSpan, longitudinalMeters: rangeSpan)
        mapView.region = region
    }
    
    func createAnnotations(locations:[FoodTruck]){
        print("Creation")
        for location in locations {
            //as! Double
            do {
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            var latitude = (location.latitude! as NSString).doubleValue
            var longitude = (location.longitude! as NSString).doubleValue
            if latitude  == 0 || longitude == 0{
                continue
            }
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude , longitude: longitude)
            mapView.addAnnotation(annotation)
            } catch {
                print("faced error on annotaion \(error)")
            }
           
        }

    }

}

