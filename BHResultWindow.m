//
//  BHResultWindow.m
//  BezelHUD
//
//  Created by Julius Eckert on 05.05.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BHResultWindow.h"

@implementation BHResultWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
	NSWindow* result = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];
	blurFilterR = -1;
	
	[self bind:@"shouldBlur" toObject:[NSUserDefaultsController sharedUserDefaultsController] withKeyPath:@"values.BezelHUD.blur" options:nil];
	
	return result;
}
-(void) applyBlurEffect {	
	//if (!self.shouldBlur) return;
	//if (!SUPPORT_BLURRING) return;
	if (blurFilterR != -1) return;
	
	CGSNewCIFilterByName(_CGSDefaultConnection(), (CFStringRef)@"CIGaussianBlur", &blurFilterR);
	CGSAddWindowFilter(_CGSDefaultConnection(), [self windowNumber], blurFilterR, 12289);
	NSDictionary* dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.5] forKey:@"inputRadius"];
	CGSSetCIFilterValuesFromDictionary(_CGSDefaultConnection(), blurFilterR, dict);
}

-(void) removeBlurEffect {
	if (blurFilterR == -1) return;
	
	CGSRemoveWindowFilter(_CGSDefaultConnection(), [self windowNumber], blurFilterR);
	CGSReleaseCIFilter(_CGSDefaultConnection(), blurFilterR);
	blurFilterR = -1;
}

- (BOOL)shouldBlur { return shouldBlur;  }
- (void)setShouldBlur:(BOOL)blur {
	shouldBlur = blur;
	if (blur)
	{
		[self applyBlurEffect];
	}
	else
	{
		[self removeBlurEffect];
	}
}

@end
