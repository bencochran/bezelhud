//
//  SFResultBackgroundView.m
//  SilverFlow
//
//  Created by Julius Eckert on 26.01.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SFResultBackgroundView.h"


@implementation SFResultBackgroundView

-(void) loadImages {
	image1 = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"bg_image1" ofType:@"png"]];
	image2 = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"bg_image2" ofType:@"png"]];
	image3 = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"bg_image3" ofType:@"png"]];
	
	image4 = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"bg_image4" ofType:@"png"]];
	image5 = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"bg_image5" ofType:@"png"]];
	image6 = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"bg_image6" ofType:@"png"]];
	
	image7 = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"bg_image7" ofType:@"tif"]];
	image8 = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"bg_image8" ofType:@"tif"]];
	image9 = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"bg_image9" ofType:@"png"]];
}



#define SF_BG_RADIUS 7
- (void)drawRect:(NSRect)rect {
	[[self window] setOpaque:false];
	[[self window] setBackgroundColor:[NSColor clearColor]];
	
	NSRect fullRect = [self convertRect:[self frame] fromView:[self superview]];
	[[NSColor clearColor] setFill];
	NSRectFill(fullRect);
	
	NSBezierPath *cornerEraser;
	
	NSRect innerRect = fullRect;
	innerRect.origin.y+=1.3;
	innerRect.size.height-=2.1;
	
	innerRect.origin.x += 1.7;
	innerRect.size.width -= 3.4;
	// round rectangle
	cornerEraser = [NSBezierPath bezierPath];
	[cornerEraser appendBezierPathWithRoundedRectangle:innerRect withRadius:SF_BG_RADIUS];
	[cornerEraser addClip];
	
	// black background
	[[NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:0.85] setFill];
	NSRectFill(fullRect);
	
	if (!image1) [self loadImages];
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
	[[NSGraphicsContext currentContext] setShouldAntialias:false];
	
	NSRect topRect, leftTop, middleTop, rightTop;
	NSRect bodyRect, leftBody, middleBody, rightBody;
	NSRect bottomRect, leftBottom, middleBottom, rightBottom;
	
	NSDivideRect(fullRect, &topRect, &bodyRect, 22, NSMaxYEdge);
	NSDivideRect(topRect, &leftTop, &rightTop, 19, NSMinXEdge);
	NSDivideRect(rightTop, &rightTop, &middleTop, 19, NSMaxXEdge);
	
	NSDivideRect(bodyRect, &bottomRect, &bodyRect, 22, NSMinYEdge);
	NSDivideRect(bodyRect, &leftBody, &rightBody, 19, NSMinXEdge);
	NSDivideRect(rightBody, &rightBody, &middleBody, 19, NSMaxXEdge);
	
	NSDivideRect(bottomRect, &leftBottom, &rightBottom, 19, NSMinXEdge);
	NSDivideRect(rightBottom, &rightBottom, &middleBottom, 19, NSMaxXEdge);
	
	[image1 drawInRect:leftTop fromRect:rectFromSize([image1 size]) operation:NSCompositeSourceOver fraction:2.0];	
	[image3 drawInRect:middleTop fromRect:rectFromSize([image3 size]) operation:NSCompositeSourceOver fraction:1.0];	
	[image2 drawInRect:rightTop fromRect:rectFromSize([image2 size]) operation:NSCompositeSourceOver fraction:1.0];	
	
	[image4 drawInRect:leftBody fromRect:rectFromSize([image4 size]) operation:NSCompositeSourceOver fraction:1.0];	
	[image5 drawInRect:middleBody fromRect:rectFromSize([image5 size]) operation:NSCompositeSourceOver fraction:1.0];	
	[image6 drawInRect:rightBody fromRect:rectFromSize([image6 size]) operation:NSCompositeSourceOver fraction:1.0];	
	
	[image7 drawInRect:leftBottom fromRect:rectFromSize([image7 size]) operation:NSCompositeSourceOver fraction:1.0];	
	[image8 drawInRect:middleBottom fromRect:rectFromSize([image8 size]) operation:NSCompositeSourceOver fraction:1.0];	
	[image9 drawInRect:rightBottom fromRect:rectFromSize([image9 size]) operation:NSCompositeSourceOver fraction:1.0];	
	
	[[NSColor colorWithCalibratedRed:.35 green:.35 blue:.36 alpha:.55] setStroke];
	NSBezierPath* theLine = [NSBezierPath bezierPath];
	[theLine moveToPoint:NSMakePoint(3,25)];
	[theLine lineToPoint:NSMakePoint([[self window] frame].size.width-3,25)];
	[theLine stroke];

	[[NSColor colorWithCalibratedRed:.35 green:.35 blue:.36 alpha:.2] setStroke];
	theLine = [NSBezierPath bezierPath];
	[theLine moveToPoint:NSMakePoint(3,24)];
	[theLine lineToPoint:NSMakePoint([[self window] frame].size.width-3,24)];
	[theLine stroke];
	return;

	/*
	// titlebar - white background
	NSRect topRect, bottomRect;
	NSDivideRect(fullRect, &topRect, &bottomRect, 20, NSMaxYEdge);
	[[NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:0.8] setFill];
	NSRectFill(topRect);
	
	// titlebar - white stroke
	cornerEraser = [NSBezierPath bezierPath];
	[cornerEraser appendBezierPathWithRoundedRectangle:NSMakeRect([self frame].origin.x+0.3, [self frame].origin.y-0.2, [self frame].size.width-.6, [self frame].size.height) withRadius:SF_BG_RADIUS];
	
	[[NSColor colorWithCalibratedRed:0.7 green:0.7 blue:0.7 alpha:1] setStroke];
	[cornerEraser setLineWidth:1.3];
	[cornerEraser stroke];
	
	// titleBar - white stroke blend
	NSDivideRect(fullRect, &topRect, &bottomRect, 11, NSMaxYEdge);
	
	NSColor* color1 = [NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:0.8];
	NSColor* color2 = [NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:0.0];
	
	NSGradient* gradient = [[NSGradient alloc] initWithStartingColor:color1 endingColor:color2];
	
	[gradient drawInRect:topRect angle:90];
	
	// titlebar - white stroke rest remove
	NSDivideRect(bottomRect, &topRect, &bottomRect, 10, NSMaxYEdge);
	[[NSColor colorWithCalibratedRed:.25 green:.25 blue:.25 alpha:0.95] setFill];
	NSRectFill(topRect);
	
	// bottom black background BORDER
	NSDivideRect(fullRect, &topRect, &bottomRect, 21, NSMaxYEdge);
	[[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:0.95] setFill];
	NSRectFill(bottomRect);
	
	// bottom black background
	bottomRect.origin.x+=1;
	bottomRect.origin.y +=1;
	bottomRect.size.width -= 2;
	bottomRect.size.height -= 2;
	[[NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:0.85] setFill];
	NSRectFill(bottomRect);

	return;
	
	NSBezierPath *cornerEraser = nil;
	cornerEraser = [NSBezierPath bezierPath];
	[cornerEraser appendBezierPathWithRoundedRectangle:[self frame] withRadius:6];
	[cornerEraser addClip];
	
	[[NSColor colorWithCalibratedRed:0.15 green:0.15 blue:0.15 alpha:.85] set];
	NSRectFill(fullRect);

	[[NSColor colorWithCalibratedRed:0.7 green:0.7 blue:0.7 alpha:1] setStroke];
	if (cornerEraser != nil) 
		[cornerEraser stroke];
	
	NSRect topRect, bottomRect;
	NSDivideRect(fullRect, &topRect, &bottomRect, 10, NSMaxYEdge);
	
	NSColor* color1 = [NSColor colorWithCalibratedRed:0.15 green:0.15 blue:0.15 alpha:.85];
	NSColor* color2 = [NSColor colorWithCalibratedRed:0.15 green:0.15 blue:0.15 alpha:.0];
	
	NSGradient* gradient = [[NSGradient alloc] initWithStartingColor:color1 endingColor:color2];
	
	[gradient drawInRect:topRect angle:90];
	
	[[NSColor colorWithCalibratedRed:0.15 green:0.15 blue:0.15 alpha:.85] set];
	NSRectFill(bottomRect);
	*/
}

@end
