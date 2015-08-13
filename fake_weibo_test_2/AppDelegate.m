//
//  AppDelegate.m
//  fake_weibo_test_2
//
//  Created by Shall on 15/8/13.
//  Copyright (c) 2015年 Shall. All rights reserved.
//

#import "AppDelegate.h"
#import "testVew.h"
#import "testScrollView.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    CGRect b = CGRectMake(0, 0, 500, 450);
    tableView = [[NSWindow alloc] initWithContentRect:b styleMask:NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask backing:NSBackingStoreBuffered defer:NO];
    [tableView setReleasedWhenClosed:FALSE];
    [tableView setMinSize:NSMakeSize(500, 450)];
    [tableView center];
    
    TUINSView *tuiTableViewContainer = [[TUINSView alloc] initWithFrame:b];
    [tableView setContentView:tuiTableViewContainer];
    testVew *tableTest = [[testVew alloc] initWithFrame:b];
    tuiTableViewContainer.rootView = tableTest;
    
    scrollView = [[NSWindow alloc] initWithContentRect:b styleMask:NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask backing:NSBackingStoreBuffered defer:YES];
    
    [scrollView setReleasedWhenClosed:FALSE];
    [scrollView setMinSize:CGSizeMake(500,450)];
    [scrollView setFrameTopLeftPoint:[tableView cascadeTopLeftFromPoint:CGPointMake(tableView.frame.origin.x, tableView.frame.origin.y + tableView.frame.size.height)]];
    TUINSView *tuiScrollView = [[TUINSView alloc] initWithFrame:b];
    [scrollView setContentView:tuiScrollView];
    testScrollView *scrollTest = [[testScrollView alloc] initWithFrame:b];
    tuiScrollView.rootView = scrollTest;
    
    [self showTableView:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)showTableView:(id)sender {
    [tableView makeKeyAndOrderFront:sender];
}

- (IBAction)showScrollView:(id)sender {
    [tableView makeKeyAndOrderFront:sender];
}







@end
