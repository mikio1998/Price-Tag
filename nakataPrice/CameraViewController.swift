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
        let salesCollection = productDB.collection("sales track")

        
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
                        // 1. Extract the price field data. *DONE!*
                        // 2. Add to the sales track DB. *DONE!*
                        if document.exists {
                            
                            let productName = document.get("name") as! String
                            let productBrand = document.get("brand") as! String
                            let productSize = document.get("size") as! String
                            let productColor = document.get("color") as! String
                            let productPrice = document.get("price") as! String
                            let productId = document.get("id") as! String
                            let productQuantity = document.get("quantity") as! Int
                            // Title of alert to show brand and name:
                            let nameBrand = productBrand + "\n" + productName
                            
                            // saleProduct object.
                            // if successful, can be added to Sales Track from Alert button
                            let saleProduct = Product(name: productName, brand: productBrand, size: productSize, color: productColor, price: productPrice, id: productId, quantity: productQuantity)
                            
                            if object.type == AVMetadataObject.ObjectType.ean13
                            {
                                let alert = UIAlertController(title: nameBrand, message: productPrice, preferredStyle: .alert)
                                    // user option 1: Cancel the capture.
                                    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                                
                                    // user option 2: Add it to the Sales track.
                                    // use set, to add to collection called "sales track"
                                    // MARK: TODO: Conditional
                                    // MARK: If already exists, just change the quantity + 1
                                    
                                
                                
                                let salesRef = salesCollection.document("\(saleProduct.id)")
                                
                                salesRef.getDocument { (document, error) in

                                    if let document = document {

                                        // If the documet is already in Sales Track
                                        if document.exists{

                                            print("Document data: \(String(describing: document.data()))")
                                            
                                            // Temporary holder of product quantity
                                            let tempQuantity: Int = document.get("quantity") as! Int

                                            
                                            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (nil) in
                                                productDB.collection("sales track").document("\(objectStringVal)").updateData([
                                                    "quantity" : tempQuantity + 1
                                                ]) { err in
                                                    if let err = err {
                                                        print("Error writing document: \(err)")
                                                    } else {
                                                        print("Document successfully written!")
                                                        // MARK: HERE lol
                                                        // MARK: What to do with this...
                                                        // Nah this resolved, don't worry.

                                                        
                                                    }
                                                }
                                            
                                            }))


                                        // If the document is not yet in Sales Track
                                        } else {
                                            print("Document does not exist, could be added to Sales Track")

                                            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (nil) in
                                                productDB.collection("sales track").document("\(objectStringVal)").setData([
                                                    "name": saleProduct.name,
                                                    "brand": saleProduct.brand,
                                                    "size": saleProduct.size,
                                                    "color": saleProduct.color,
                                                    "price": saleProduct.price,
                                                    "id": saleProduct.id,
                                                    "quantity": saleProduct.quantity

                                                ]) { err in
                                                    if let err = err {
                                                        print("Error writing document: \(err)")
                                                    } else {
                                                        print("Document successfully written!")
                                                    }
                                                }
                                            }))



                                        }
                                        
                                    }
                                }
                                
                                // presenting the alert!
                                self.present(alert, animated: true, completion: nil)
                            }
                                     
                        // If doesn't exist, can't get the Document.
                        } else {
                            let alert = UIAlertController(title: "404", message: "Product not registered.", preferredStyle: .alert)
                            // user option 1: Cancel the capture.
                            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            print("Document does not exist.")
                        }
                    }
                }

                
                
            }
        }
    }

}

