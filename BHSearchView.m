//
//  BHSearchView.m
//  BezelHUD
//
//  Created by Julius Eckert on 27.01.08.
//  Copyright 2008 Julius Eckert. All rights reserved.
//

#import "BHSearchView.h"


@implementation BHSearchView

-(void) awakeFromNib {
	[super awakeFromNib];
	
	resultController = [[SFResults alloc] initWithFocus:self];
}

-(void) setEditorActivated:(bool)active {
	editorActivated =  active;
	[self setNeedsDisplay:true];
}

- (void)drawRect:(NSRect)rect {
	if (!editorActivated) [super drawRect:rect];
}

- (IBAction)showResultView:sender {
	if ([[self window] firstResponder] != self) [[self window] makeFirstResponder:self];
	if ([[resultController window] isVisible]) return;
	
	[[resultController window] setLevel:[[self window] level] +1];
	[[resultController window] setFrameUsingName:@"results" force:YES];
	
	NSRect windowRect = [[resultController window] frame];
	NSRect screenRect = [[[resultController window] screen] frame];
	
	NSPoint resultPoint = [[self window] convertBaseToScreen:[self frame] .origin];
	CGFloat extraHeight = windowRect.size.height-(resultPoint.y-screenRect.origin.y);
	
	if (extraHeight>0) {
		windowRect.origin.y = screenRect.origin.y;
		windowRect.size.height -= extraHeight;
	} else {
		windowRect.origin.y = resultPoint.y-windowRect.size.height-30;//resultsPadding;
	}
	
	windowRect.origin.x = [[self window] frame].origin.x + ([[self window] frame].size.width/2 - windowRect.size.width/2);
	
	//windowRect.origin.y += 1.5;

	windowRect = NSIntersectionRect(windowRect, screenRect);
	[[resultController window] setFrame:windowRect display:NO];
	
	[self updateResultView:sender];
	
	if ([[self controller] respondsToSelector:@selector(searchView:resultsVisible:)])
		[(id)[self controller] searchView:self resultsVisible:YES];
	
	if ([[self window] isVisible]) {
		
		[[resultController window] orderFront:nil];
		[[self window] addChildWindow:[resultController window] ordered:NSWindowAbove];
	}
}	

@end
