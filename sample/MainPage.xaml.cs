using Foundation;

namespace MauiSample;

public partial class MainPage : ContentPage
{
	public MainPage()
	{
		InitializeComponent();
    }

	async void OnDocsButtonClicked(object sender, EventArgs e)
	{
		var result = await RoomPlanScanner.RoomScanner.ScanRoomAsync();

		if (result != null)
		{
			RoomPlanScanner.RoomScanner.ShowScannedRoom(result);
		}
	}
}
