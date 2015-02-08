//
//  AppDelegate.m
//  HTMenulet
//
//  Created by Zaid Kokaja on 11/15/14.
//  Copyright (c) 2014 Zaid Kokaja. All rights reserved.
//

#import "AppDelegate.h"
#import "OppoMenu.h"

#define ACTION_QUIT @"Quit"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

#pragma Main

- (void)awakeFromNib
{
    _menu = [[NSMenu alloc] init];
    
    _quitItem = [[NSMenuItem alloc] initWithTitle:ACTION_QUIT action:@selector(terminate:) keyEquivalent:@""];
    
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [_statusItem setHighlightMode:YES];
    [_statusItem setImage:[NSImage imageNamed:@"Star"]];
    [_statusItem setEnabled:YES];
    [_statusItem setAction:@selector(open:)];
    
    
    _oppo = [[OppoMenu alloc] init];
    /*
    NSArray *items = [_oppo getMenuItems];
    
    int i = 0;
    for (; i<items.count; i++)
    {
        [_menu insertItem:items[i] atIndex:i];
    }
    [_menu insertItem:[NSMenuItem separatorItem] atIndex:i++];
    [_menu insertItem:_quitItem atIndex:i++];
    */
    
    [_oppo discover];
}

- (void) open:(id)sender
{
    NSMenu *menu = [[NSMenu alloc] init];
    [menu setAutoenablesItems:NO];
    
    NSArray *items = [_oppo getMenuItems];
    
    int i = 0;
    for (; i<items.count; i++)
    {
        [menu insertItem:items[i] atIndex:i];
    }
    [menu insertItem:[NSMenuItem separatorItem] atIndex:i++];
    [menu insertItem:_quitItem atIndex:i++];
    
    [_statusItem popUpStatusItemMenu:menu];
    
    // Check if apps are ready
}

#pragma Actions 

- (void)terminate:(id)sender
{
    [[NSApplication sharedApplication] terminate:sender];
}

#pragma Unused

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    // Insert code here to tear down your application
}

@end
