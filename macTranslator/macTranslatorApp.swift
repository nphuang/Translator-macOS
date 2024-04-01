//
//  macTranslatorApp.swift
//  macTranslator
//
//  Created by 黃鵬軒 on 2024/3/31.
//

import SwiftUI
@main
struct macTranslatorApp: App {
    
    var body: some Scene {
        MenuBarExtra("Translator", systemImage: "text.magnifyingglass") {
            ContentView()
        }
        .menuBarExtraStyle(.menu)
        
    }
}

