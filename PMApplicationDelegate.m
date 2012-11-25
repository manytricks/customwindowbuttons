#import "PMApplicationDelegate.h"
#import "PMCustomWindowButtons.h"
#import "PMCustomWindowButtonsWindow.h"


@implementation PMApplicationDelegate

	- (void)applicationDidFinishLaunching: (NSNotification*)theNotification {
		// set up a borderless window that's prepared to handle custom window buttons
		PMCustomWindowButtonsWindow *theWindow = [[PMCustomWindowButtonsWindow alloc] initWithContentRect: NSMakeRect(0, 0, 400, 200) styleMask: NSBorderlessWindowMask backing: NSBackingStoreBuffered defer: YES];
		[theWindow setReleasedWhenClosed: YES];
		[theWindow setMovableByWindowBackground: YES];
		[theWindow setHasShadow: YES];
		[theWindow setTitle: @"Test Window"];
		[theWindow center];

		// set up close button
		NSButton *aButton = [[[PMCustomWindowCloseButton alloc] initWithFrame: NSMakeRect(10, 170, 50, 20)] autorelease];
		[aButton setButtonType: NSMomentaryPushInButton];
		[aButton setAutoresizingMask: NSViewMaxXMargin | NSViewMinYMargin];
		[aButton setTitle: @"Close"];
		[aButton setTarget: theWindow];
		[aButton setAction: @selector(customClose:)];
		[[theWindow contentView] addSubview: aButton];
		theWindow.customCloseButton = aButton;	// make the window aware of its custom close button

		// set up minimize button
		aButton = [[[PMCustomWindowMinimizeButton alloc] initWithFrame: NSMakeRect(65, 170, 70, 20)] autorelease];
		[aButton setButtonType: NSMomentaryPushInButton];
		[aButton setAutoresizingMask: NSViewMaxXMargin | NSViewMinYMargin];
		[aButton setTitle: @"Minimize"];
		[aButton setTarget: theWindow];
		[aButton setAction: @selector(customMiniaturize:)];
		[[theWindow contentView] addSubview: aButton];
		theWindow.customMinimizeButton = aButton;	// make the window aware of its custom minimize button

		// set up zoom button
		aButton = [[[PMCustomWindowZoomButton alloc] initWithFrame: NSMakeRect(140, 170, 50, 20)] autorelease];
		[aButton setButtonType: NSMomentaryPushInButton];
		[aButton setAutoresizingMask: NSViewMaxXMargin | NSViewMinYMargin];
		[aButton setTitle: @"Zoom"];
		[aButton setTarget: theWindow];
		[aButton setAction: @selector(customZoom:)];
		[[theWindow contentView] addSubview: aButton];
		theWindow.customZoomButton = aButton;	// make the window aware of its custom zoom button

		// finally, show the window
		[theWindow makeKeyAndOrderFront: self];
	}

	- (BOOL)applicationShouldTerminateAfterLastWindowClosed: (NSApplication*)theApplication {
		return YES;
	}

@end
