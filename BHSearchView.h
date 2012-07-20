//
//  BHSearchView.h
//  BezelHUD
//
//  Created by Julius Eckert on 27.01.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SFResults.h"

@interface BHSearchView : QSSearchObjectView {
	bool editorActivated;
}

-(void) setEditorActivated:(bool)active;

@end
