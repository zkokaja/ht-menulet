//
//  AppMenu.h
//  HTMenulet
//
//  Created by Zaid Kokaja on 11/30/14.
//  Copyright (c) 2014 Zaid Kokaja. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppMenu <NSObject>

- (NSArray*) getMenuItems;
- (void) discover;

@end
