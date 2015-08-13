//
//  testTabBar.m
//  fake_weibo_test_2
//
//  Created by Shall on 15/8/13.
//  Copyright (c) 2015年 Shall. All rights reserved.
//

#import "testTabBar.h"

@interface testTab : TUIControl

@property (nonatomic, assign) CGFloat origialPosition;

@end

@implementation testTab

- (testTabBar *)tabBar {
    return  (testTabBar *)self.superview;
}

- (BOOL)beginTrackingWithEvent:(NSEvent *)event {
    [self setNeedsDisplay];
    self.origialPosition = [self convertPoint:[event locationInWindow] fromView:nil].x;
    return YES;
}

- (BOOL)continueTrackingWithEvent:(NSEvent *)event {
    CGFloat currentPosition = [self convertPoint:[event locationInWindow] fromView:nil].x;
    [TUIView animateWithDuration:0.1 animations:^{
        [TUIView setAnimationCurve:TUIViewAnimationCurveEaseInOut];
        CGRect draggedRect = self.frame;
        draggedRect.origin.x += roundf(currentPosition - self.origialPosition);
        self.frame = draggedRect;
    }];
    
    return YES;
}

- (void)endTrackingWithEvent:(NSEvent *)event {
    CGFloat currentPosition = [self convertPoint:[event locationInWindow] fromView:nil].x;
    if (self.origialPosition == currentPosition) {
        [[self tabBar].delegate tabBar:[self tabBar] didSelectTab:self.tag];
    }
    float originalPoint = self.tag * (self.tabBar.bounds.size.width / self.tabBar.tabViews.count);
    [TUIView animateWithDuration:0.2 animations:^{
        CGRect draggedRect = self.frame;
        draggedRect.origin.x = roundf(originalPoint);
        self.frame = draggedRect;
    }];
    [TUIView animateWithDuration:0.3 animations:^{
        [self redraw];
    }];
}


@end

@interface testTabBar ()

@property (nonatomic, assign) testTabBar *draggingTab;

@end

@implementation testTabBar

@synthesize delegate;
@synthesize tabViews;

- (id)initWithNumberOfTabs:(NSInteger)nTabs {
    if ((self = [super initWithFrame:CGRectZero])) {
        NSMutableArray *_tabViews = [NSMutableArray arrayWithCapacity:nTabs];
        for (int i = 0; i < nTabs; ++i) {
            testTab *t = [[testTab alloc] initWithFrame:CGRectZero];
            t.tag = i;
            t.layout = ^(TUIView *v) {
                CGRect b = v.superview.bounds;
                float width = (b.size.width / nTabs);
                float x = i * width;
                return CGRectMake(roundf(x), 0, roundf(width), b.size.height);
            };
            [self addSubview:t];
            [_tabViews addObject:t];
            
        }
        tabViews = [[NSArray alloc] initWithArray:_tabViews];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGRect b = self.bounds;
    CGContextRef ctx = TUIGraphicsGetCurrentContext();
    CGFloat colorA[] = { 0.85, 0.85, 0.85, 1.0};
    CGFloat colorB[] = { 0.71, 0.71, 0.71, 1.0};
    
    CGContextDrawLinearGradientBetweenPoints(ctx, CGPointMake(0, b.size.height), colorA, CGPointMake(0, 0), colorB);
    
    CGContextSetRGBFillColor(ctx, 1, 1, 1, 0.5);
    CGContextFillRect(ctx, CGRectMake(0, b.size.height-2, b.size.width, 1));
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.3);
    CGContextFillRect(ctx, CGRectMake(0, b.size.height-1, b.size.width, 1));
}



















@end
