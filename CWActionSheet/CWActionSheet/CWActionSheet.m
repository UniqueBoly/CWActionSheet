//
//  CWActionSheet.m
//  CWActionSheet
//
//  Created by 吴波 on 2017/3/16.
//  Copyright © 2017年 wubo. All rights reserved.
//

#import "CWActionSheet.h"

#define K_BackColor [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00]
#define K_Width  [UIScreen mainScreen].bounds.size.width
#define K_Height [UIScreen mainScreen].bounds.size.height

static NSString * const cellID = @"cellID";

@interface CWActionSheet ()<UITableViewDelegate , UITableViewDataSource , UIGestureRecognizerDelegate>

@property (nonatomic , strong) UITableView *cwTbaleView;
@property (nonatomic , strong) UIButton *cancleBtn;
@property (nonatomic , strong) NSArray *titles;
@property (nonatomic , copy  ) ClickBlock btnClick;

@end

@implementation CWActionSheet

- (instancetype)initWithTitles:(NSArray *)titles clickAction:(ClickBlock)clickBlock
{
    if (self = [super init]) {
        _btnClick = clickBlock;
        _titles = titles;
        [self commnInit];
    }
    return self;
}

- (void)commnInit
{
    [self addSubview:self.cwTbaleView];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
}

#pragma mark - 数据源

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CWActionSheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CWActionSheetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLab.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.btnClick) {
        self.btnClick(self , indexPath);
    }
    [self hide];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.frame = self.superview.bounds;
    self.cwTbaleView.frame = CGRectMake(0, K_Height - (_titles.count + 1) * 50 - 5, K_Width, (_titles.count + 1) * 50 + 5);
}

- (UITableView *)cwTbaleView
{
    if (!_cwTbaleView) {
        _cwTbaleView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _cwTbaleView.delegate = self;
        _cwTbaleView.dataSource = self;
        _cwTbaleView.tableFooterView = [self createFooterView];
        _cwTbaleView.tableFooterView.backgroundColor = K_BackColor;
        _cwTbaleView.showsVerticalScrollIndicator = NO;
        _cwTbaleView.scrollEnabled = NO;
        if ([_cwTbaleView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_cwTbaleView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_cwTbaleView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_cwTbaleView setLayoutMargins:UIEdgeInsetsZero];
        }
        [_cwTbaleView registerClass:[CWActionSheetTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _cwTbaleView;
}

- (UIView *)createFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Width, 54)];
    footerView.backgroundColor = K_BackColor;
    [footerView addSubview:self.cancleBtn];
    return footerView;
}

- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(0, 8, K_Width, 46);
        [_cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_cancleBtn setBackgroundColor:[UIColor whiteColor]];
    }
    return _cancleBtn;
}

- (void)cancleClick
{
    [self hide];
}

- (void)show
{
    //在主线程中弹出，不然会被遮挡，导致看不到视图。
    dispatch_async(dispatch_get_main_queue(), ^{
        self.alpha = 0.0f;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [UIView animateWithDuration:0.35f
                              delay:0.0
             usingSpringWithDamping:0.9
              initialSpringVelocity:0.7
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.alpha = 1.0;
                             self.cwTbaleView.transform = CGAffineTransformMakeTranslation(0, -200);
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    });
}

- (void)hide
{
    [UIView animateWithDuration:0.35f
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                         self.cwTbaleView.frame = CGRectMake(0, K_Height, K_Width, (_titles.count + 1) * 50 + 5);
                     } completion:^(BOOL finished) {
                         self.alpha = 1.0f;
                         [self removeFromSuperview];
                     }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //获取点击的点，判断是否在tableview上
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(self.cwTbaleView.frame, point))
    {
       // if (self.btnClick)
       // {
       //     self.btnClick(self, 0);
       // }
        [self hide];
    }
}

@end
