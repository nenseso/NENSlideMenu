//
//  NENSlideManager.h
//  SlideController
//
//  Created by weuse_hao on 2018/9/4.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NENSlideManager : NSObject

- (instancetype)initWithMenuController:(UIViewController *)menuViewController mainController:(UIViewController *)mainViewController;

// Menu出来的位置
@property (nonatomic, readwrite) UIRectEdge targetEdge;
// Menu的宽度
@property (nonatomic, readwrite) CGFloat MenuWidth;

@end

NS_ASSUME_NONNULL_END
