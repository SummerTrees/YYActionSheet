//
//  ViewController.m
//  actionSheetDemo
//
//  Created by zouyingying on 2017/11/18.
//  Copyright © 2017年 zouyingying. All rights reserved.
//

#import "ViewController.h"
#import "YYActionSheet.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *headView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)showSheet:(id)sender {
    
    
    YYActionSheet *optionsView = [[YYActionSheet alloc] initWithHeaderView:self.headView cancelTitle:@"取消" cancelColor:self.view.tintColor cancelBlock:^{
        
    }];
    
    [optionsView addActionWithTitle:@"保留" titlecColor:self.view.tintColor action:^{
        
    }];
    
    [optionsView addActionWithTitle:@"不保留" titlecColor:[UIColor redColor] action:^{
        
    }];
    
    [optionsView showInView:self.view];
}

- (IBAction)sheetWithoutCancel:(id)sender {
    
    YYActionSheet *optionsView = [[YYActionSheet alloc] initWithoutCancelWithHeaderView:self.headView];
    
    [optionsView addActionWithTitle:@"保留" titlecColor:self.view.tintColor action:^{
        
    }];
    
    [optionsView addActionWithTitle:@"不保留" titlecColor:[UIColor redColor] action:^{
        
    }];
    
    [optionsView showInView:self.view];
    
    
}


-  (UIView*)headView {
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 70)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.view.bounds.size.width - 20, 30)];
        titleLabel.text = @"图片来自其他APP,是否保留?";
        titleLabel.font = [UIFont systemFontOfSize:17.0];
        titleLabel.textColor = [UIColor colorWithRed:73/255.0 green:75/255.0 blue:90/255.0 alpha:1];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:titleLabel];
        
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
        descLabel.text = @"路径: 图片/根目录";
        descLabel.textColor = [UIColor lightGrayColor];
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.center = CGPointMake(_headView.center.x - 50, 50);
        [_headView addSubview:descLabel];
        
        UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedButton.frame = CGRectMake(CGRectGetMaxX(descLabel.frame) + 10, 38, 80, 25);
        
        selectedButton.layer.cornerRadius = 5.0;
        selectedButton.layer.borderWidth = 1;
        selectedButton.layer.borderColor = self.view.tintColor.CGColor;
        
        [selectedButton setTitle:@"更改路径" forState:UIControlStateNormal];
        selectedButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [selectedButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        
        [selectedButton addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_headView addSubview:selectedButton];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 69.5, self.view.bounds.size.width - 20, .5)];
        line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [_headView addSubview:line];
    }
    return _headView;
}

- (void)selectedClick:(UIButton *)btn {
    NSLog(@"这里更改路径");
}


@end
