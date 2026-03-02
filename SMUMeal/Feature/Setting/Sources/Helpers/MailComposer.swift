//
//  MailComposer.swift
//  Settings
//
//  Created by 김진혁 on 2/15/26.
//

import SwiftUI
import MessageUI

internal struct MailComposer: UIViewControllerRepresentable {
    let recipients: [String]
    let subject: String
    let body: String?
    
    @Environment(\.dismiss) private var dismiss
    
    
    internal init(recipients: [String], subject: String, body: String?) {
        self.recipients = recipients
        self.subject = subject
        self.body = body
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(recipients)
        vc.setSubject(subject)
        if let body { vc.setMessageBody(body, isHTML: false) }
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator { Coordinator(dismiss: dismiss) }
    
    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        private let dismiss: DismissAction
        init(dismiss: DismissAction) { self.dismiss = dismiss }
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            dismiss()
        }
    }
}
