//
//  testVew.h
//  fake_weibo_test_2
//
//  Created by Shall on 15/8/13.
//  Copyright (c) 2015年 Shall. All rights reserved.
//

#import "TUIKit.h"
#import "testTabBar.h"

@interface testVew : TUIView<TUITableViewDelegate, TUITableViewDataSource, testTabBarDelegate> {
    
    TUITableView *_tableView;
    testTabBar *_tabBar;
    
    NSFont *font1;
    NSFont *font2;
}

@end
