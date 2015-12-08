//
//  drawView.m
//  03-画板
//
//  Created by 闲人 on 15/12/8.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "drawView.h"

@interface drawView ()
/** 存放手指触到的屏幕的线 */
@property (nonatomic, strong) NSMutableArray *paths;
/**
 *所有线的颜色 每一条对应里面一个元素
 */
@property(nonatomic,strong)NSMutableArray *colorsOfAllLine;
@end

@implementation drawView

#pragma mark - 懒加载
- (NSMutableArray *)paths
{
    if (!_paths) {
        self.paths = [NSMutableArray array];
    }
    return _paths;
}

-(NSMutableArray *)colorsOfAllLine{
    if (!_colorsOfAllLine) {
        _colorsOfAllLine = [NSMutableArray array];
    }
    
    return _colorsOfAllLine;
}

#pragma mark - 项目主流程
- (void)drawRect:(CGRect)rect{
    
    // 边路数组绘制所有的线段
    NSInteger lineCount = self.paths.count;
    for (NSInteger i = 0; i < lineCount; i++) {
        //取出当前 "一条线" 的数组
        UIColor *lineColor = self.colorsOfAllLine[i];
        [lineColor set];
        
        UIBezierPath *path = self.paths[i];
        [path stroke];
        // 设置颜色
      
    }
    
//    for (UIBezierPath *path in self.paths) {
//        [path stroke];
//    }
    

}

// 开始触摸
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%p", self.currentColor);
    
    // 获取手指触摸的UITouch对象
    UITouch *touch = [touches anyObject];
    // 通过对象  获取所在的位置
    CGPoint startPoint = [touch locationInView:touch.view];
    // 当用户手指按下的时候创建一条路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置路径的相关属性
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineWidth:5];
    
    // 4.设置当前路径的起点
    [path moveToPoint:startPoint];
    // 5.将路径添加到数组中
    [self.paths addObject:path];
    
    // 6.保存当前 "一条线" 的颜色
    
    if (!self.currentColor) {//为空，给个默认的黑色
        [self.colorsOfAllLine addObject:[UIColor blackColor]];
    }else{
        [self.colorsOfAllLine addObject:self.currentColor];
    }
    
    NSLog(@"颜色的数量%lu  线的数量%lu", (unsigned long)self.colorsOfAllLine.count, (unsigned long)self.paths.count);
    
}

// 触摸移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint movePoint = [touch locationInView:touch.view];
    
    // 3.取出当前的path
    UIBezierPath *currentPaht = [self.paths lastObject];
    // 4.设置当前路径的终点
    [currentPaht addLineToPoint:movePoint];
    
    // 6.调用drawRect方法重绘视图
    [self setNeedsDisplay];
}

// 触摸结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}

#pragma mark - 处理事件
/** 清屏 */
- (void)clean{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

/** 回退 */
- (void)back{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

@end
