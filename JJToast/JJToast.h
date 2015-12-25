//
//  JJToast.h
//  JJToast
//
//  Created by LiHong on 15/12/25.
//  Copyright © 2015年 李红(lh.coder@foxmail.com). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface JJToast : NSObject {
    @private
    UILabel *_messageLabel;
    BOOL _visiable;
    NSMutableArray *_messageQueue;
    NSMutableDictionary *_durationMap;
}

+ (void)showToast:(NSString *)message;
+ (void)showToast:(NSString *)message hideAfter:(NSTimeInterval)duration;

@end
