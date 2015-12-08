//
//  drawView.h
//  03-画板
//
//  Created by 闲人 on 15/12/8.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawView : UIView
/** 当前选中的颜色 */
@property(nonatomic,strong)UIColor *currentColor;

/** 清屏 */
- (void)clean;
/** 回退 */
- (void)back;
@end
