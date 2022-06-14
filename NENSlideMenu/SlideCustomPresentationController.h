//
//  SlideCustomPresentationController.h
//  SlideController
//
//  Created by weuse_hao on 2018/9/3.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SlideCustomPresentationController : UIPresentationController

@property (nonatomic, readwrite) UIRectEdge targetEdge;
@property (nonatomic, assign) CGFloat menuRadius;
@property (nonatomic, assign) BOOL needBlur;
@end

NS_ASSUME_NONNULL_END
