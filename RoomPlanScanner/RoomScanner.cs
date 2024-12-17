using System;

namespace RoomPlanScanner;

public static class RoomScanner
{
    public static async Task<string?> ScanRoomAsync()
    {
#if IOS
        var tcs = new TaskCompletionSource<Foundation.NSUrl?>();

        RoomPlanBindingMaciOS.DotnetRoomPlanBinding.PresentModalScanningViewWithCompletionHandler(x => tcs.SetResult(x));

        var result = await tcs.Task;

        return result?.Path;
#else
        return null;
#endif

    }

    public static void ShowScannedRoom(string modelPath)
    {
#if IOS
        RoomPlanBindingMaciOS.DotnetRoomPlanBinding.PresentModalQuickLookViewWithUsdzFile(NSUrl.CreateFileUrl(modelPath));
#endif
    }
}
