//
//  testTableViewCell.m
//  fake_weibo_test_2
//
//  Created by Shall on 15/8/13.
//  Copyright (c) 2015年 Shall. All rights reserved.
//

#import "testTableViewCell.h"

@implementation testTableViewCell

- (id)initWithStyle:(TUITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        textRenderer = [[TUITextRenderer alloc] init];
        self.textRenderers = [NSArray arrayWithObjects:textRenderer, nil];
        
        NSTextField *textField = [[NSTextField alloc] initWithFrame:CGRectMake(20, 180, 91, 22)];
        [textField.cell setUsesSingleLineMode:YES];
        [textField.cell setScrollable:YES];
        
        self.textFieldContainer = [[TUIViewNSViewContainer alloc] initWithNSView:textField];
        self.textFieldContainer.backgroundColor = [NSColor blueColor];
        [self addSubview:self.textFieldContainer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize textFieldSize = self.textFieldContainer.bounds.size;
    CGFloat textFieldLeft = CGRectGetWidth(self.bounds) - textFieldSize.width - 16;
    self.textFieldContainer.frame = CGRectMake(textFieldLeft, 14, textFieldSize.width, textFieldSize.height);
}

- (NSAttributedString *)attributeedString {
    return textRenderer.attributedString;
}

- (void)setAttributeedString:(NSAttributedString *)attributeedString {
    textRenderer.attributedString = attributeedString;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGRect b = self.bounds;
    CGContextRef ctx = TUIGraphicsGetCurrentContext();
    
    if (self.selected) {
        CGContextSetRGBFillColor(ctx, 0.87, 0.87, 0.87, 1);
        CGContextFillRect(ctx, b);
    } else {
        CGContextSetRGBFillColor(ctx, 0.97, 0.97, 0.97, 1);
        CGContextFillRect(ctx, b);
        
        CGContextSetRGBFillColor(ctx, 1, 1, 1, 0.9);
        CGContextFillRect(ctx, CGRectMake(0, b.size.height-1, b.size.width, 1));
        CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.08);
        CGContextFillRect(ctx, CGRectMake(0, 0, b.size.width, 1));
    }
    CGRect textRect = CGRectOffset(b, 15, -15);
    textRenderer.frame = textRect;
    [textRenderer draw];
}







@end
