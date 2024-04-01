//
//  ContentView.swift
//  macTranslator
//
//  Created by 黃鵬軒 on 2024/3/31.
//

import SwiftUI
struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isPanelVisible {
                FloatingPanelView(viewModel: viewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.clear)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            viewModel.setupHotKeys()
        }
        
    }
}

struct FloatingPanelView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    let panelColor = Color.gray.opacity(0.5)
    var body: some View {
        VStack(spacing: -10) {
            TextField("Enter text", text: $viewModel.inputText)
                .padding()
                .background(Color.clear)
                .cornerRadius(8)
            
            
            TextEditor(text: $viewModel.translatedText)
                .padding()
                .background(Color.clear)
                .cornerRadius(8)
            
            Spacer()
        }
        .frame(width: 300, height: 200)
        .background(panelColor)
        .cornerRadius(12)
        .padding()
        .onDisappear {
            if let monitor = viewModel.hotKeyMonitor {
                NSEvent.removeMonitor(monitor)
            }
        }
    }
}

class ContentViewModel: ObservableObject {
    @Published var isPanelVisible = true
    @Published var inputText = ""
    @Published var translatedText = ""
    
    var hotKeyMonitor: Any?
    
    func setupHotKeys() {
        let commandKey = NSEvent.ModifierFlags.command.rawValue
        let backslashKey = 0x2A // ASCII code for backslash
        
        // 設置 CMD+\ 的熱鍵
        hotKeyMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.modifierFlags.rawValue & NSEvent.ModifierFlags.deviceIndependentFlagsMask.rawValue == commandKey {
                if event.keyCode == backslashKey {
                    self.isPanelVisible.toggle()
                    return nil
                }
            }
            return event
        }
        
        // 設置 ESC 鍵的熱鍵
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 53 { // ASCII code for ESC key
                self.isPanelVisible = false
                return nil
            }
            return event
        }
    }

    func translate() {
        // 進行翻譯的邏輯
    }
}



#Preview {
    ContentView()
}

