//
//  SendMail.swift
//  GoogleMapImplementation
//
//  Created by Syed Hasnain on 02/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit

class EMail {
    var reciverEmail = ""
    var emailSubject = ""
    var emailBody = ""
    var emailAttachment = Data()
    var attachmentTitle = ""
    var url = ""
    init(reciverEmail: String, emailSubject: String, emailBody: String, emailAttachment: Data,attachmentTitle: String, url: String) {
        self.reciverEmail = reciverEmail
        self.emailSubject = emailSubject
        self.emailBody = emailBody
        self.emailAttachment = emailAttachment
        self.attachmentTitle = attachmentTitle
        self.url = url
    }
}
