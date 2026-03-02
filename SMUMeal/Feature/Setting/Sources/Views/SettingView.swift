//
//  SettingView.swift
//  Settings
//
//  Created by 김진혁 on 1/22/26.
//

import SwiftUI
import MessageUI
import UIComponents

// MARK: - View
public struct SettingView: View {
    @Environment(\.openURL) private var openURL
    
    @State private var viewModel: SettingViewModel = .init()
    @State private var showMail = false
    
    private let developerEmail = "wlsgurrla716@iCloud.com"
    private let mailSubject = "문의 드립니다"
    
    private var appVersion: String {
        (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "-"
    }
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.navy01.ignoresSafeArea()
            
            List {
                Section("설정  (조식 - 8:30, 중식 - 11:00, 석식 - 17:30)") {
                    Button {
                        openURL(URL(string: UIApplication.openSettingsURLString)!)
                    } label: {
                        SettingNavigationRow(label: "알림")
                    }
                    .listRowBackground(Color.gray02)
                }
                .font(.pretendard(size: 14, weight: .bold))
                .foregroundStyle(Color.gray01)
                
                Section("앱 정보") {
                    SettingInfoRow(label: "앱 버전", value: appVersion)
                    .listRowBackground(Color.gray02)
                    
                    Button {
                        viewModel.send(
                            to: developerEmail,
                            subject: mailSubject,
                            body: nil,
                            present: { showMail = true },
                            openURL: { openURL($0) }
                        )
                    } label: {
                        SettingNavigationRow(label: "문의하기")
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.gray02)
                }
                .font(.pretendard(size: 14, weight: .bold))
                .foregroundStyle(Color.gray01)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.insetGrouped)
            .sheet(isPresented: $showMail) {
                MailComposer(
                    recipients: [developerEmail],
                    subject: mailSubject,
                    body: nil
                )
            }
        }
    }
}

#Preview {
    SettingView()
}
