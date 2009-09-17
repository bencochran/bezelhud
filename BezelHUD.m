//
//  BezelHUD.m
//  BezelHUD
//
//  Created by Julius Eckert on 20.01.08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//
//  QS Interface template by Vacuous Virtuoso
//

#import <QSEffects/QSWindow.h>
#import <QSInterface/QSSearchObjectView.h>
#import <QSInterface/QSObjectCell.h>

#import "BezelHUD.h"



@implementation BezelHUD

- (id)init {
	return [self initWithWindowNibName:@"BezelHUD"];
}


- (void) windowDidLoad {
	[super windowDidLoad];

	QSWindow *window=(QSWindow *)[self window];

    [[self window] setLevel:NSModalPanelWindowLevel];
    [[self window] setFrameAutosaveName:@"BezelHUDWindow"];

	// If it's off the screen, bring it back in
    [[self window]setFrame:constrainRectToRect([[self window]frame],[[[self window]screen]visibleFrame]) display:NO];


// How much the interface moves when it's showing / hiding
// Tip: set "hide offset" = -"show offset" so the window doesn't gradually get displaced from its original position
	[window setHideOffset:NSMakePoint(0,0)];
	[window setShowOffset:NSMakePoint(0,0)];

	[window setShowEffect:[NSDictionary dictionaryWithObjectsAndKeys:@"QSBingeEffect",@"transformFn",@"show",@"type",[NSNumber numberWithFloat:0.09],@"duration",nil]];
	[window setHideEffect:[NSDictionary dictionaryWithObjectsAndKeys:@"QSShrinkEffect",@"transformFn",@"hide",@"type",[NSNumber numberWithFloat:.13],@"duration",nil]];
	
	// setWindowProperty returns an error, unfortunately... ignore it
	[window setWindowProperty:[NSDictionary dictionaryWithObjectsAndKeys:@"QSExplodeEffect",@"transformFn",@"hide",@"type",[NSNumber numberWithFloat:0.09],@"duration",nil] forKey:kQSWindowExecEffect];

	[dSelector setCell:[BHObjectCell cellWithText:@"BezeHUD"]];
	[aSelector setCell:[BHObjectCell cellWithText:@"BezeHUD"]];
	[iSelector setCell:[BHObjectCell cellWithText:@"BezeHUD"]];

	
    NSArray *theControls=[NSArray arrayWithObjects:dSelector,aSelector,iSelector,nil];
    foreach(theControl,theControls){

		[theControl setPreferredEdge:NSMinYEdge];
		[theControl setResultsPadding:NSMinY([dSelector frame])];

		NSCell *theCell=[theControl cell];
//		[(QSObjectCell *)theCell setTextColor:[NSColor whiteColor]];
//		[(QSObjectCell *)theCell setHighlightColor:[NSColor colorWithCalibratedWhite:0.2 alpha:0.4]];
//		[(QSObjectCell *)theCell setAlignment:NSCenterTextAlignment];
		// If yes, will show info under the title (eg. path)
		[(QSObjectCell *)theCell setShowDetails:NO];

	}
	
	[(BHCollectingSearchView*)dSelector setIsLeftSelector:true];
	[(BHCollectingSearchView*)iSelector setIsLeftSelector:false];
	
	[dSelector setAutoresizingMask:0];
	[aSelector setAutoresizingMask:0];
	[iSelector setAutoresizingMask:0];
	
/* Example bindings. */
/*	[[[self window] contentView] bind:@"highlightColor"
							 toObject:[NSUserDefaultsController sharedUserDefaultsController]
						  withKeyPath:@"values.interface.glassColor"
							  options:[NSDictionary dictionaryWithObject:NSUnarchiveFromDataTransformerName
																  forKey:@"NSValueTransformerName"]];
	[[[self window] contentView] bind:@"borderWidth"
							 toObject:[NSUserDefaultsController sharedUserDefaultsController]
						  withKeyPath:@"values.interface.borderWidth"
							  options:nil];*/
	
// Just a reminder that you can do normal NSWindow-ey things...
//    [[self window]setMovableByWindowBackground:NO];

	[[[self window] contentView] setNeedsDisplay:true];
}

-(void) editorEnabled:(id)sender {
	if (sender == dSelector) {
		[(BHSearchView*)aSelector setEditorActivated:true];
		[(BHCollectingSearchView*)iSelector editorActivation:1];
	} else if (sender == iSelector) {
		[(BHSearchView*)aSelector setEditorActivated:true];
		[(BHCollectingSearchView*)dSelector editorActivation:3];
	}
	[commandView setHidden:true];
}

