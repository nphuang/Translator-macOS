//
//  ContentView.swift
//  macTranslator
//
//  Created by 黃鵬軒 on 2024/3/31.
//

import SwiftUI
import HotKey
struct ContentView: View {
    @State var showingPanel = false
    let hotkey = HotKey(key: .backslash, modifiers: [.command])
    var body: some View {
        VStack {
            Button("Present panel") {
                showingPanel.toggle()
            }
            .floatingPanel(isPresented: $showingPanel, content: {
                VisualEffectView(material: .sidebar, blendingMode: .behindWindow, state: .active, emphasized: true)
            })
            .onAppear {
                hotkey.keyDownHandler = {
                    showingPanel.toggle()
                }
            }
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

