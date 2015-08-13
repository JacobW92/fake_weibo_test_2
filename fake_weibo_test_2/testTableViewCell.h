//
//  testTableViewCell.h
//  fake_weibo_test_2
//
//  Created by Shall on 15/8/13.
//  Copyright (c) 2015年 Shall. All rights reserved.
//

#import "TUIKit.h"

@interface testTableViewCell : TUITableViewCell {
    TUITextRenderer *textRenderer;
}

@property (nonatomic, copy) NSAttributedString *attributeedString;
@property (nonatomic, strong) TUIView *textFieldContainer;

@end
