//
//  BHResultWindow.h
//  BezelHUD
//
//  Created by Julius Eckert on 05.05.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QSInterface/QSResultWindow.h>

@interface BHResultWindow : QSResultWindow {
	int blurFilterR;
	BOOL shouldBlur;
}

- (void)applyBlurEffect;
- (BOOL)shouldBlur;
- (void)setShouldBlur:(BOOL)blur;


@end
