//
//  RokuMenu.h
//  HTMenulet
//
//  Created by Zaid Kokaja on 12/10/14.
//  Copyright (c) 2014 Zaid Kokaja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppMenu.h"

#define POST_KEYPRESS @"/keypress/"
#define POST_KEYCHAR @"/keypress/Lit_"
#define POST_LAUNCH @"/launch/"
#define GET_APPS @"/query/apps"

#define DEFUALT_PORT 8060
#define ROKU_KEY_RIGHT @"Right"
#define ROKU_KEY_LEFT @"Left"
#define ROKU_KEY_DOWN @"Down"
#define ROKU_KEY_SELECT @"Select"
#define ROKU_KEY_HOME @"Home"
#define ROKU_KEY_BACK @"Back"

@interface RokuMenu : NSObject <AppMenu>


@end
