//
//  DotnetNewBinding.swift
//  NewBinding
//
//  Created by .NET MAUI team on 6/18/24.
//

import Foundation
import SwiftUI
import UIKit

@objc(DotnetRoomPlanBinding)
public class DotnetRoomPlanBinding: NSObject {

    @objc
    @MainActor public static func presentModalScanningView() async -> URL? {
        return await withCheckedContinuation { continuation in

            let captureController = RoomCaptureController()
            let modalVC =
                UIHostingController(
                    rootView: NavigationStack {
                        ScanningView {
                            value in continuation.resume(returning: value)
                        }
                        .environmentObject(captureController)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity))

            modalVC.modalPresentationStyle = .pageSheet

            if let rootVC = UIApplication.shared.firstKeyWindow?
                .rootViewController
            {
                rootVC.present(modalVC, animated: true, completion: nil)
            }
        }
    }

    @objc
    @MainActor public static func presentModalQuickLookView(usdzFile: URL) {
        let modalVC =
            UIHostingController(
                rootView: NavigationStack {
                    USDZViewer(usdzFile: usdzFile)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity))

        modalVC.modalPresentationStyle = .pageSheet

        if let rootVC = UIApplication.shared.firstKeyWindow?.rootViewController
        {
            rootVC.present(modalVC, animated: true, completion: nil)
        }
    }

}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?.keyWindow

    }
}
