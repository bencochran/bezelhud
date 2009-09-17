//
//  SFObjectCell.m
//  SilverFlow
//
//  Created by Julius Eckert on 26.01.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SFObjectCell.h"


@implementation SFObjectCell

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	QSObject *drawObject = [self representedObject];
	
	[self buildStylesForFrame:cellFrame inView:controlView];
		
	if ([drawObject isKindOfClass:[QSNullObject class]]) return;
	if (!drawObject) {
		return;
	}
	
	
	[self drawIconForObject:drawObject withFrame:(NSRect) cellFrame inView:(NSView *)controlView];
	[self drawTextForObject:drawObject withFrame:(NSRect) cellFrame inView:(NSView *)controlView];
}

- (void)buildStylesForFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	NSMutableParagraphStyle *style = [[[NSMutableParagraphStyle alloc] init] autorelease];
	[style setLineBreakMode:NSLineBreakByTruncatingTail];
	[style setFirstLineHeadIndent:1.0];
	[style setHeadIndent:1.0];
	[style setAlignment:[self alignment]];

	NSColor *mainColor = [NSColor whiteColor];
	NSColor *fadedColor = [mainColor colorWithAlphaComponent:0.80];
	
	[nameAttributes release];
	nameAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
					  [NSFont fontWithName:[[self font] fontName] size:MIN([[self font] pointSize] , NSHeight(cellFrame) *1.125*2/3) -1] , NSFontAttributeName,
					  mainColor, NSForegroundColorAttributeName,
					  style, NSParagraphStyleAttributeName,
					  nil];
	
	[detailsAttributes release];
	detailsAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
						 [NSFont fontWithName:[[self font] fontName] size:[[self font] pointSize] *5/6] , NSFontAttributeName,
						 fadedColor, NSForegroundColorAttributeName,
						 style, NSParagraphStyleAttributeName,
						 nil];
}


- (void)drawTextForObject:(QSObject *)drawObject withFrame:(NSRect)cellFrame inView:(NSView *)controlView {

	NSString *nameString = nil;
	if (!nameString) nameString = [drawObject label];
	if (!nameString) nameString = [drawObject name];
	if (!nameString) nameString = @"<Unknown>";
	
	//NSSize nameSize = [nameString sizeWithAttributes:nameAttributes];

	NSRect textDrawRect = [self titleRectForBounds:cellFrame];
	
	NSMutableAttributedString *titleString = [[[NSMutableAttributedString alloc] initWithString:nameString?nameString:@"???"] autorelease];
	[titleString setAttributes:nameAttributes range:NSMakeRange(0, [titleString length])];
	
	[titleString addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:-1.0] range:NSMakeRange(0, [titleString length])];

	[[NSColor whiteColor] set];
	NSRect centerRect = rectFromSize([titleString size]);
	centerRect.size.width = NSWidth(textDrawRect);
	centerRect.size.height = MIN(NSHeight(textDrawRect), centerRect.size.height);
	[titleString drawInRect:centerRectInRect(centerRect, textDrawRect)];
}


@end
