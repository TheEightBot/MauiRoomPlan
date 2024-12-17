using System;
using Foundation;
using UIKit;

namespace RoomPlanBindingMaciOS
{
    // @interface DotnetRoomPlanBinding : NSObject
    [BaseType (typeof(NSObject))]
    interface DotnetRoomPlanBinding
    {
        // +(void)presentModalScanningViewWithCompletionHandler:(void (^ _Nonnull)(NSURL * _Nullable))completionHandler;
        [Static]
        [Export ("presentModalScanningViewWithCompletionHandler:")]
        void PresentModalScanningViewWithCompletionHandler (Action<NSUrl> completionHandler);

        // +(void)presentModalQuickLookViewWithUsdzFile:(NSURL * _Nonnull)usdzFile;
        [Static]
        [Export ("presentModalQuickLookViewWithUsdzFile:")]
        void PresentModalQuickLookViewWithUsdzFile (NSUrl usdzFile);
    }
}
