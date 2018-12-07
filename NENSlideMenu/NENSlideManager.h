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

// Menu original entries place,default is UIRectEdgeLeft
@property (nonatomic, readwrite) UIRectEdge targetEdge;
// Menu controller width, default is screen width
@property (nonatomic, readwrite) CGFloat MenuWidth;
// Menu controller height, default is screen height
@property (nonatomic, readwrite) CGFloat MenuHeight;

@property (nonatomic, assign) SlideTransitionType transitionType;

// if the menu entry is bottom, set this property to let the menu controller have Upper left corner and upper right corner fillet
@property (nonatomic, readwrite) CGFloat menuRadius;

@end

NS_ASSUME_NONNULL_END
