//
//  testVew.m
//  fake_weibo_test_2
//
//  Created by Shall on 15/8/13.
//  Copyright (c) 2015年 Shall. All rights reserved.
//

#import "testVew.h"
#import "testSectionHeader.h"
#import "testTableViewCell.h"

#define Tab_height 60;

@implementation testVew

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [NSColor colorWithCalibratedWhite:0.9 alpha:1.0];
        
        font1 = [NSFont fontWithName:@"HelveticaNeue" size:15];
        font2 = [NSFont fontWithName:@"HelveticaNeue-Bold" size:15];
        
        CGRect b = self.bounds;
        b.origin.y += Tab_height;
        b.size.height -= Tab_height;
        
        _tableView = [[TUITableView alloc ] initWithFrame:b];
        _tableView.alwaysBounceVertical = YES;
        _tableView.autoresizingMask = TUIViewAutoresizingFlexibleSize;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.maintainContentOffsetAfterReload = YES;
        [self addSubview:_tableView];
        
        _tabBar = [[testTabBar alloc] initWithNumberOfTabs:5];
        _tabBar.delegate = self;
        _tabBar.layout = ^(TUIView *v){
            TUIView *superview = v.superview;
            CGRect rect = superview.bounds;
            rect.size.height =Tab_height;
            return rect;
        };
        [self addSubview:_tabBar];
        
        for (TUIView *tabView in _tabBar.tabViews) {
            tabView.backgroundColor = [NSColor clearColor];
            tabView.drawRect = ^(TUIView *v, CGRect rect) {
                CGRect b = v.bounds;
                CGContextRef ctx = TUIGraphicsGetCurrentContext();
                NSImage *image = [NSImage imageNamed:@"clock"];
                CGRect imageRect = ABIntegralRectWithSizeCenteredInRect([image size], b);
                if ([v.nsView isTrackingSubviewOfView:v]) {
                    CGContextSaveGState(ctx);
                    CGImageRef cgImage = [image CGImageForProposedRect:&imageRect context:nil hints:nil];
                    CGContextClipToMask(ctx, CGRectOffset(imageRect, 0, -1), cgImage);
                    
                    CGContextSetRGBFillColor(ctx, 1, 1, 1, 0.5);
                    CGContextFillRect(ctx, b);
                    CGContextRestoreGState(ctx);
                    
                    image = [NSImage tui_imageWithSize:imageRect.size drawing:^(CGContextRef ctx){
                        CGRect r;
                        r.origin = CGPointZero;
                        r.size = imageRect.size;
                        
                        CGContextClipToMask(ctx, r, image.tui_CGImage);
                        CGContextDrawLinearGradientBetweenPoints(ctx, CGPointMake(0, r.size.height), (CGFloat[]){0,0,1,1}, CGPointZero, (CGFloat[]){0,0.6,1,1});
                        NSImage *innerShadow = [image tui_innerShadowWithOffset:CGSizeMake(0, -1) radius:3.0 color:[NSColor blackColor] backgroundColor:[NSColor cyanColor]];
                        CGContextSetBlendMode(ctx, kCGBlendModeOverlay);
                        CGContextDrawImage(ctx, r, innerShadow.tui_CGImage);
                    }];
                }
                
                [image drawInRect:imageRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
                
                TUIAttributedString *s = [TUIAttributedString stringWithString:[NSString stringWithFormat:@"%ld", v.tag]];
                [s ab_drawInRect:CGRectOffset(imageRect, imageRect.size.width, -15)];
            };
        }
        
        NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(20, 180, 91, 22)];
        [textField.cell setUsesSingleLineMode:YES];
        [textField.cell setScrollable:YES];
        
        TUIViewNSViewContainer *textFieldContainer = [[TUIViewNSViewContainer alloc] initWithNSView:textField];
        textFieldContainer.backgroundColor = [NSColor blueColor];
        [self addSubview:textFieldContainer];
    }
    return self;
}

- (void)tabBar:(testTabBar *)tabBar didSelectTab:(NSInteger)index {
    NSLog(@"Selected tab %ld", index);
    if (index == [[tabBar tabViews] count] - 1) {
        NSLog(@"Reload table data");
        [_tableView reloadData];
    }
}

- (void)tableView:(TUITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    NSLog(@"Move dragged row: %@ => %@", fromIndexPath, toIndexPath);
}

- (NSIndexPath *)tableView:(TUITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)fromPath toProposedIndexPath:(NSIndexPath *)proposedPath {
    return proposedPath;
}

- (BOOL)tableView:(TUITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}


- (BOOL)tableView:(TUITableView *)tableView shouldSelectRowAtIndexPath:(NSIndexPath *)indexPath forEvent:(NSEvent *)event {
    switch (event.type) {
        case NSRightMouseDown:
            return NO;
    }
    return YES;
}

- (void)tableView:(TUITableView *)tableView didClickRowAtIndexPath:(NSIndexPath *)indexPath withEvent:(NSEvent *)event {
    if ([event clickCount] == 1) {
        
    }
    
    if (event.type == NSRightMouseUp) {
        
    }
}

- (TUITableViewCell *)tableView:(TUITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    testTableViewCell *cell = reusableTableCellOfClass(tableView, testTableViewCell);
    
    TUIAttributedString *s = [TUIAttributedString stringWithString:[NSString stringWithFormat:@"example cell %d", (int)indexPath.row]];
    s.color = [NSColor blackColor];
    s.font = font1;
    [s setFont:font2 inRange:NSMakeRange(8, 4)];
    cell.attributeedString = s;
    
    return cell;
}

- (TUIView *)tableView:(TUITableView *)tableView headerViewForSection:(NSInteger)section {
    testSectionHeader *view = [[testSectionHeader alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
    TUIAttributedString *title = [TUIAttributedString stringWithString:[NSString stringWithFormat:@"Example Section %d", (int)section]];
    title.color = [NSColor blackColor];
    title.font = font2;
    view.labelRenderer.attributedString = title;
    
    [view setMoveWindowByDragging:YES];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(TUITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(TUITableView *)table numberOfRowsInSection:(NSInteger)section {
    return 25;
}

- (CGFloat)tableView:(TUITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}









@end
