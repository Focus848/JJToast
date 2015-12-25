//
//  ViewController.m
//  JJToast
//
//  Created by LiHong on 15/12/25.
//  Copyright © 2015年 李红(lh.coder@foxmail.com). All rights reserved.
//

#import "JJToast.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [JJToast showToast:@"消息 1"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JJToast showToast:@"2015年2月12日，同志纪录片导演范坡坡因为导演作品"];
        [JJToast showToast:@"消息 3"];
        [JJToast showToast:@"  消息 4"];
    });
    
    [JJToast showToast:@"四川省委原副书记李春城因为拆迁而被市民称为；南京市原市长季建业，六朝古都被他“开膛破肚" hideAfter:10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 

}

@end
