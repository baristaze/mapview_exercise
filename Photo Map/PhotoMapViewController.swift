//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Francisco de la Pena on 6/10/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController {
    @IBOutlet var cameraView: UIImageView!
    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraView.layer.cornerRadius = 50
        cameraView.clipsToBounds = true
        cameraView.contentMode = UIViewContentMode.ScaleAspectFill
        
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.41666), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
