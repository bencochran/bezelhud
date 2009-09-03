//
//  BHWindow.m
//  BezelHUD
//
//  Created by Julius Eckert on 05.05.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BHWindow.h"
#import "BlurSetting.h"

@implementation BHWindow

-(void) awakeFromNib {
	[super awakeFromNib];
	
	NSLog(@"I'm awake!");
	[self bind:@"shouldBlur" toObject:[NSUserDefaultsController sharedUserDefaultsController] withKeyPath:@"values.BezelHUD.blur" options:nil];

	blurFilter = -1;
	fEditor = nil;
}

-(void) applyBlurEffect {
	
	//if (!self.shouldBlur) return;
	//if (!SUPPORT_BLURRING) return;
	if (blurFilter != -1) return;
	
	CGSNewCIFilterByName(_CGSDefaultConnection(), (CFStringRef)@"CIGaussianBlur", &blurFilter);
	CGSAddWindowFilter(_CGSDefaultConnection(), [self windowNumber], blurFilter, 12289);
	NSDictionary* dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.5] forKey:@"inputRadius"];
	CGSSetCIFilterValuesFromDictionary(_CGSDefaultConnection(), blurFilter, dict);
}

-(void) removeBlurEffect {
	if (blurFilter == -1) return;
	
	CGSRemoveWindowFilter(_CGSDefaultConnection(), [self windowNumber], blurFilter);
	CGSReleaseCIFilter(_CGSDefaultConnection(), blurFilter);
	blurFilter = -1;
}

-(void) makeKeyAndOrderFront:(id)sender {
	[super makeKeyAndOrderFront:sender];
	//[self applyBlurEffect];
}

- (NSTimeInterval)animationResizeTime:(NSRect)newWindowFrame
{
	return 0.05f;
}

//*
-(NSText*) fieldEditor:(BOOL)createWhenNeeded forObject:(id)anObject {
	if (!fEditor) 
		fEditor = [[BHFieldEditor alloc] init];
	//[anObject addSubview:fe];
	return fEditor;
}
/**/

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
