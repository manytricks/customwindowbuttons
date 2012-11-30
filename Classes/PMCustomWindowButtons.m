#import "PMCustomWindowButtons.h"


// accessibility attributes are handled by a given button's cell, actions are handled by the button itself

@implementation PMCustomWindowButtonCell

	- (NSArray*)accessibilityAttributeNames {
		NSArray *theAttributeNames = [super accessibilityAttributeNames];
		id theControlView = [self controlView];
		return ([theControlView respondsToSelector: @selector(extendedAccessibilityAttributeNames:)] ? [theControlView extendedAccessibilityAttributeNames: theAttributeNames] : theAttributeNames);	// ask the cell's control view (i.e., the button) for additional attribute values
	}

	- (id)accessibilityAttributeValue: (NSString*)theAttributeName {
		id theControlView = [self controlView];
		if ([theControlView respondsToSelector: @selector(extendedAccessibilityAttributeValue:)]) {
			id theValue = [theControlView extendedAccessibilityAttributeValue: theAttributeName];
			if (theValue) {
				return theValue;	// if this is an extended attribute value we added, return that -- otherwise, fall back to super's implementation
			}
		}
		return [super accessibilityAttributeValue: theAttributeName];
	}

	- (BOOL)accessibilityIsAttributeSettable: (NSString*)theAttributeName {
		id theControlView = [self controlView];
		if ([theControlView respondsToSelector: @selector(extendedAccessibilityIsAttributeSettable:)]) {
			NSNumber *theValue = [theControlView extendedAccessibilityIsAttributeSettable: theAttributeName];
			if (theValue) {
				return [theValue boolValue];	// same basic strategy we use in -accessibilityAttributeValue:
			}
		}
		return [super accessibilityIsAttributeSettable: theAttributeName];
	}

@end


@implementation PMCustomWindowButtonPrototype

	+ (Class)cellClass {
		return [PMCustomWindowButtonCell class];
	}

	- (NSArray*)extendedAccessibilityAttributeNames: (NSArray*)theAttributeNames {
		return ([theAttributeNames containsObject: NSAccessibilitySubroleAttribute] ? theAttributeNames : [theAttributeNames arrayByAddingObject: NSAccessibilitySubroleAttribute]);	// run-of-the-mill button cells don't usually have a Subrole attribute, so we add that attribute
	}

	- (id)extendedAccessibilityAttributeValue: (NSString*)theAttributeName {
		return nil;
	}

	- (NSNumber*)extendedAccessibilityIsAttributeSettable: (NSString*)theAttributeName {
		return ([theAttributeName isEqualToString: NSAccessibilitySubroleAttribute] ? [NSNumber numberWithBool: NO] : nil);	// make the Subrole attribute we added non-settable
	}

	- (void)accessibilityPerformAction: (NSString*)theActionName {
		if ([theActionName isEqualToString: NSAccessibilityPressAction]) {
			if ([self isEnabled]) {
				[self performClick: nil];
			}
		} else {
			[super accessibilityPerformAction: theActionName];
		}
	}

@end


@implementation PMCustomWindowCloseButton

	- (NSArray*)extendedAccessibilityAttributeNames: (NSArray*)theAttributeNames {
		theAttributeNames = [super extendedAccessibilityAttributeNames: theAttributeNames];
		return ([theAttributeNames containsObject: NSAccessibilityEditedAttribute] ? theAttributeNames : [theAttributeNames arrayByAddingObject: NSAccessibilityEditedAttribute]);	// similarly to the Subrole attribute, run-of-the-mill button cells also don't usually have an Edited attribute, so we have to add that for the close button as well
	}

	- (id)extendedAccessibilityAttributeValue: (NSString*)theAttributeName {
		if ([theAttributeName isEqualToString: NSAccessibilitySubroleAttribute]) {
			return NSAccessibilityCloseButtonAttribute;
		}
		if ([theAttributeName isEqualToString: NSAccessibilityEditedAttribute]) {
			return [NSNumber numberWithBool: [[self window] isDocumentEdited]];
		}
		return nil;
	}

	- (NSNumber*)extendedAccessibilityIsAttributeSettable: (NSString*)theAttributeName {
		return ([theAttributeName isEqualToString: NSAccessibilityEditedAttribute] ? [NSNumber numberWithBool: NO] : [super extendedAccessibilityIsAttributeSettable: theAttributeName]);	// make the Edited attribute we added non-settable
	}

@end


@implementation PMCustomWindowMinimizeButton

	- (id)extendedAccessibilityAttributeValue: (NSString*)theAttributeName {
		return ([theAttributeName isEqualToString: NSAccessibilitySubroleAttribute] ? NSAccessibilityMinimizeButtonAttribute : nil);
	}

@end


@implementation PMCustomWindowZoomButton

	- (id)extendedAccessibilityAttributeValue: (NSString*)theAttributeName {
		return ([theAttributeName isEqualToString: NSAccessibilitySubroleAttribute] ? NSAccessibilityZoomButtonAttribute : nil);
	}

@end