-(void) editorDisabled {
	[(BHCollectingSearchView*)dSelector editorActivation:0];
	[(BHSearchView*)aSelector setEditorActivated:false];
	[(BHCollectingSearchView*)iSelector editorActivation:0];
	[commandView setHidden:false];
}

- (NSSize)maxIconSize{
    return NSMakeSize(128,128);
}


- (void)showMainWindow:(id)sender{
	if ([[self window]isVisible])[[self window]pulse:self];
	[super showMainWindow:sender];
}

- (void)hideMainWindow:(id)sender{
	[[self window] saveFrameUsingName:@"BezelHUDWindow"];
	[super hideMainWindow:sender];
}

/*
*  If you want an effect such as an animation
*  when the indirect selector shows up,
*  the next three methods are for you to subclass.
*/

- (void)showIndirectSelector:(id)sender{
    [super showIndirectSelector:sender];
}

#define SEL_SPACE 15

- (void)expandWindow:(id)sender{ 
	if ([dSelector currentEditor] || [iSelector currentEditor]) return;
    [super expandWindow:sender];
	NSRect newRect = [[self window] frame];
	newRect.origin.x -= (550- newRect.size.width)/2;
	newRect.size.width = 550;
	
	[[self window] setFrame:newRect display:true animate:true];
	
	if (!([dSelector currentEditor] || [iSelector currentEditor])) {
		NSRect selRect = NSMakeRect(20, 32, 160, 160);
		[dSelector setFrame:selRect];
		selRect.origin.x += 160 + SEL_SPACE;
		[aSelector setFrame:selRect];
		selRect.origin.x += 160 + SEL_SPACE;
		[iSelector setFrame:selRect];
	}
	
	NSRect cmdFrame = [commandView frame];
	cmdFrame.origin.x = newRect.size.width/2 - cmdFrame.size.width/2;
	[commandView setFrame:cmdFrame];
	
	NSTextField* txtTitle = [(BHBackgroundView*)[[self window] contentView] text_title]; 
	NSRect titleRect = [txtTitle frame];
	titleRect.origin.x = newRect.size.width/2 - titleRect.size.width/2; 
	[txtTitle setFrame:titleRect];

	[[[self window] contentView] setNeedsDisplay:true];
}

- (void)contractWindow:(id)sender{
    [super contractWindow:sender];
	NSRect newRect = [[self window] frame];
	newRect.origin.x -= ((550-174) - newRect.size.width)/2;
	newRect.size.width = (550-174);
	[[self window] setFrame:newRect display:true animate:true];

	if (!([dSelector currentEditor] || [iSelector currentEditor])) {
		NSRect selRect = NSMakeRect(20, 32, 160, 160);
		[dSelector setFrame:selRect];
		selRect.origin.x += 160 + SEL_SPACE;
		[aSelector setFrame:selRect];
		selRect.origin.x += 160 + SEL_SPACE;
		[iSelector setFrame:selRect];
	}
	
	NSRect cmdFrame = [commandView frame];
	cmdFrame.origin.x = newRect.size.width/2 - cmdFrame.size.width/2;
	[commandView setFrame:cmdFrame];
	
	NSTextField* txtTitle = [(BHBackgroundView*)[[self window] contentView] text_title]; 
	NSRect titleRect = [txtTitle frame];
	titleRect.origin.x = newRect.size.width/2 - titleRect.size.width/2; 
	[txtTitle setFrame:titleRect];
	
	[[[self window] contentView] setNeedsDisplay:true];
}

// When something changes, update the command string
- (void)firstResponderChanged:(NSResponder *)aResponder{
	[super firstResponderChanged:aResponder];
	[self updateDetailsString];
}
- (void)searchObjectChanged:(NSNotification*)notif{
	[super searchObjectChanged:notif];	
	[self updateDetailsString];
	
	if (([dSelector objectValue]) && ([(QSBasicObject*)[dSelector objectValue] details]))
		[commandView setStringValue:[(QSBasicObject*)[dSelector objectValue] details]];
}

// The method to update the command string
// Get rid of it if you're not having a commandView outlet
-(void)updateDetailsString{
	return;
	NSString *command=[[self currentCommand] description];
	[commandView setStringValue:command?command:@""];
}

// Uncomment if you're having a customize button + pref pane
/*- (IBAction)customize:(id)sender{
	[[NSClassFromString(@"QSPreferencesController") sharedInstance]showPaneWithIdentifier:@"QSFumoInterfacePrefPane"];
}*/


- (void)actionActivate:(id)sender{
	[super actionActivate:sender];
}
- (void)updateViewLocations{
    [super updateViewLocations];
}

@end
