//
//  YYActionSheet.m
//  actionSheetDemo
//
//  Created by zouyingying on 2017/11/18.
//  Copyright © 2017年 zouyingying. All rights reserved.
//

#import "YYActionSheet.h"
#import "SheetActionModel.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define Margin 10

@interface YYActionSheet ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView;


@property (nonatomic,   copy) NSString *cancelTitle;
@property (nonatomic,   copy) UIColor *cancelColor;
@property (nonatomic,   copy) void(^cancelBlock)(void);

@property (nonatomic, strong) NSMutableArray *optionsArr;

@end

@implementation YYActionSheet

#pragma mark - init
- (instancetype)initWithoutCancelWithHeaderView:(UIView *)titleView {
    if (self = [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        _headView = titleView;
        
    }
    return self;
}

- (instancetype)initWithHeaderView:(UIView *)titleView cancelTitle:(NSString *)cancelTitle cancelColor:(UIColor *)color cancelBlock:(void(^)(void))cancelBlock{
    if (self = [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        _headView = titleView;
        
        _cancelTitle = cancelTitle;
        
        _cancelColor = color;
        
        _cancelBlock = cancelBlock;
        
    }
    return self;
}

#pragma mark - life cycle
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self addSubview:self.maskView];
    [self addSubview:self.tableView];
}


#pragma mark - public method
- (void)showInView:(UIView *)superView {
    [superView addSubview:self];
    [self show];
}

- (void)addActionWithTitle:(NSString *)title titlecColor:(UIColor *)color action:(void (^)(void))action {
    SheetActionModel *model = [[SheetActionModel alloc] initWithTitle:title titlecColor:color action:action];
    [self.optionsArr addObject:model];
}

#pragma mark - getter
- (NSMutableArray *)optionsArr {
    if (!_optionsArr) {
        _optionsArr = [NSMutableArray array];
    }
    return _optionsArr;
}

- (UIView*)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0;
        _maskView.userInteractionEnabled = YES;
    }
    return _maskView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 10;
        _tableView.clipsToBounds = YES;
        _tableView.rowHeight = 58.0;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorInset = UIEdgeInsetsMake(0, -50, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Navi_Cell"];
    }
    return _tableView;
}

#pragma mark - TableViewD
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cancelTitle ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? _optionsArr.count : 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Navi_Cell"];
    
    if (indexPath.section == 0) {
        
        SheetActionModel *model = _optionsArr[indexPath.row];
        
        cell.textLabel.text = model.title;
        cell.textLabel.textColor = model.textColor;
        
        if (indexPath.row == _optionsArr.count - 1) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:
                                      CGRectMake(0, 0, ScreenWidth - (Margin * 2), tableView.rowHeight) byRoundingCorners:
                                      UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:
                                      CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            maskLayer.frame = cell.contentView.bounds;
            maskLayer.path = maskPath.CGPath;
            cell.layer.mask = maskLayer;
        }
        
    } else {
        cell.textLabel.text      = _cancelTitle;
        cell.textLabel.textColor = _cancelColor;
        cell.layer.cornerRadius  = 10;
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle          = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SheetActionModel *model = _optionsArr[indexPath.row];
        if (model.action) {
            model.action();
        }
    } else {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
    [self dismiss];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Margin;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, Margin)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

#pragma mark - private animate
- (void)show {
    
    CGFloat tableHeight;
    
    if (_cancelTitle) {
        tableHeight = _tableView.rowHeight * (_optionsArr.count + 1) + _headView.bounds.size.height + (Margin * 2);
    } else {
        tableHeight = _tableView.rowHeight * _optionsArr.count + _headView.bounds.size.height + Margin;
    }
    
    _tableView.frame = CGRectMake(Margin, ScreenHeight, ScreenWidth - (Margin * 2), tableHeight);
    
    [UIView animateWithDuration:.3 animations:^{
        _tableView.transform = CGAffineTransformMakeTranslation(0, -_tableView.frame.size.height);
        _maskView.alpha = 0.4;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.3 animations:^{
        _tableView.transform = CGAffineTransformIdentity;
        _maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}



@end
