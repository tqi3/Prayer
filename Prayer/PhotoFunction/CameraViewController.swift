//
//  CameraViewController.swift
//  Prayer
//
//  Created by Apple on 2018/11/20.
//  Copyright © 2018 CSC 214. All rights reserved.
//

import UIKit
import CoreLocation

/*
 **  The UIImagePickerControllerDelegate extends the UINavigationControllerDelegate.
 **  When one delegate protocol extends another, it is considered good practice to adopt both.
 */
class CameraViewController: UIViewController, CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var labelLongitude: UILabel!
    @IBOutlet weak var labelLatitude: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var plibrary: PLibrary! {
        didSet{
            if let cv = collectionView {
                 cv.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = NSLocalizedString("str_hello", comment: "")
        labelLatitude.text = NSLocalizedString("str_origin2", comment: "")
        labelLongitude.text = NSLocalizedString("str_origin", comment: "")
        label2.text = NSLocalizedString("str_god", comment: "")
        startButton.setTitle(NSLocalizedString("str_start", comment: ""), for: .normal)
        endButton.setTitle(NSLocalizedString("str_end", comment: ""), for: .normal)
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 10
        locationManager.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: " + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            let coordinate = location.coordinate
            labelLongitude.text = NSLocalizedString("str_longitude", comment: "") + coordinate.longitude.description
            labelLatitude.text = NSLocalizedString("str_latitude", comment: "") + coordinate.latitude.description
        }
    }
    
    func missingPermissionsAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: NSLocalizedString("str_ok", comment: ""), style: .cancel)
        let settingsAction = UIAlertAction(title: NSLocalizedString("str_settings", comment: ""), style: .default) { _ in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
        }
        
        alert.addAction(okAction)
        alert.addAction(settingsAction)
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        present(alert, animated: true)
    }
    
    @IBAction func onStartButton(_ sender: Any) {
        switch CLLocationManager.authorizationStatus() {
        case .denied:
            missingPermissionsAlert(title: NSLocalizedString("str_CLNoService", comment: ""),
                                    message: NSLocalizedString("str_CLDeniedPerm", comment: ""))
        case .restricted:
            missingPermissionsAlert(title: NSLocalizedString("str_CLNoService", comment: ""),
                                    message: NSLocalizedString("str_CLBlocked", comment: ""))
        default:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func onEndButton(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        labelLongitude.text = NSLocalizedString("str_origin", comment: "")
        labelLatitude.text = NSLocalizedString("str_origin2", comment: "")
    }
   
    func deletePhotoAlert(title: String, completion: @escaping (UIAlertAction) -> Void) {
        let alertMsg = NSLocalizedString("str_deletePhotoWarning_message", comment: "")
        let alert = UIAlertController(title: NSLocalizedString("str_deletePhotoWarning", comment: ""),
                                      message: alertMsg,
                                      preferredStyle: .actionSheet)
        
        let resetAction = UIAlertAction(title: NSLocalizedString("str_deletePhoto", comment: ""),
                                        style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                         style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(resetAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    
//    // MARK: - Actions
//
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let one =  plibrary?.photosCollection {
            return one.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionReuse", for: indexPath) as! CollectionCell
        if let pht = plibrary?.photosCollection[indexPath.row] {
            cell.imageView?.image = pht
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deletePhotoAlert(title: NSLocalizedString("str_pdTitle", comment: ""), completion: { _ in
            self.plibrary.removePhoto(at: indexPath.row)
            self.collectionView.reloadData()
        })
    }
    
    @IBAction func onCameraBtn(_ sender: UIBarButtonItem) { 
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: NSLocalizedString("str_alertName", comment: ""),
                                           message: NSLocalizedString("str_noCamera", comment: ""),
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("str_ok", comment: ""), style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }


    @IBAction func onLibraryBtn(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            plibrary.addPhoto(image)
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}


