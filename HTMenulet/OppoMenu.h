//
//  OppoUtil.h
//  HTMenulet
//
//  Created by Zaid Kokaja on 11/15/14.
//  Copyright (c) 2014 Zaid Kokaja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "AppDelegate.h"
#import "AppMenu.h"

#define GET_FIRMWARE @"/getmainfirmwareversion"
#define GET_SENDKEY  @"/sendremotekey"
#define GET_SIGNIN   @"/signin"

#define DEFAULT_PORT [NSNumber numberWithInt:436]

#define OPPO_KEY_HOME @"HOM"
#define OPPO_KEY_POWER @"POW"
#define OPPO_KEY_UP @"NUP"
#define OPPO_KEY_DOWN @"NDN"
#define OPPO_KEY_LEFT @"NLT"
#define OPPO_KEY_RIGHT @"NRT"
#define OPPO_KEY_RETURN @"RET"
#define OPPO_KEY_INPUT @"SRC"
#define OPPO_KEY_SELECT @"SEL"
#define OPPO_KEY_NETFLIX @"NFX"
#define OPPO_KEY_VOL_UP @"VUP"
#define OPPO_KEY_VOL_DOWN @"VDN"

@interface OppoMenu : NSObject <AppMenu,NSTextFieldDelegate>

@property NSMenuItem *oppoInfoItem;
@property NSMenuItem *oppoPowerItem;
@property NSMenuItem *oppoKeyItem;
@property NSMenuItem *oppoInputItem;
@property NSMenuItem *oppoHomeItem;
@property NSMenuItem *oppoNetflixItem;
@property NSTextField *oppoKeyField;
@property NSMenuItem *oppoVolumeItem;
@property NSSlider *oppoVolumeSlider;

@property NSString* ip;
@property NSNumber* port;
@property NSString* host;

@end
