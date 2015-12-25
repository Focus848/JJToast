//
//  JJToast.m
//  JJToast
//
//  Created by LiHong on 15/12/25.
//  Copyright © 2015年 李红(lh.coder@foxmail.com). All rights reserved.
//

#import "JJToast.h"

@implementation JJToast

+ (instancetype)shared {
    static JJToast *toast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [[JJToast alloc] init];
    });
    return toast;
}

- (instancetype) init {
    if (self = [super init]) {
        _visiable = NO;
        _messageQueue = [NSMutableArray array];
        _durationMap = [NSMutableDictionary dictionary];
        [self messageLabel];
    }
    return self;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:16.0];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = [UIColor whiteColor];;
        _messageLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        _messageLabel.layer.cornerRadius = 5.0;
        _messageLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        _messageLabel.layer.shadowOpacity = 0.7;
        _messageLabel.layer.shadowOffset = CGSizeMake(2, 3.5);
        _messageLabel.layer.shadowRadius = 3.0;
        _messageLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0);
    }
    return _messageLabel;
}

- (void)showToast:(NSString *)message {
    [self showToast:message hideAfter:2.5];
}

- (void)showToast:(NSString *)message hideAfter:(NSTimeInterval)duration {
    if (!message || [message isEqualToString:@""]) return;
    [_messageQueue addObject:message];
    [_durationMap setObject:@(duration) forKey:message];
    [self showNextMessage];
}

- (void)showNextMessage {
    if (_visiable) return;
    NSString *message = [_messageQueue firstObject];
    if (!message) return;
    NSNumber *duration = [_durationMap objectForKey:message];
    
    NSDictionary *attr = @{NSFontAttributeName:_messageLabel.font};
    CGFloat textWidth = 160.0;
    CGFloat textHeight = [message boundingRectWithSize:CGSizeMake(textWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height + 10.0;
    _messageLabel.text = message;
    _messageLabel.bounds = CGRectMake(0, 0, textWidth + 10.0, textHeight);
    
    _visiable = YES;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:_messageLabel];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration.doubleValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            _messageLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            [_messageLabel removeFromSuperview];
            [_messageQueue removeObject:message];
            [_durationMap removeObjectForKey:message];
            _messageLabel.alpha = 1.0;
            _visiable = NO;
            [self performSelector:@selector(showNextMessage) withObject:nil afterDelay:0.8];
        }];
    });
}

+ (void)showToast:(NSString *)message {
    [[JJToast shared] showToast:message];
}

+ (void)showToast:(NSString *)message hideAfter:(NSTimeInterval)duration {
    [[JJToast shared] showToast:message hideAfter:duration];
}
@end
