//
//  OppoUtil.m
//  HTMenulet
//
//  Created by Zaid Kokaja on 11/15/14.
//  Copyright (c) 2014 Zaid Kokaja. All rights reserved.
//

#import "OppoMenu.h"
#import "RequestUtil.h"

#define ACTION_OPPO_ON @"Power"

@implementation OppoMenu

float volumeLevel = 50;

- (id)init
{
    if ((self = [super init]) != nil)
    {
        _port = DEFAULT_PORT;
        
        _oppoInfoItem = [[NSMenuItem alloc] initWithTitle:@"Searching for Oppo" action:nil keyEquivalent:@""];
        [_oppoInfoItem setEnabled:NO];
        
        _oppoPowerItem = [[NSMenuItem alloc] initWithTitle:ACTION_OPPO_ON action:@selector(oppo:) keyEquivalent:@""];
        [_oppoPowerItem setEnabled:NO];
        
        _oppoKeyField = [[NSTextField alloc] init];
        [_oppoKeyField setFrame:NSMakeRect(20, 0, 100, 24)];
        [_oppoKeyField setDelegate:self];
        [_oppoKeyField setPlaceholderString:@"Arrow Keys"];
        
        NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 120, 24)];
        [view addSubview:_oppoKeyField];
        
        _oppoKeyItem = [[NSMenuItem alloc] init];
        [_oppoKeyItem setEnabled:NO];
        [_oppoKeyItem setView:view];
        
        _oppoInputItem = [[NSMenuItem alloc] initWithTitle:@"Input" action:@selector(switchInput:) keyEquivalent:@""];
        [_oppoInputItem setEnabled:NO];
        
        _oppoHomeItem = [[NSMenuItem alloc] initWithTitle:@"Home" action:@selector(home:) keyEquivalent:@""];
        [_oppoHomeItem setEnabled:NO];
        
        _oppoNetflixItem = [[NSMenuItem alloc] initWithTitle:@"Netflix" action:@selector(netflix:) keyEquivalent:@""];
        [_oppoNetflixItem setEnabled:NO];
        
        _oppoVolumeSlider = [[NSSlider alloc] init];
        [_oppoVolumeSlider setFrame:NSMakeRect(20, 0, 100, 24)];
        [_oppoVolumeSlider setMaxValue:100];
        [_oppoVolumeSlider setMinValue:0];
        [_oppoVolumeSlider setFloatValue:volumeLevel];
        [_oppoVolumeSlider setTarget:self];
        [_oppoVolumeSlider setAction:@selector(volChange:)];
        [_oppoVolumeSlider setEnabled:NO];
        
        NSView *volView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 120, 24)];
        [volView addSubview:_oppoVolumeSlider];
        
        _oppoVolumeItem = [[NSMenuItem alloc] init];
        [_oppoVolumeItem setView:volView];
    }
    return self;
}

- (NSArray*) getMenuItems
{    
    return @[_oppoInfoItem, _oppoPowerItem, _oppoInputItem, _oppoHomeItem,
             _oppoNetflixItem, _oppoKeyItem, _oppoVolumeItem];
}

- (void) oppo:(id)sender        { [self sendKey:OPPO_KEY_POWER]; }
- (void) switchInput:(id)sender { [self sendKey:OPPO_KEY_INPUT]; }
- (void) home:(id)sender        { [self sendKey:OPPO_KEY_HOME]; }
- (void) netflix:(id)sender     { [self sendKey:OPPO_KEY_NETFLIX]; }

- (void) volChange:(id)sender
{
    int diff = volumeLevel - [_oppoVolumeSlider floatValue];
    //NSLog(@"%d, %d", (int) volumeLevel, diff);
    
    for (int i=0; i<abs(diff); i++)
    {
        if (diff < 0) [self sendKey:OPPO_KEY_VOL_UP];
        else [self sendKey:OPPO_KEY_VOL_DOWN];
        
        [NSThread sleepForTimeInterval:0.1];
        //NSLog(@"sent");
    }
    
    volumeLevel = [_oppoVolumeSlider floatValue];
}

