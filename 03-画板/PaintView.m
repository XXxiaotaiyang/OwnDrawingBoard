//
//  PaintView.m
//  03-画板
//
//  Created by 闲人 on 15/12/8.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "PaintView.h"

@interface PaintView ()
/** 存放线的数组 */
@property(nonatomic, strong) NSMutableArray *allLine;

@end

@implementation PaintView

#pragma mark - 懒加载
- (NSMutableArray *)allLine{
    if (!_allLine) {
        self.allLine = [NSMutableArray array];
    }
    return _allLine;
}

#pragma mark - main
- (void)drawRect:(CGRect)rect{
    CGContextRef layerContext = UIGraphicsGetCurrentContext();
    // 设置线宽
    CGContextSetLineWidth(layerContext, 5);
    // 设置首尾和连接点的样式
    CGContextSetLineCap(layerContext, kCGLineCapRound);
    CGContextSetLineJoin(layerContext, kCGLineJoinRound);
    
    
    NSInteger lineCount = self.allLine.count;
    NSLog(@"%d", lineCount);
    for (NSInteger i = 0; i < lineCount; i++) {
        //取出当前 "一条线" 的数组
        NSArray *pointsOfALine = self.allLine[i];
        
        //画线
        // 取出 "线" 的 "点“ 的个数进行绘制
        NSInteger pointsCount = pointsOfALine.count;
        for (NSInteger j = 0; j < pointsCount; j++) {
            CGPoint point = [pointsOfALine[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(layerContext, point.x, point.y);
            }else{
                CGContextAddLineToPoint(layerContext, point.x, point.y);
            }
        }
    }
    
    
    //渲染
    CGContextStrokePath(layerContext);
}

#pragma mark - 监听触摸时间
// 只要手指一触碰屏幕  就生成一条存放点的线
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 创建一个数组用来存放一条线的点
    NSMutableArray *pointOfLine = [NSMutableArray array];
    
    [self.allLine addObject:pointOfLine];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:touch.view];
    // 获取当前一条线的所有点  添加到线中
    NSMutableArray *pointOfLine = [self.allLine lastObject];
    [pointOfLine addObject:[NSValue valueWithCGPoint:touchPoint]];
    
    // 重绘
    [self setNeedsDisplay];
}

@end
