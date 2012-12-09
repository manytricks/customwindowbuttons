#import "PMCustomWindowButtonsWindow.h"


@implementation PMCustomWindowButtonsWindow

	@synthesize customCloseButton;
	@synthesize customMinimizeButton;
	@synthesize customZoomButton;

	- (id)accessibilityAttributeValue: (NSString*)theAttributeName {
		if ([theAttributeName isEqualToString: NSAccessibilityCloseButtonAttribute]) {
			return self.customCloseButton;
		}
		if ([theAttributeName isEqualToString: NSAccessibilityMinimizeButtonAttribute]) {
			return self.customMinimizeButton;
		}
		if ([theAttributeName isEqualToString: NSAccessibilityZoomButtonAttribute]) {
			return self.customZoomButton;
		}
		return [super accessibilityAttributeValue: theAttributeName];
	}

	- (BOOL)accessibilityIsAttributeSettable: (NSString*)theAttributeName {
		return ((([theAttributeName isEqualToString: NSAccessibilityPositionAttribute] || [theAttributeName isEqualToString: NSAccessibilitySizeAttribute]) && [self.customZoomButton isEnabled]) || [super accessibilityIsAttributeSettable: theAttributeName]);	// if there's an enabled zoom button, the window's dimensions should be settable regardless of whether the window's style mask contains NSResizableWindowMask
	}

	- (void)accessibilitySetValue: (id)theValue forAttribute: (NSString*)theAttributeName {
		if ([theAttributeName isEqualToString: NSAccessibilitySizeAttribute] && [self accessibilityIsAttributeSettable: theAttributeName] && (floor(NSAppKitVersionNumber)>NSAppKitVersionNumber10_6)) {
			NSSize theNewSize = [theValue sizeValue];
			NSSize theMinimumSize = [self minSize];
			NSSize theMaximumSize = [self maxSize];
			if (theNewSize.width<theMinimumSize.width) {
				theNewSize.width = theMinimumSize.width;
			} else if (theNewSize.width>theMaximumSize.width) {
				theNewSize.width = theMaximumSize.width;
			}
			if (theNewSize.height<theMinimumSize.height) {
				theNewSize.height = theMinimumSize.height;
			} else if (theNewSize.height>theMaximumSize.height) {
				theNewSize.height = theMaximumSize.height;
			}
			NSRect theFrame = [self frame];
			theFrame.size = theNewSize;
			[self setFrame: theFrame display: YES];	// on Lion, we have to set the size manually to get the window to work with Moom's grid resizing, for instance -- this is a regression from Snow Leopard, where overriding -accessibilitySetValue:forAttribute: wasn't necessary
		} else {
			[super accessibilitySetValue: theValue forAttribute: theAttributeName];
		}
	}

	- (void)customClose: (id)sender {
		[self close];
	}

	- (void)customMiniaturize: (id)sender {
		[self miniaturize: sender];
	}

	- (void)customZoom: (id)sender {
		NSScreen *theScreen = [self screen];
		if (theScreen) {
			[self setFrame: [theScreen visibleFrame] display: YES animate: YES];
		}
	}

	- (BOOL)canBecomeMainWindow {
		return YES;
	}

	- (BOOL)canBecomeKeyWindow {
		return YES;
	}

	- (void)dealloc {
		[customCloseButton release];
		[customMinimizeButton release];
		[customZoomButton release];
		[super dealloc];
	}

@end
