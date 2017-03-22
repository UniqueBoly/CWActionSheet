//
//  CWActionSheet.h
//  CWActionSheet
//
//  Created by 吴波 on 2017/3/16.
//  Copyright © 2017年 wubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWActionSheetTableViewCell.h"

@class CWActionSheet;

typedef void(^ClickBlock)(CWActionSheet *sheet, NSIndexPath *indexPath);

@interface CWActionSheet : UIView

- (instancetype)initWithTitles :(NSArray *)titles clickAction:(ClickBlock)clickBlock;

- (void)show;

- (void)hide;

@end
