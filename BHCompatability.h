//
//  BHCompatability.h
//  BezelHUD
//
//  Created by Ben Cochran on 7/23/11.
//  Copyright 2011 Ben Cochran. All rights reserved.
//

#ifndef BezelHUD_BHCompatability_h
#define BezelHUD_BHCompatability_h

#define BHLeopardOrLater (NSClassFromString(@"NSCollectionView") != nil)
#define BHSnowLeopardOrLater (NSClassFromString(@"NSRunningApplication") != nil)

#endif
