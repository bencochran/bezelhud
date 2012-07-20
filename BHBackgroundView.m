//
//  BHBackgroundView.m
//  BezelHUD
//
//  Created by Julius Eckert on 20.01.08.
//  Copyright 2008 Julius Eckert. All rights reserved.
//

#import "BHBackgroundView.h"


@implementation BHBackgroundView

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


	image_big = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"HUD_Big" ofType:@"png"]];
	image_small = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"HUD_Small" ofType:@"png"]];
}

- (id)initWithFrame:(NSRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self loadImages];
	}
	return self;
}

-(IBAction) buttonClose:(id)sender {
	[[self window] orderOut:self];
}

-(NSTextField*) text_title {
	return text_title;
}

#define BG_RADIUS 7
- (void)drawRect:(NSRect)rect {
	NSRect fullRect = [self convertRect:[self frame] fromView:[self superview]];
	NSBezierPath *cornerEraser;
	
	if (!image1) [self loadImages];
	
	NSRect innerRect = fullRect;
	innerRect.origin.y+=1.3;
	innerRect.size.height-=2.1;
	
	innerRect.origin.x += 1.3;
	innerRect.size.width -= 3.0;
	
	// round rectangle
	cornerEraser = [NSBezierPath bezierPath];
	[cornerEraser appendBezierPathWithRoundedRectangle:innerRect withRadius:BG_RADIUS];
	[cornerEraser addClip];
	
	// black background
	[[NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:0.45] setFill];
	NSRectFill(fullRect);
	
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
	[[NSGraphicsContext currentContext] setShouldAntialias:false];
	
	
	/*
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
	*/
	
	if (fullRect.size.width < 400)
		[image_small drawInRect:fullRect fromRect:rectFromSize([image_small size]) operation:NSCompositeSourceOver fraction:1.0];	
	else
		[image_big drawInRect:fullRect fromRect:rectFromSize([image_big size]) operation:NSCompositeSourceOver fraction:1.0];	
}


@end
