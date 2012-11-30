#import <Cocoa/Cocoa.h>


@interface PMCustomWindowButtonsWindow: NSWindow

	{
		NSButton *customCloseButton;
		NSButton *customMinimizeButton;
		NSButton *customZoomButton;
	}

	@property (nonatomic, retain) NSButton *customCloseButton;
	@property (nonatomic, retain) NSButton *customMinimizeButton;
	@property (nonatomic, retain) NSButton *customZoomButton;

	- (void)customClose: (id)sender;
	- (void)customMiniaturize: (id)sender;
	- (void)customZoom: (id)sender;

@end
