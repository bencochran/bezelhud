//
//  BHBackgroundView.h
//  BezelHUD
//
//  Created by Julius Eckert on 20.01.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BHBackgroundView : QSBackgroundView {
	IBOutlet NSTextField* text_title;
	
	NSImage* image1;
	NSImage* image2;
	NSImage* image3;
	NSImage* image4;
	NSImage* image5;
	NSImage* image6;
	NSImage* image7;
	NSImage* image8;
	NSImage* image9;
	
	NSImage* image_big;
	NSImage* image_small;
}

-(NSTextField*) text_title;
-(IBAction) buttonClose:(id)sender;

@end


//@interface NSObject (controller)
//
//-(bool) isInEditorMode;
//-(id) getEditorSender;
//
//@end