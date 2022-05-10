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
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBAction func locationTapped(_ sender: Any) {
        gotoPlaces()
        getCurrentLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configuração adicional após carregar a visualização.
        //Google Maps SDK: COMPASS
        //seta um botao na parte inferior que centraliza o mapa na localizacão atual
        mapView.settings.compassButton = true
        
        //Google Maps SDK: User's Location
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }

    func gotoPlaces() {
        //solicita que o txtSearch não fique em 1 plano
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
        
        //gerenciando a localização
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

////extension do LocationManager
extension MapsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
           print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

extension MapsViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true, completion: nil)
        
        self.mapView.clear()
        self.txtSearch.text = place.name
        
        let cord2D = CLLocationCoordinate2D(latitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude))
        
        //adicionando o snippet na tela
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
    
    //funcao de tratamento de erros caso o mapa nao responda
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    //funcao para dismiss da tela de pesquisa do mapa
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
