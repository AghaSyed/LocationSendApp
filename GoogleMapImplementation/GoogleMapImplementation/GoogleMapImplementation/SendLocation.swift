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
                setButtonAlphaValue()
            }
        }else {
           AlertViewController.showSendMailErrorAlert(self)
        }
    }
    
    func configuredMailComposeViewController(imageData: Data) -> MFMailComposeViewController {
       // set Email Data
        emailData = EMail(reciverEmail: "syedhasnain.hussaini@gmail.com", emailSubject: "Send Location", emailBody: "\(LocationManager.shared.currentLocation!)", emailAttachment: imageData, attachmentTitle: "User Image")
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([(emailData.reciverEmail)])
        mailComposerVC.setSubject((emailData.emailSubject))
        mailComposerVC.setMessageBody("Location: \(String(describing: emailData.emailBody)))", isHTML: false)
        mailComposerVC.addAttachmentData((emailData.emailAttachment), mimeType: "image/png", fileName: (emailData.attachmentTitle))
        return mailComposerVC
    }
 /*
    func showSendMailErrorAlert() {
        let myalert = UIAlertController(title: "Could Not Send Email", message: "You have not attached any image", preferredStyle: UIAlertControllerStyle.alert)
        
        myalert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel")
        })
        
        self.present(myalert, animated: true)
    }
    */
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
