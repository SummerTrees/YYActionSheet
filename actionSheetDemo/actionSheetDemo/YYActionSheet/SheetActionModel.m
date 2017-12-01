//
//  SheetActionModel.m
//  actionSheetDemo
//
//  Created by zouyingying on 2017/11/18.
//  Copyright © 2017年 zouyingying. All rights reserved.
//

#import "SheetActionModel.h"

@implementation SheetActionModel

- (instancetype)initWithTitle:(NSString *)title titlecColor:(UIColor *)color action:(void (^)(void))action {
    if (self = [super init]) {
        _title = title;
        _textColor = color;
        _action = action;
    }
    return self;
}

@end
