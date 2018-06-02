#import <Cocoa/Cocoa.h>


@interface CWBDemoDelegate: NSObject <NSApplicationDelegate>

	@property IBOutlet NSWindow *window;
	@property IBOutlet NSButton *customCloseButton;
	@property IBOutlet NSButton *customMinimizeButton;
	@property IBOutlet NSButton *customZoomButton;

@end

@implementation CWBDemoDelegate

	- (void)applicationDidFinishLaunching: (NSNotification *)notification {

		//	The following three sets of two lines each hook up arbitrary pre-existing buttons from the nib as the window's close, minimize, and zoom buttons. If your window supports modern-era fullscreen mode, you should also hook up the window's accessibilityFullScreenButton property (subrole: NSAccessibilityFullScreenButtonSubrole) and then decide whether to zoom or switch to fullscreen based on modifier state.

		//	You can also create your buttons in code. Just make sure you follow these two crucial steps for each window button:
		//		1) Set the button's accessibility subrole (e.g., NSAccessibilityZoomButtonSubrole)
		//		2) Make the window aware of the button's special meaning via the window's corresponding accessibility property (e.g., accessibilityZoomButton)

		//	All of this is based on the NSAccessibility protocol family, which is available on macOS 10.10 and up. If you have to support older macOS versions, have a look at this repository's "deprecated" branch, which demonstrates the old and painfully convoluted way of achieving the same thing.

		self.customCloseButton.accessibilitySubrole = NSAccessibilityCloseButtonSubrole;
		self.window.accessibilityCloseButton = self.customCloseButton;

		self.customMinimizeButton.accessibilitySubrole = NSAccessibilityMinimizeButtonSubrole;
		self.window.accessibilityMinimizeButton = self.customMinimizeButton;

		self.customZoomButton.accessibilitySubrole = NSAccessibilityZoomButtonSubrole;
		self.window.accessibilityZoomButton = self.customZoomButton;
	}

	- (BOOL)applicationShouldHandleReopen: (NSApplication *)application hasVisibleWindows: (BOOL)hasVisibleWindows {
		if (hasVisibleWindows) {
			return YES;
		}
		[self.window makeKeyAndOrderFront: self];
		return NO;
	}

	- (IBAction)closeWindow: (id)sender {
		[self.window close];
	}

	- (IBAction)minimizeWindow: (id)sender {
		[self.window miniaturize: sender];
	}

	- (IBAction)zoomWindow: (id)sender {
		[self.window zoom: sender];
	}

@end


@interface CWBDemoWindow: NSWindow

@end

@implementation CWBDemoWindow

	- (BOOL)canBecomeKeyWindow {
		return YES;	//	makes the app set its AXFocusedWindow attribute correctly, which is what Moom uses to find the frontmost window (if your windows shouldn't be key windows, you'll have to set your NSApplication's accessibilityFocusedWindow property manually)
	}

@end


int main(int argc, char *argv[]) {
    return NSApplicationMain(argc, (const char **)argv);
}
