//
//  KeyboardShuffleAppDelegate.m
//  KeyboardShuffle
//
//  Created by Nate Stedman on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "KeyboardShuffleAppDelegate.h"

#import <Carbon/Carbon.h>

@implementation KeyboardShuffleAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    srand(time(NULL));
    
    TISInputSourceRef layout = nil;
    NSDictionary* layoutFilter = [NSDictionary dictionaryWithObject:@"com.apple.keyboardlayout.all"
                                                             forKey:(id)kTISPropertyBundleID];
    NSArray* layouts = (NSArray *)TISCreateInputSourceList((CFDictionaryRef)layoutFilter, false);
    TISInputSourceRef oldLayout = TISCopyCurrentKeyboardLayoutInputSource();
    
    if([layouts count] <= 1)
    {
        NSLog(@"Cannot run; only one keyboard layout enabled!!");
        [NSApp terminate:self];
    }

    while (1) {
        NSString* layoutName;
        NSString* warning;
        
        oldLayout = layout;
        
        do {
            layout = (TISInputSourceRef)[layouts objectAtIndex:rand() % [layouts count]];
        } while (layout == oldLayout);
        
        layoutName = TISGetInputSourceProperty(layout, kTISPropertyLocalizedName);
        warning = [NSString stringWithFormat:@"say %@ incoming!", layoutName];
        
        sleep(5 * 60 + rand() % (60 * 60));
        
        system([warning cStringUsingEncoding:NSUTF8StringEncoding]);
        
        sleep(5);
        
        TISSelectInputSource(layout);
        
        [[NSSound soundNamed:@"Glass"] play];
        
        [warning release];
    }
}

@end
