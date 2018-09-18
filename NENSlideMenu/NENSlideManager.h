//
//  NENSlideManager.h
//  SlideController
//
//  Created by weuse_hao on 2018/9/4.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import "SlideTransitionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NENSlideManager : NSObject

- (instancetype)initWithMenuController:(UIViewController *)menuViewController mainController:(UIViewController *)mainViewController transitionType:(SlideTransitionType)transitionType;

// Menu出来的位置,默认是UIRectEdgeLeft
@property (nonatomic, readwrite) UIRectEdge targetEdge;
// Menu的宽度,默认是屏幕宽度
@property (nonatomic, readwrite) CGFloat MenuWidth;

@property (nonatomic, assign) SlideTransitionType transitionType;

@end

NS_ASSUME_NONNULL_END
