//
//  BezelHUD.h
//  BezelHUD
//
//  Created by Julius Eckert on 20.01.08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//
//  QS Interface template by Vacuous Virtuoso
//

#import <Cocoa/Cocoa.h>
#import <QSInterface/QSResizingInterfaceController.h>
#import "BHObjectCell.h"
#import "BHBackgroundView.h"
#import "BHCollectingSearchView.h"
#import "BHSearchView.h"

@interface BezelHUD : QSResizingInterfaceController {
    BOOL lockInCenter;
}

@property (nonatomic, assign) BOOL lockInCenter;

-(void) updateDetailsString;


// ???
//-(bool) isInEditorMode;
//-(id) getEditorSender;

-(void) editorEnabled:(id)sender;
-(void) editorDisabled;

@end