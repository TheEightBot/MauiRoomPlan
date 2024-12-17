//
//  RoomCaptureController.swift
//  Roomscanner
//
//  Created by Mikael Deurell on 2022-07-14.
//

import Foundation
import Observation
import RoomPlan

@Observable
class RoomCaptureController: RoomCaptureViewDelegate,
    RoomCaptureSessionDelegate, ObservableObject
{
    var roomCaptureView: RoomCaptureView
    var exportUrl: URL?

    var sessionConfig: RoomCaptureSession.Configuration
    var finalResult: CapturedRoom?

    private var continuation: CheckedContinuation<CapturedRoom, Never>?

    init() {
        roomCaptureView = RoomCaptureView(
            frame: CGRect(x: 0, y: 0, width: 42, height: 42))
        sessionConfig = RoomCaptureSession.Configuration()
        roomCaptureView.captureSession.delegate = self
        roomCaptureView.delegate = self
    }

    func startSession() {
        roomCaptureView.captureSession.run(configuration: sessionConfig)
    }

    func stopSession() async {
        await roomCaptureView.captureSession.stop()
    }

    func captureView(
        shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?
    ) -> Bool {
        return true
    }

    func captureView(didPresent processedResult: CapturedRoom, error: Error?) {
        finalResult = processedResult
        continuation?.resume(returning: finalResult!)
        continuation = nil
    }

    func stopSessionAndExport() async -> URL? {
        await roomCaptureView.captureSession.stop()

        let localFinalResult =
            await withCheckedContinuation { continuation in
                if let finalResult = finalResult {
                    continuation.resume(returning: finalResult)
                } else {
                    self.continuation = continuation
                }
            }

        let epochTime = Int(Date().timeIntervalSince1970)

        // Create the filename using the epoch time
        let filename = "scan_\(epochTime).usdz"

        exportUrl = FileManager.directoryUrl()!.appending(path: filename)

        do {
            try localFinalResult.export(to: exportUrl!, exportOptions: .mesh)
            print("Exported usdz scan to \(exportUrl!.path)")
        } catch {
            print(
                "Error exporting usdz scan to \(exportUrl!.path)")
            return nil
        }
        return exportUrl
    }

    required init?(coder: NSCoder) {
        fatalError("Not needed.")
    }

    func encode(with coder: NSCoder) {
        fatalError("Not needed.")
    }
}
