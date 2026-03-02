//
//  MealDemoApp.swift
//  MealDemo
//
//  Created by 김진혁 on 2/14/26.
//

import SwiftUI
import Meal
import Repository

@main
struct MealDemoApp: App {
    var body: some Scene {
        WindowGroup {
            MealCarouselView(repository: MockMealRepository()) {
                Text("Settings")
            }
        }
    }
}
