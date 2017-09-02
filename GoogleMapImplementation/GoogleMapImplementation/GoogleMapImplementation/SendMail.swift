//
//  SendMail.swift
//  GoogleMapImplementation
//
//  Created by Macbook Pro on 02/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit

class EMail {
    var reciverEmail = ""
    var emailSubject = ""
    var emailBody = ""
    var emailAttachment = Data()
    var attachmentTitle = ""
     init(reciverEmail: String, emailSubject: String, emailBody: String, emailAttachment: Data,attachmentTitle: String) {
        self.reciverEmail = reciverEmail
        self.emailSubject = emailSubject
        self.emailBody = emailBody
        self.emailAttachment = emailAttachment
        self.attachmentTitle = attachmentTitle
    }
}
