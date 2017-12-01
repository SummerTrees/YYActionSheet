//
//  SheetActionModel.h
//  actionSheetDemo
//
//  Created by zouyingying on 2017/11/18.
//  Copyright © 2017年 zouyingying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SheetActionModel : NSObject

/** text */
@property(nonatomic,strong) NSString *title;

/** 颜色 */
@property(nonatomic,strong) UIColor *textColor;

/** 点击回调 */
@property(nonatomic,strong) void(^action)(void);


/**
 SheetActionModel的init方法

 @param title action的title
 @param color title显示的颜色
 @param action 回调
 @return 实例
 */
- (instancetype)initWithTitle:(NSString *)title titlecColor:(UIColor *)color action:(void(^)(void))action;

@end
