import RoomPlan
import SwiftUI

struct CaptureView: UIViewRepresentable {
    @Environment(RoomCaptureController.self) private var captureController

    func makeUIView(context: Context) -> some UIView {
        captureController.roomCaptureView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct ActivityView: UIViewControllerRepresentable {
    var items: [Any]
    var activities: [UIActivity]? = nil

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<ActivityView>
    ) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: items, applicationActivities: activities)
        return controller
    }

    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: UIViewControllerRepresentableContext<ActivityView>
    ) {}
}

struct ScanningView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(RoomCaptureController.self) private var captureController

    var completionHandler: (URL?) -> Void

    var body: some View {
        @Bindable var bindableController = captureController

        ZStack(alignment: .bottom) {
            CaptureView()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading: Button("Cancel") {
                        Task {
                            await captureController.stopSession()
                            completionHandler(nil)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                )
                .navigationBarItems(
                    trailing: Button("Done") {
                        Task {
                            let exportedUrl =
                                await captureController.stopSessionAndExport()
                            completionHandler(exportedUrl)
                            presentationMode.wrappedValue.dismiss()
                        }

                    }
                )
                .onAppear {
                    captureController.startSession()
                }
        }
    }
}
