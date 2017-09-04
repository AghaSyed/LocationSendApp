//
//  AlertViewController.swift
//  GoogleMapImplementation
//
//  Created by Syed Hasnain on 02/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit

class AlertViewController: UIAlertController{


    
    static func showSendMailErrorAlert(_ view: UIViewController) {
        let myalert = UIAlertController(title: "Could Not Send Email", message: "You have not attached any image", preferredStyle: UIAlertControllerStyle.alert)
        
        myalert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel")
        })
        
        view.present(myalert, animated: true)
    }
    static func showAlert(titleStr: String, messageStr: String, cancelButtonText: String, submitButtonText: String, viewController: UIViewController, completion: @escaping ((Int, String))->Void) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: submitButtonText, style: .default, handler: {_ in
            completion((1,""))
        }))
        alert.addAction(UIAlertAction(title: cancelButtonText, style: .cancel, handler: {_ in
            completion((0,""))
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    static func showLocationButtonErrorAlert(_ view: UIViewController) {
        let myalert = UIAlertController(title: "Could Not Share", message: "First Set Your Current Location", preferredStyle: UIAlertControllerStyle.alert)
        
        myalert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel")
        })
        
        view.present(myalert, animated: true)
    }
    static func showImagePickerErrorAlert(_ view: UIViewController) {
        let myalert = UIAlertController(title: "Error", message: "Please Try Again Here Some Issue", preferredStyle: UIAlertControllerStyle.alert)
        
        myalert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel")
        })
        
        view.present(myalert, animated: true)
    }
    static func showCameraOpenAlert(_ view: UIViewController, completion: @escaping (Int)-> Void) {
        let alert = UIAlertController(title: "Share", message: "Send Your Location with Your Photo", preferredStyle: .actionSheet)
        let actionOne = UIAlertAction(title: "Send Mail", style: .default) { (action) in
            completion(0)
        }
        let actionTwo = UIAlertAction(title: "Cancel", style: .default) { (action) in
            completion(1)
        }
        
        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        view.present(alert, animated: true, completion: nil)
    }
    static func showEmailsendAlert(_ view: UIViewController) {
        let myalert = UIAlertController(title: "Success", message: "Your Mail is succesfully send", preferredStyle: UIAlertControllerStyle.alert)
        
        myalert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel")
        })
        
        view.present(myalert, animated: true)
    }
}
