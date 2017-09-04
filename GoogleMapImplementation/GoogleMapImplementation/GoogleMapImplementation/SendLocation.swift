//
//  SendLocation.swift
//  GoogleMapImplementation
//
//  Created by Syed Hasnain on 01/09/2017.
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
           AlertViewController.showSendMailErrorAlert(self)
        }
    }
    
    func configuredMailComposeViewController(imageData: Data) -> MFMailComposeViewController {
       // set Email Data
        emailData = EMail(reciverEmail: "syedhasnain.hussaini@gmail.com", emailSubject: "Send Location", emailBody: "\(LocationManager.shared.currentLocation!)", emailAttachment: imageData, attachmentTitle: "User Image", url: "\(LocationManager.shared.baseUrl)\(String(describing: LocationManager.shared.currentLocation!.coordinate.latitude)),\(String(describing: LocationManager.shared.currentLocation!.coordinate.longitude))")
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([(emailData.reciverEmail)])
        mailComposerVC.setSubject((emailData.emailSubject))
    //    mailComposerVC.setMessageBody("Location: \(String(describing: emailData.emailBody)) \nLocation URL: \(emailData.url))", isHTML: false)
        mailComposerVC.setMessageBody("\nLocation URL: \(emailData.url))", isHTML: false)
        mailComposerVC.addAttachmentData((emailData.emailAttachment), mimeType: "image/png", fileName: (emailData.attachmentTitle))
        
        return mailComposerVC
    }

    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        isEmailSend = true
        controller.dismiss(animated: true, completion: nil)
    }
    func emailServiceCheck()  {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
    }
}
