//
//  BHCollectingSearchView.m
//  BezelHUD
//
//  Created by Julius Eckert on 27.01.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BHCollectingSearchView.h"
#import "SFResults.h"
//#import "CGSPrivate.h"

#define CGS_EFFECT_DURATION 0.16

@implementation BHCollectingSearchView

-(void) setIsLeftSelector:(bool)isLeftSelector {
	leftSelector = isLeftSelector;
}

-(void) awakeFromNib {
	[super awakeFromNib];
	
	editorActivation = 0;
	resultController = [[SFResults alloc] initWithFocus:self];
}

-(void) editorActivation:(NSInteger)sel {
	editorActivation = sel;
	[self setNeedsDisplay:true];
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
		windowRect.origin.y = resultPoint.y-windowRect.size.height-30;//-resultsPadding;
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

- (void)setFrame:(NSRect)frameRect {
	[super setFrame:frameRect];
	if ([self currentEditor]) {
		NSRect editorFrame = [self frame];
		editorFrame.origin = NSZeroPoint;
		editorFrame = NSInsetRect(editorFrame, 10, 10);
		[[[self currentEditor] enclosingScrollView] setFrame: editorFrame];
		[[self currentEditor] setMinSize:editorFrame.size];
	}
}

- (void)drawRect:(NSRect)rect {
	if ([self currentEditor]) {
		/*
		//[[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0] setFill]; 
		[[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:1.0] setFill];     // #B:BLACK
		NSBezierPath *roundRect = [NSBezierPath bezierPath];
		rect = [self frame];
		rect.origin = NSZeroPoint;
		//[roundRect appendBezierPathWithRoundedRectangle:rect withRadius:8];
		[roundRect appendBezierPathWithRect:rect];        // #B:BLACK
		[roundRect fill];
		
		//[[NSColor blackColor] set];
		[[NSColor whiteColor] set];    // #B:BLACK
		[roundRect stroke];
		 */
	} else {
		if ((editorActivation == 3) && (leftSelector)) return;
		if ((editorActivation == 1) && (!leftSelector)) return;
		[super drawRect:rect];
	}
}


/*
 ----------------------------
 Text Editor stuff
 ----------------------------
 */
-(void) someEffect:(bool)left {
	
	int cgs_handle=-1;
	float duration = CGS_EFFECT_DURATION;
	CGSTransitionSpec spec;
	
	spec.unknown1=0;
	spec.type=CGSFlip;
	if (left)
		spec.option=CGSLeft | (1<<7);
	else
		spec.option=CGSRight | (1<<7);
	spec.backColour=0;
	spec.wid=[[self window] windowNumber];
	
	int cgs= _CGSDefaultConnection();
	
	CGSNewTransition(cgs, &spec, &cgs_handle);
	[[self window] display];
	CGSInvokeTransition(cgs, cgs_handle, duration);
	
	usleep((useconds_t)(1050000*duration));
	
	//	Release our variables
	CGSReleaseTransition(cgs, cgs_handle);
	cgs_handle=0;
	
}


- (void)transmogrifyWithText:(NSString *)string {
	[super transmogrifyWithText:string];
	if ([self currentEditor]) {
		[self setNeedsDisplay:true];
		NSRect fRect = [[[self window] contentView] frame];
		[self setFrame:NSMakeRect(fRect.origin.x+10, fRect.origin.y+10, fRect.size.width-20, fRect.size.height-40)];
		
		NSRect editorFrame = [self frame];
		editorFrame.origin = NSZeroPoint;
		editorFrame = NSInsetRect(editorFrame, 10, 10);
		[[[self currentEditor] enclosingScrollView] setFrame: editorFrame];
		[[self currentEditor] setMinSize:editorFrame.size];
		[[self currentEditor] setTextColor:[NSColor whiteColor]];   // #B:BLACK
		[(NSTextView *)[self currentEditor] setContinuousSpellCheckingEnabled:NO];
		[[self currentEditor] setFont:[NSFont fontWithName:@"Monaco" size:11]];
		[(NSTextView*)[self currentEditor] setInsertionPointColor:[NSColor whiteColor]];
		
		[[[self window] windowController] editorEnabled:self];
	}
	[self someEffect:!leftSelector];
}

- (void)textDidEndEditing:(NSNotification *)aNotification {
	[super textDidEndEditing:aNotification];
	[self setNeedsDisplay:true];
	[self someEffect:leftSelector];
	[[[self window] windowController] editorDisabled];
}

@end
