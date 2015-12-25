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

/** 显示短消息，默认2.5秒消失。支持消息队列 
  @param message 消息
  @return void
 */
+ (void)showToast:(NSString *)message;

/** 显示短消息，默认2.5秒消失。支持消息队列
 @param message 消息
 @param hideAfter 显示消息的时长
 @return void
 */
+ (void)showToast:(NSString *)message hideAfter:(NSTimeInterval)duration;

@end
