//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Francisco de la Pena on 6/10/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewDelegate, MKMapViewDelegate {
    @IBOutlet var cameraView: UIImageView!
    @IBOutlet var mapView: MKMapView!
    
    var lastSelectedImage: UIImage?
    
    var imagePickerVC = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraView.layer.cornerRadius = 50
        cameraView.clipsToBounds = true
        cameraView.contentMode = UIViewContentMode.ScaleAspectFill
        
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.41666), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        
        mapView.delegate = self
        
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        imagePickerVC.sourceType = UIImagePickerControllerSourceType.PhotoLibrary

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            var originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            var editedImage = info[UIImagePickerControllerEditedImage]as! UIImage
            self.lastSelectedImage = originalImage
            NSLog("here")
            dismissViewControllerAnimated(false, completion: nil)
            performSegueWithIdentifier("addLocationSegue", sender: self)
    }
    
    @IBAction func cameraButtonClicked(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            self.presentViewController(imagePickerVC, animated: false, completion: {
                NSLog("presented camera roll!")
            })
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showPictureSegue" {
            (segue.destinationViewController as! FullSizeImageViewController).image = lastSelectedImage
        } else {
            var vc = segue.destinationViewController as! LocationsViewController
            vc.delegate = self
        }
    }
    
    func onImageSelectedWithLocation(lat:NSNumber, lng:NSNumber) {
        println("location view returned a location")
        
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat.doubleValue, longitude: lng.doubleValue), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        
        
        var locationCoordinate = CLLocationCoordinate2DMake(lat.doubleValue, lng.doubleValue)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = "\(lat), \(lng)"
        mapView.addAnnotation(annotation)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        println("mapView delegate")
        
        let reuseID = "myAnnotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView.canShowCallout = true
            annotationView.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))

            annotationView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIView
        }
        
        if (self.lastSelectedImage != nil) {
            let imageView = annotationView.leftCalloutAccessoryView as! UIImageView
            imageView.image = self.lastSelectedImage!
            // imageView.image = UIImage(named: "coolIcon")
        }
        
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        performSegueWithIdentifier("showPictureSegue", sender: self)
    }
}
