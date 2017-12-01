//
//  YYActionSheet.h
//  actionSheetDemo
//
//  Created by zouyingying on 2017/11/18.
//  Copyright © 2017年 zouyingying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYActionSheet : UIView


/**
 不需要取消按钮的init

 @param titleView 自定义的titleView,自定义高度
 @return 实例
 */
- (instancetype)initWithoutCancelWithHeaderView:(UIView *)titleView;


/**
 带取消的init

 @param titleView 自定义的titleView,自定义高度
 @param cancelTitle 取消的text 例如：cancel 取消 退出
 @param color cancel按钮的字体颜色
 @param cancelBlock cancel的点击回调
 @return 实例
 */
- (instancetype)initWithHeaderView:(UIView *)titleView
                       cancelTitle:(NSString *)cancelTitle
                       cancelColor:(UIColor *)color
                       cancelBlock:(void(^)(void))cancelBlock;


/**
 添加action的方法

 @param title action的title
 @param color text颜色
 @param action 回调
 */
- (void)addActionWithTitle:(NSString *)title
               titlecColor:(UIColor *)color
                    action:(void(^)(void))action;


/**
 弹出方法

 @param superView superView
 */
- (void)showInView:(UIView *)superView;

@end
