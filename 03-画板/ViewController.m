//
//  ViewController.m
//  03-画板
//
//  Created by 闲人 on 15/12/8.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "ViewController.h"
#import "drawView.h"

@interface ViewController ()
/** 画板 */
@property (weak, nonatomic) IBOutlet drawView *drawView;

/** 回退 */
- (IBAction)back;
/** 清屏幕 */
- (IBAction)clean;
/** 存储 */
- (IBAction)save;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back {
    [self.drawView back];
}

- (IBAction)clean {
    [self.drawView clean];
}


// 选中某一个颜色
- (IBAction)colorBtnClick:(UIButton *)sender {
    NSLog(@"%s", __func__);
    self.drawView.currentColor = sender.backgroundColor;
}
@end
