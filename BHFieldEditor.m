//
//  BHFieldEditor.m
//  BezelHUD
//
//  Created by Julius Eckert on 05.05.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BHFieldEditor.h"


@implementation BHFieldEditor

- (void)drawInsertionPointInRect:(NSRect)rect color:(NSColor *)color
						turnedOn:(BOOL)flag
{
	[self setNeedsDisplayInRect:[self visibleRect]
		  avoidAdditionalLayout:NO];

	[[NSColor whiteColor] set ];
	rect.size.width = 8;
	NSRectFill(rect);
}


- (void) _drawInsertionPointInRect:(NSRect)rect color:(NSColor*)color {
	[[NSColor whiteColor] set ];
	rect.size.width = 8;
	NSRectFill(rect);
}

- (BOOL)shouldDrawInsertionPoint {
	return YES;
}
/**/
@end