- (BOOL) control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor
{
    return NO;
}

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector
{
    if (commandSelector == @selector(insertNewline:))
    {
        [self sendKey:OPPO_KEY_SELECT];
        [_oppoKeyField setPlaceholderString:@"Enter"];
    }
    else if (commandSelector == @selector(moveRight:))
    {
        [self sendKey:OPPO_KEY_RIGHT];
        [_oppoKeyField setPlaceholderString:@"Right"];
    }
    else if (commandSelector == @selector(moveLeft:))
    {
        [self sendKey:OPPO_KEY_LEFT];
        [_oppoKeyField setPlaceholderString:@"Left"];
    }
    else if (commandSelector == @selector(moveUp:))
    {
        [self sendKey:OPPO_KEY_UP];
        [_oppoKeyField setPlaceholderString:@"Up"];
    }
    else if (commandSelector == @selector(moveDown:))
    {
        [self sendKey:OPPO_KEY_DOWN];
        [_oppoKeyField setPlaceholderString:@"Down"];
    }
    else if (commandSelector == @selector(deleteBackward:))
    {
        [self sendKey:OPPO_KEY_RETURN];
        [_oppoKeyField setPlaceholderString:@"Back"];
    }
    else
    {
        NSLog(@"unsure %@", NSStringFromSelector(commandSelector));
        return false;
    }
    
    return true;
}

#pragma Commands

- (void) sendKey:(NSString*)key
{
    NSLog(@"Sending %@", key);
    
    NSString *prefix = @"{\"key\":\"";
    NSString *suffix = @"\"}";
    
    NSURLComponents *comps = [[NSURLComponents alloc] init];
    [comps setScheme:@"http"];
    [comps setHost:_host];
    [comps setPort:_port];
    [comps setPath:GET_SENDKEY];
    [comps setQuery:[[prefix stringByAppendingString:key] stringByAppendingString:suffix]];
    
    NSURL *url = [comps URL];
    
    [RequestUtil sendGet:url];
}

#pragma Discovery

- (BOOL) ready
{
    // Actually send a test getfirmware to make sure it's still ready
    return _host != nil;
}

- (void)discover
{
    //_host = @"10.0.0.49";
    //[self oppoFound:_host];
    //if (_host != nil) return;
    
    // TODO: send a sign in
    NSString* urlFormat = [@"http://%@:436" stringByAppendingString:GET_FIRMWARE];
    NSString* net = [self getNetworkIP];
    
    for (int i=2; i<256; i++)
    {
        NSString *ip = [net stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
        
        NSString *url = [NSString stringWithFormat:urlFormat, ip];
        //NSLog(@"%@", url);
        
        // TODO: change to async call or dispatch in another thread
        if ([RequestUtil get:[NSURL URLWithString:url]] != nil)
        {
            NSLog(@"Found an Oppo!");
            _host = ip;
            [self oppoFound:_host];
            break;
        }
    }
}

- (void) oppoFound:(NSString*)host
{
    NSLog(@"Enabling");
    [_oppoInfoItem setTitle:@"Oppo Ready"];
    [_oppoPowerItem setEnabled:YES];
    [_oppoKeyItem setEnabled:YES];
    [_oppoInputItem setEnabled:YES];
    [_oppoHomeItem setEnabled:YES];
    [_oppoNetflixItem setEnabled:YES];
    [_oppoVolumeSlider setEnabled:YES];
}

- (NSString*) getNetworkIP
{
    // 192.168.0.0/16 (192.168.0.0 - 192.168.255.255)
    // 172.16.0.0/12  (172.16.0.0  - 172.31.255.255)
    // 10.0.0.0/8     (10.0.0.0    - 10.255.255.255)
    
    for (NSString* str in [[NSHost currentHost] addresses])
    {
        if ([str hasPrefix:@"192.168.1"]) return @"192.168.1.";
        else if ([str hasPrefix:@"10.0.0"]) return @"10.0.0.";
        else if ([str hasPrefix:@"172.16.0"]) return @"172.16.0.";
    }
    
    return nil;
}

@end
