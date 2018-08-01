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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            
            var alertController = UIAlertController(title: "Permissão de localização", message: "Necessário permissão para acesso à sua localizacao", preferredStyle: .alert)
            
            var acaoConfiguracoes = UIAlertAction(title: "Abrir configuracoes", style: .default) { (<#UIAlertAction#>) in
                if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString) {
                    
                  //  UIApplication.shared().open( configuracoes as URL )
                }
            }
            
            var acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let localicacaoUsuario: CLLocation = locations.last!
        
        let latitude : CLLocationDegrees = localicacaoUsuario.coordinate.latitude
        let longitude : CLLocationDegrees = localicacaoUsuario.coordinate.longitude
        
        let deltaLatitude: CLLocationDegrees = 0.1
        let deltaLongitude: CLLocationDegrees = 0.1
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpanMake(deltaLatitude, deltaLongitude)
        
        let regiao :MKCoordinateRegion = MKCoordinateRegionMake(localizacao, areaVisualizacao)
        
        mapa.setRegion(regiao, animated: true)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

