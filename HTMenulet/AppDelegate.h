//
//  AppDelegate.h
//  HTMenulet
//
//  Created by Zaid Kokaja on 11/15/14.
//  Copyright (c) 2014 Zaid Kokaja. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppMenu.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong) NSStatusItem *statusItem;
@property (strong) NSMenu *menu;

@property (strong) NSMenuItem *quitItem;

@property id<AppMenu> oppo;

@end

