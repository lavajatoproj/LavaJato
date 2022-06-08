//
//  MapsViewController.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 06/03/22.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class MapsViewController: UIViewController{
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var txtSearch: UITextField!
    
    let locationManager = CLLocationManager()
    var locationValue:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        
        //Configuração adicional após carregar a visualização.
        //Google Maps SDK: COMPASS
        mapView.settings.compassButton = true
        
        //Google Maps SDK: User's Location
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    @IBAction func tappedFilterButton(_ sender: UIButton) {
        print(locationValue)
    }
    
    
    @IBAction func locationTapped(_ sender: Any) {
        gotoPlaces()
        getCurrentLocation()
    }
    
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
      // 1
      let geocoder = GMSGeocoder()

      // 2
      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        guard
          let address = response?.firstResult(),
          let lines = address.lines
          else {
            return
        }

        // 3
          self.locationValue = lines.joined(separator: "\n")

        // 4
        UIView.animate(withDuration: 0.25) {
          self.view.layoutIfNeeded()
        }
      }
    }

    func gotoPlaces() {
        txtSearch.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    func getCurrentLocation() {
        // Pedindo autorização do usuário.
        self.locationManager.requestAlwaysAuthorization()
        
        // Autorização para uso do Google Maps em primeiro plano
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    }
}

extension MapsViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
      reverseGeocode(coordinate: position.target)
    }
}

////extension do LocationManager
extension MapsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
           print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

extension MapsViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(String(describing: place.name))")
        dismiss(animated: true, completion: nil)
        
        self.mapView.clear()
        self.txtSearch.text = place.name
        
        let cord2D = CLLocationCoordinate2D(latitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude))
        
        let marker = GMSMarker()
        marker.position =  cord2D
        marker.title = "Location"
        marker.snippet = place.name
        
        let markerImage = UIImage(named: "icon_offer_pick")!
        let markerView = UIImageView(image: markerImage)
        marker.iconView = markerView
        marker.map = self.mapView
        
        self.mapView.camera = GMSCameraPosition.camera(withTarget: cord2D, zoom: 15)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
