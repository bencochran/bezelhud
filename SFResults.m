//
//  SFResults.m
//  SilverFlow
//
//  Created by Julius Eckert on 26.01.08.
//  Copyright 2008 Julius Eckert. All rights reserved.
//

#import "SFResults.h"


#define COLUMNID_TYPE		@"TypeColumn"
#define COLUMNID_NAME		@"NameColumn"
#define COLUMNID_RANK	 	@"RankColumn"
#define COLUMNID_HASCHILDREN	@"hasChildren"
#define COLUMNID_EQUIV	 	@"EquivColumn"

@implementation SFResults

- (id)init {
	self = [self initWithWindowNibName:@"ResultWindow"];
	if (self) {
		focus = nil;
		loadingIcons = NO;
		loadingChildIcons = NO;
		iconTimer = nil;
		childrenLoadTimer = nil;
		selectedItem = nil;
		loadingRange = NSMakeRange(0, 0);
		scrollViewTrackingRect = 0;
		//[self setSplitLocation];
	}
	return self;
}

-(void) refreshColors {
	[resultTable setValue:[NSColor colorWithDeviceRed:0.1 green:0.1 blue:0.1 alpha:1.0] forKey:@"backgroundColor"];
	[resultTable setValue:[NSColor colorWithDeviceRed:0.23 green:0.47 blue:0.74 alpha:1.0] forKey:@"highlightColor"];
}

- (void)windowDidBecomeKey:(NSNotification *)notification {
	[self refreshColors];
}

- (void)windowDidLoad {
	[super windowDidLoad];
	[self refreshColors];
	
	[splitView setDividerStyle:NSSplitViewDividerStyleThin];

	[searchStringField setValue:[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1.0] forKey:@"textColor"];
	[[self window] setOpaque:false];
	
	// setup table
	//[resultTable setRowHeight:35];
	SFObjectCell* objectCell = [[[SFObjectCell alloc] init] autorelease];
	NSTableColumn* tableColumn = [resultTable tableColumnWithIdentifier: COLUMNID_NAME];
	[tableColumn setDataCell:objectCell];
	
	tableColumn = [resultTable tableColumnWithIdentifier: COLUMNID_RANK];
	
	SFRankCell* rankCell = [[[SFRankCell alloc] init] autorelease];
	[tableColumn setDataCell:rankCell];
	
	arrow = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleWithIdentifier:@"com.blacktree.Quicksilver.BezelHUD"] pathForResource:@"ChildArrowWhite" ofType:@"png"]];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	if (tableView == resultTable && (NSInteger)[[self currentResults] count] > row) {
		QSObject *thisObject = [[self currentResults] objectAtIndex:row];
		
		if ([[tableColumn identifier] isEqualToString: COLUMNID_HASCHILDREN]) {
			
			return([thisObject hasChildren] ?arrow :nil);
		}
	}
	return [super tableView:tableView objectValueForTableColumn:tableColumn row:row];
}


@end
