//
//  testScrollView.m
//  fake_weibo_test_2
//
//  Created by Shall on 15/8/13.
//  Copyright (c) 2015年 Shall. All rights reserved.
//

#import "testScrollView.h"

@implementation testScrollView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [NSColor colorWithCalibratedWhite:0.9 alpha:1.0];
        
        _scrollView = [[TUIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.autoresizingMask = TUIViewAutoresizingFlexibleSize;
        _scrollView.scrollIndicatorStyle = TUIScrollViewIndicatorStyleDark;
        [self addSubview:_scrollView];
        
        TUIImageView *imageView = [[TUIImageView alloc] initWithImage:[NSImage imageNamed:@"large-image"]];
        [_scrollView addSubview:imageView];
        [_scrollView setContentSize:imageView.frame.size];
    }
    return self;
}

@end
