//
//  BHObjectCell.m
//  BezelHUD
//
//  Created by Julius Eckert on 20.01.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BHObjectCell.h"


@implementation BHObjectCell

+ (id)cellWithText:(NSString *)aString {
	BHObjectCell *cell = [[BHObjectCell alloc] initTextCell:aString];
	[cell autorelease];
	return cell;
}

- (id)initTextCell:(NSString *)aString {
	
	if (self = [super initTextCell:aString]) {
		NSFont* font = [NSFont systemFontOfSize:12];
		[self setFont:font];
		[self setTextColor:[NSColor whiteColor]];
		showDetails = YES;
		autosize = YES;
		[self setHighlightsBy:NSChangeBackgroundCellMask];
		// [self setBezelStyle:NSRegularSquareBezelStyle];
		[self setBordered:NO];
		[self setBezeled:NO];
		[self setAlignment:NSCenterTextAlignment];
	}
	return self;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	BOOL isFirstResponder = [[controlView window] firstResponder] == controlView && ![controlView isKindOfClass:[NSTableView class]];
	// BOOL isKey = [[controlView window] isKeyWindow];
	
	/*
	NSColor *fillColor;
	NSColor *strokeColor;
	
	
	//logRect(drawingRect);
	BOOL dropTarget = ([self isHighlighted] && ([self highlightsBy] & NSChangeBackgroundCellMask) && ![self isBezeled]);
	
	if (isFirstResponder) {
		fillColor = [self highlightColor];
		//if (![self isHighlighted]) fillColor = [fillColor colorWithAlphaComponent:(isKey?1.0:0.5)];
	} else {
		fillColor = [[self textColor] colorWithAlphaComponent:0.075];
	}
	
	if (dropTarget) {
		
		fillColor = [fillColor blendedColorWithFraction:0.1 ofColor:[self textColor] ?[self textColor] :[NSColor textColor]];
	}
	strokeColor = [[self textColor] colorWithAlphaComponent:dropTarget?0.4:0.2];
	
	
	
	
	[fillColor setFill];
	[strokeColor setStroke];
	
	
	
	NSBezierPath *roundRect = [NSBezierPath bezierPath];
	if ([self isBezeled]) {
		//NSLog(@"%d", [self highlightsBy]);
		if ([self highlightsBy] || isFirstResponder) {
			QSObject *drawObject = [self representedObject];
			BOOL action = [drawObject respondsToSelector:@selector(argumentCount)];
			int argCount = (action?[(QSAction *)drawObject argumentCount] :0);
			//BOOL indentRight = (indentLeft && [drawObject argumentCount] >1);
			NSRect borderRect = NSInsetRect(cellFrame, 2.25, 2.25);
			[roundRect setLineWidth:1.5];
			[roundRect appendBezierPathWithRoundedRectangle:borderRect withRadius:NSHeight(borderRect) /2 indent:argCount];
			[roundRect fill];
			[roundRect stroke];
		}
	} else if ([self highlightsBy] && (isFirstResponder || [self state]) ) {
		[roundRect appendBezierPathWithRoundedRectangle:cellFrame withRadius:NSHeight(cellFrame) /9];
		[roundRect fill];
		//[roundRect setFlatness:0.0];
		//[roundRect setLineWidth:3.25];
		//[roundRect stroke];
		
	}
	*/
	if (isFirstResponder) 
		[[NSColor colorWithCalibratedRed:0.2 green:0.2 blue:0.2 alpha:0.7] setFill];
	else
		[[NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:0.2] setFill];
	
	NSBezierPath *roundRect = [NSBezierPath bezierPath];
	[roundRect appendBezierPathWithRect:cellFrame];
	[roundRect fill];
	
	[[NSColor colorWithCalibratedRed:0.7 green:0.7 blue:0.7 alpha:0.5] setStroke];
	[roundRect stroke];
	[self drawInteriorWithFrame:[self drawingRectForBounds:cellFrame] inView:controlView];
}

@end
