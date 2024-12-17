using System.Diagnostics;
using Foundation;

namespace MauiSample;

[Register("AppDelegate")]
public class AppDelegate : MauiUIApplicationDelegate
{
    protected override MauiApp CreateMauiApp()
    {
        var ma = MauiProgram.CreateMauiApp();
        return ma;
    }
}
