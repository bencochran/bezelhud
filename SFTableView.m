//
//  SFTableView.m
//  BezelHUD
//
//  Created by Julius Eckert on 27.01.08.
//  Copyright 2008 Julius Eckert. All rights reserved.
//

#import "SFTableView.h"


@implementation SFTableView

- (void)highlightSelectionInClipRect:(NSRect)clipRect {
	// 81,133,208    24,70,159
	NSColor* color1 = [NSColor colorWithCalibratedRed:0.32 green:0.52 blue:0.82 alpha:.95];
	NSColor* color2 = [NSColor colorWithCalibratedRed:0.09 green:0.28 blue:0.62 alpha:.95];
	
	NSGradient* gradient = [[NSGradient alloc] initWithStartingColor:color1 endingColor:color2];
	
//	[gradient drawInRect:clipRect angle:90];
	
    NSColor *evenColor, *oddColor = [NSColor colorWithDeviceRed:0.06 green:0.06 blue:0.06 alpha:.85];
	float cellHeight = [self rowHeight]+2;
	NSRect visibleRect = [self visibleRect];
	NSRect highlightRect;
	
	evenColor = [NSColor colorWithCalibratedRed: 0.1 green: 0.1 blue: 0.1 alpha:.85];
 	
	highlightRect.origin = NSMakePoint(NSMinX(visibleRect), (int)(NSMinY(clipRect) / cellHeight) * cellHeight);
	highlightRect.size = NSMakeSize(NSWidth(visibleRect), cellHeight);
 	
	while (NSMinY(highlightRect) < NSMaxY(clipRect)) {
		NSRect clippedHighlightRect = NSIntersectionRect(highlightRect, clipRect);
		int row = (int)((NSMinY(highlightRect) + cellHeight / 2.0) / cellHeight);
		
		if ([self selectedRow] == row) {
			[[NSColor colorWithCalibratedRed:.07 green:.22 blue:.54 alpha:1] setFill];
			NSRectFill(clippedHighlightRect);
			clippedHighlightRect.origin.y += .6;
			clippedHighlightRect.size.height -= 1.2;
			[gradient drawInRect:clippedHighlightRect angle:90];
		} else {
			NSColor *rowColor = (row % 2 == 0) ? evenColor : oddColor;
			[rowColor set];
			NSRectFill(clippedHighlightRect);
		}
		highlightRect.origin.y += cellHeight;
	}
	
	[gradient release];
}

- (void)drawBackgroundInClipRect:(NSRect)clipRect {
	[[self backgroundColor] setFill];
	NSRectFill(clipRect);
}


@end
