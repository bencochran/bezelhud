//
//  BHWindow.h
//  BezelHUD
//
//  Created by Julius Eckert on 05.05.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QSEffects/QSWindow.h>
#import "BHFieldEditor.h"

@interface BHWindow : QSBorderlessWindow {
	BOOL shouldBlur;
	int blurFilter;
	BHFieldEditor* fEditor;
}

- (void)applyBlurEffect;
- (void)removeBlurEffect;
- (BOOL)shouldBlur;
- (void)setShouldBlur:(BOOL)blur;

@end
