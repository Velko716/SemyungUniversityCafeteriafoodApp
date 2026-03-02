//
//  SettingsDemoApp.swift
//  SettingsDemo
//
//  Created by 김진혁 on 2/14/26.
//

import SwiftUI
import Setting

@main
struct SettingsDemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SettingView()
                    .navigationTitle("Settings Demo")
            }
        }
    }
}
