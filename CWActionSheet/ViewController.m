//
//  ViewController.m
//  CWActionSheet
//
//  Created by 吴波 on 2017/3/16.
//  Copyright © 2017年 wubo. All rights reserved.
//

#import "ViewController.h"
#import "CWActionSheet.h"

#define K_Width  [UIScreen mainScreen].bounds.size.width
#define K_Height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic , strong) UIButton *btn;
@property (nonatomic , strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.label];
}

- (void)click
{
    NSArray *title = @[@"_codeBo", @"拍摄" , @"从相册选择"];
    CWActionSheet *sheet = [[CWActionSheet alloc] initWithTitles:title clickAction:^(CWActionSheet *sheet, NSIndexPath *indexPath) {
        NSLog(@"点击了%@", title[indexPath.row]);
        self.label.text = title[indexPath.row];
    }];
    [sheet show];
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake((K_Width - 80) / 2 , 100, 80, 40);
        _btn.backgroundColor = [UIColor grayColor];
        [_btn setTitle:@"弹弹弹" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame: CGRectMake(20, 170, K_Width - 40, 40)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:15];
        _label.backgroundColor = [UIColor whiteColor];
    }
    return _label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
