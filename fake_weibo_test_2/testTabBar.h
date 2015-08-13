//
//  testTabBar.h
//  fake_weibo_test_2
//
//  Created by Shall on 15/8/13.
//  Copyright (c) 2015年 Shall. All rights reserved.
//

#import "TUIKit.h"

@class testTabBar;

@protocol testTabBarDelegate <NSObject>
@required
- (void)tabBar:(testTabBar *)tabBar didSelectTab:(NSInteger)index;
@end

@interface testTabBar : TUIView {
    
    id<testTabBarDelegate> __unsafe_unretained delegate;
    NSArray *tabViews;
    
}

- (id)initWithNumberOfTabs:(NSInteger)nTabs;

@property (nonatomic, unsafe_unretained) id<testTabBarDelegate> delegate;
@property (nonatomic, readonly) NSArray *tabViews;






@end
