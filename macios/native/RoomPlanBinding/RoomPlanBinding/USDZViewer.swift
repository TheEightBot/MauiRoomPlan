//
//  ARQuicklookView.swift
//  NewBinding
//
//  Created by Michael Stonis on 12/17/24.
//

import SwiftUI
import QuickLook
import RealityKit

struct USDZViewer: View {
    @Environment(\.presentationMode) var presentationMode
    
    let usdzFile: URL
    
    var body: some View {
        VStack {
            Text(usdzFile.lastPathComponent)
                .font(.headline)
            if #available(iOS 18.0, *) {
                RealityView { content in
                    if let model = try? Entity.load(contentsOf: usdzFile) {
                        content.add(model)
                    } else {
                        print("Unable to load USDZ data.")
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                })
    }
}
