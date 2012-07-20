//
//  BHCollectingSearchView.h
//  BezelHUD
//
//  Created by Julius Eckert on 27.01.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BHCollectingSearchView : QSCollectingSearchObjectView {
	
	bool leftSelector;
	NSInteger editorActivation;
}

-(void) setIsLeftSelector:(bool)isLeftSelector;
-(void) editorActivation:(NSInteger)sel;

@end

//@interface NSObject (controller)
//
//-(void) editorEnabled:(id)sender;
//-(void) editorDisabled;
//
//@end