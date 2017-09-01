//
//  SendLocation.swift
//  GoogleMapImplementation
//
//  Created by Macbook Pro on 01/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
extension ViewController: MFMailComposeViewControllerDelegate {
    func sendEmai(selectedImage: UIImage) {
        if let imageData = UIImagePNGRepresentation(selectedImage) {
            let mailComposeViewController = configuredMailComposeViewController(imageData: imageData)
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            }
        }else {
            showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController(imageData: Data) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["someone@somewhere.com"])
        mailComposerVC.setSubject("User Location")
        mailComposerVC.setMessageBody("Location: \(String(describing: currentLocation))", isHTML: false)
        mailComposerVC.addAttachmentData(imageData, mimeType: "image/png", fileName: "User Location Attachment")
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let myalert = UIAlertController(title: "Could Not Send Email", message: "You have not attached any image", preferredStyle: UIAlertControllerStyle.alert)
        
        myalert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel")
        })
        
        self.present(myalert, animated: true)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
