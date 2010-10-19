//
//  KeyboardShuffleAppDelegate.m
//  KeyboardShuffle
//
//  Created by Nate Stedman on 10/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "KeyboardShuffleAppDelegate.h"

@implementation KeyboardShuffleAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	appleScript = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                      pathForResource:
                                                      @"SetKeyboard"
                                                      ofType:@"as"]
                                            encoding:NSUTF8StringEncoding
                                               error:nil];
    NSArray* layouts = [NSArray arrayWithObjects:
                        @"Dvorak", @"U.S.", @"Colemak", nil];
    
    srand(time(NULL));
    
    NSString* layout = nil;
    
    while (1) {
        NSString* oldLayout = layout;
        do {
            layout = [layouts objectAtIndex:rand() % [layouts count]];
        } while (layout == oldLayout);
        
        NSString* replacedAppleScript = [appleScript
                                         stringByReplacingOccurrencesOfString:
                                         @"@LAYOUT@"
                                         withString:layout];
        
        NSAppleScript* script = [[NSAppleScript alloc]
                                 initWithSource:replacedAppleScript];
        
        sleep(5 * 60 + rand() % (60 * 60));
        
        NSString* warning = [NSString
                             stringWithFormat:@"say %@ incoming!", layout];
        system([warning cStringUsingEncoding:NSUTF8StringEncoding]);
        sleep(5);
        
        [script executeAndReturnError:nil];
        [[NSSound soundNamed:@"Glass"] play];
    }
}

@end
