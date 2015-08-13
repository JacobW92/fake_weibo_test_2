//
//  AppDelegate.h
//  fake_weibo_test_2
//
//  Created by Shall on 15/8/13.
//  Copyright (c) 2015年 Shall. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TUIKit.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
    NSWindow    *tableView;
    NSWindow    *scrollView;
    
}

- (IBAction)showTableView:(id)sender;
- (IBAction)showScrollView:(id)sender;


@end

