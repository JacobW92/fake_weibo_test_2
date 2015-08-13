//
//  testSectionHeader.m
//  fake_weibo_test_2
//
//  Created by Shall on 15/8/13.
//  Copyright (c) 2015年 Shall. All rights reserved.
//
#import "testSectionHeader.h"

@implementation testSectionHeader

@synthesize labelRenderer = _laberRenderer;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        _laberRenderer = [[TUITextRenderer alloc] init];
        self.textRenderers = [NSArray arrayWithObjects:_laberRenderer, nil];
        self.opaque = TRUE;
    }
    return self;
}

- (void)headerWillBecomeUnpinned {
    self.opaque = TRUE;
    [super headerWillBecomeUnpinned];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef g;
    if ((g = TUIGraphicsGetCurrentContext()) != nil) {
        [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithGraphicsPort:g flipped:FALSE]];
        if (!self.pinnedToViewport) {
            [[NSColor whiteColor] set];
            NSRectFill(self.bounds);
        }
        
        NSColor *start = [NSColor colorWithCalibratedRed:0.8 green:0.8 blue:0.8 alpha:0.9];
        NSColor *end = [NSColor colorWithCalibratedRed:0.9 green:0.9 blue:0.9 alpha:0.9];
        NSGradient *gradient = nil;
        
        gradient = [[NSGradient alloc] initWithStartingColor:start endingColor:end];
        [gradient drawInRect:self.bounds angle:90];
        
        [[start shadowWithLevel:0.1] set];
        NSRectFill(NSMakeRect(0, 0, self.bounds.size.width, 1));
        
        CGFloat labelHeight = 18;
        self.labelRenderer.frame = CGRectMake(15, roundf((self.bounds.size.height - labelHeight) / 2.0), self.bounds.size.width - 30, labelHeight);
        [self.labelRenderer draw];
    }
    
}













@end
