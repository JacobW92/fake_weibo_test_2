//
//  testSectionHeader.h
//  fake_weibo_test_2
//
//  Created by Shall on 15/8/13.
//  Copyright (c) 2015年 Shall. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import "TUIKit.h"

@interface testSectionHeader : TUITableViewSectionHeader {
    
    TUITextRenderer *_laberRenderer;
    
}

@property (readonly) TUITextRenderer *labelRenderer;

@end
