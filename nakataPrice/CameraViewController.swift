//
//  CameraViewController.swift
//  nakataPrice
//
//  Created by Mikio Nakata on 12/15/19.
//  Copyright © 2019 Mikio Nakata. All rights reserved.
//

//  ViewController.swift
//  QR Reader
//
//  Created by Mikio Nakata on 11/29/19.
//  Copyright © 2019 Mikio Nakata. All rights reserved.
// Reference https://www.youtube.com/watch?v=4Zf9dHDJ2yU
//

import UIKit
import AVFoundation
import Firebase
import FirebaseDatabase


class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // Var containing video stream taken from camera device.
    // Basically the layer that displays the camera video for us to see.
    var video = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Understand: sessions, inputs, outputs
        // session has input and output
        // - Session gets raw materials (data) from the input (the camera capture)
        // - Session produces output depending on how we ask it to (qr code read, etc.).
        
        // Creating session
        let session = AVCaptureSession()
        
        // Defining the capture device
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        // Adding the input to the session.
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            //let output = AVCaptureMetadataOutput()
            session.addInput(input)
            //session.addOutput(output)
        }
        catch
        {
            print("Error!")
        }
        
        // Adding the output to the session.
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        // Define the que where output is going to be processed.
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // Define type of output we want (qr code or anything)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.ean13]
        
        // Showing the session being captured to the user. (The camera screen displays)
        video = AVCaptureVideoPreviewLayer(session: session)
        // Frames (fill the whole screen)
        video.frame = view.layer.bounds
        // Now, add this layer to the view.
        view.layer.addSublayer(video)
        
        // Start the session.
        session.startRunning()
        
    }
    
    
    
    // This func is called whenever we have some output...
    // Will process the output.
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        // Create instance of DataBase
        let productDB = Firestore.firestore()
        // Create instance of products collection
        let productCollection = productDB.collection("products")

        
        // check if metadataObjects is not empty
        if metadataObjects != nil && metadataObjects.count != 0
        {
            // take the first element in the array, and cast it as AVMetadataMachineRea...
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                print(object.stringValue!)
                
                // Do this to input into productDocument parameter
                let objectStringVal = object.stringValue!
                
                // Create instance of target document, (Assuming it's in the DB)
                let productDocument = productCollection.document(objectStringVal)

                // Try get the document with object.stringvalue
                productDocument.getDocument { (document, err) in
                    if let document = document {
                        
                        // If get document successfully, then should run.
                        // From here...
                        // 1. Extract the price field data
                        // 2. Maybe add to the sales track.
                        if document.exists {
                            
                            let productName = document.get("name") as! String
                            let productBrand = document.get("brand") as! String
                            //let productSize = document.get("size")
                            //let productColor = document.get("color")
                            
                            let productPrice = document.get("price") as! String
                            
                            let nameBrand = productBrand + "\n" + productName
                            
                            //print(productPrice)
                            
                            if object.type == AVMetadataObject.ObjectType.ean13
                            {
                                let alert = UIAlertController(title: nameBrand, message: productPrice, preferredStyle: .alert)
                                   // user option 1: retake the bar code
                                   alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                                   // user option 2: copy the bar code to clipboard (string value of the object)
                                   alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                                       UIPasteboard.general.string = object.stringValue
                                   }))
                                // presenting the alert!
                                self.present(alert, animated: true, completion: nil)
                            }
                            
                            
                            
                            
                        // If doesn't exist, can't get the Document.
                        } else {
                            print("Document does not exist.")
                        }
                    }
                }
                
                
                
                // find object.stringValue in the DB.
//                productCollection.getDocuments { (document, err) in
//                    // error handle
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                    // Identify the document matching the barcode.
//                    } else {
//                        // Access documents
//                        for document in document!.documents {
//                            print(document.data())
//                            // Find the matching product.
//
//
//                        }
//
//
//                    }
//                }
                
                
                // check if ObjectType is ean13 barcode.
//                if object.type == AVMetadataObject.ObjectType.ean13
//                {
//                    let alert = UIAlertController(title: "BarCode", message: object.stringValue, preferredStyle: .alert)
//                       // user option 1: retake the bar code
//                       alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                       // user option 2: copy the bar code to clipboard (string value of the object)
//                       alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
//                           UIPasteboard.general.string = object.stringValue
//                       }))
//
//                    // presenting the alert!
//                    present(alert, animated: true, completion: nil)
//                }
                
                
                
            }
        }
    }

}

