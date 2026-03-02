//
//  SettingViewModel.swift
//  Settings
//
//  Created by 김진혁 on 2/15/26.
//

import Foundation
import MessageUI

@Observable
final class SettingViewModel {
    func send(to email: String,
              subject: String,
              body: String?,
              present: @escaping () -> Void,
              openURL: @escaping (URL) -> Void) {
        if MFMailComposeViewController.canSendMail() {
            present()
        } else if let url = mailtoURL(email: email, subject: subject, body: body) {
            openURL(url)
        }
    }
}

extension SettingViewModel {
    private func mailtoURL(email: String, subject: String, body: String?) -> URL? {
        var comps = URLComponents()
        comps.scheme = "mailto"
        comps.path = email
        
        var items: [URLQueryItem] = [
            .init(name: "subject", value: subject)
        ]
        if let body { items.append(.init(name: "body", value: body)) }
        comps.queryItems = items
        
        return comps.url
    }
}
