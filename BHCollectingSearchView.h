//
//  BHCollectingSearchView.h
//  BezelHUD
//
//  Created by Julius Eckert on 27.01.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QSCollectingSearchObjectView.h"
#import "SFResults.h"


@interface BHCollectingSearchView : QSCollectingSearchObjectView {
	
	bool leftSelector;
	int editorActivation;
}

-(void) setIsLeftSelector:(bool)isLeftSelector;
-(void) editorActivation:(int)sel;

@end

//@interface NSObject (controller)
//
//-(void) editorEnabled:(id)sender;
//-(void) editorDisabled;
//
//@end