//
//  ViewController.swift
//  OndeEstou
//
//  Created by Tribanco Dev on 01/08/2018.
//  Copyright © 2018 ondeEstou. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var endereco: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var velocidade: UILabel!
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocal = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gerenciadorLocal.delegate = self
        gerenciadorLocal.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocal.requestWhenInUseAuthorization()
        gerenciadorLocal.startUpdatingLocation()
        
        /*let latitude : CLLocationDegrees = -19.965037
        let longitude : CLLocationDegrees = -43.932859
        
        let deltaLatitude: CLLocationDegrees = 0.1
        let deltaLongitude: CLLocationDegrees = 0.1
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude, deltaLongitude)
        
        let regiao :MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao)
        
        mapa.setRegion(regiao, animated: true)
        
        let anotacao = MKPointAnnotation()
        
        //Configurar
        anotacao.coordinate = localizacao
        anotacao.title = "Trabalho"
        anotacao.subtitle = "Local onde trabalho"
        
        mapa.addAnnotation(anotacao)*/
    }
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//
//            let alertController = UIAlertController(title: "Permissão de localização", message: "Necessário permissão para acesso à sua localizacao", preferredStyle: .alert)
//
//            let acaoConfiguracoes = UIAlertAction(title: "Abrir configuracoes", style: .default) { (<#UIAlertAction#>) in
//                if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString) {
//
//                    UIApplication.shared().open( configuracoes as URL )
//                }
//            }
//
//            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
//
//            alertController.addAction(acaoConfiguracoes)
//            alertController.addAction(acaoCancelar)
//
//            present(alertController, animated: true, completion: nil)
//        }
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let localicacaoUsuario: CLLocation = locations.last!
        
        self.latitude.text = String(localicacaoUsuario.coordinate.latitude)
        self.longitude.text = String(localicacaoUsuario.coordinate.longitude)
        if (localicacaoUsuario.speed * 1.6 > 0) {
            self.velocidade.text = String(localicacaoUsuario.speed * 1.6)
        }
        
        let deltaLatitude: CLLocationDegrees = 0.01
        let deltaLongitude: CLLocationDegrees = 0.01
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(localicacaoUsuario.coordinate.latitude, localicacaoUsuario.coordinate.longitude)
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude, deltaLongitude)
        
        let regiao :MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao)
        
        mapa.setRegion(regiao, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(localicacaoUsuario) { (detalhesLocal, erro) in
            if (erro == nil) {
                
                if let dadosLocal = detalhesLocal?.first {
                    var thoroughtfare = ""
                    if dadosLocal.thoroughfare != nil {
                        thoroughtfare = dadosLocal.thoroughfare!
                    }
                    
                    var subThoroughfare = ""
                    if dadosLocal.subThoroughfare != nil {
                        subThoroughfare = dadosLocal.subThoroughfare!
                    }
                    
                    var locality = ""
                    if dadosLocal.locality != nil {
                        locality = dadosLocal.locality!
                    }
                    
                    var subLocality = ""
                    if dadosLocal.subLocality != nil {
                        subLocality = dadosLocal.subLocality!
                    }
                    
                    var postalCode = ""
                    if dadosLocal.postalCode != nil {
                        postalCode = dadosLocal.postalCode!
                    }
                    
                    var country = ""
                    if dadosLocal.country != nil {
                        country = dadosLocal.country!
                    }
                    
                    var administrativeArea = ""
                    if dadosLocal.administrativeArea != nil {
                        administrativeArea = dadosLocal.administrativeArea!
                    }
                    
                    var subAdministrativeArea = ""
                    if dadosLocal.subAdministrativeArea != nil {
                        subAdministrativeArea = dadosLocal.subAdministrativeArea!
                    }
                    
                    self.endereco.text = thoroughtfare + " - "
                                        + subThoroughfare + " - "
                                        + locality + " - "
                                        + country + " - "
                    
                }
                
            } else {
                print (erro)
            }
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

