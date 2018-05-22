//
//  MJCustomHeader.m
//  MJRefreshExample
//
//  Created by yfxiari on 2018/5/16.
//  Copyright © 2018年 小码哥. All rights reserved.
//

#import "MJCustomHeader.h"

@interface MJCustomHeader()
@property (nonatomic, strong) UIImageView *refreshView;
@end

@implementation MJCustomHeader

- (void)prepare {
    [super prepare];
    
    _refreshView = [[UIImageView alloc] init];
    _refreshView.image = [UIImage imageNamed:@"common_refresh"];
    _refreshView.contentMode = UIViewContentModeCenter;
    [self addSubview:_refreshView];
}

- (void)placeSubviews {
    [super placeSubviews];
    _refreshView.frame = self.bounds;
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    if (state == MJRefreshStateRefreshing || state == MJRefreshStatePulling) {
        [self startAnimation];
    }else if (state == MJRefreshStateIdle){
        [self stopAnimation];
    }
}

- (void)startAnimation {
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = @(0);
    animation.toValue = @(M_PI*2);
    animation.duration = 0.7;
    animation.repeatCount = MAXFLOAT;
    [_refreshView.layer addAnimation:animation forKey:@"rotation"];
}

- (void)stopAnimation {
    [_refreshView.layer removeAllAnimations];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    if (self.state != MJRefreshStateIdle) return;
    [self stopAnimation];
    self.refreshView.transform = CGAffineTransformMakeRotation(M_PI * 2 * pullingPercent);
}

@end
