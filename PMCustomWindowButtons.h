#import <Cocoa/Cocoa.h>


// remember to set the class of mock standard window buttons' cells to this in Interface Builder

@interface PMCustomWindowButtonCell: NSButtonCell

@end


// prototype: never instantiate this class directly

@interface PMCustomWindowButtonPrototype: NSButton

	- (NSArray*)extendedAccessibilityAttributeNames: (NSArray*)theAttributeNames;
	- (id)extendedAccessibilityAttributeValue: (NSString*)theAttributeName;
	- (NSNumber*)extendedAccessibilityIsAttributeSettable: (NSString*)theAttributeName;

@end


// use the following classes for your custom window buttons

@interface PMCustomWindowCloseButton: PMCustomWindowButtonPrototype

@end


@interface PMCustomWindowMinimizeButton: PMCustomWindowButtonPrototype

@end


@interface PMCustomWindowZoomButton: PMCustomWindowButtonPrototype

@end
