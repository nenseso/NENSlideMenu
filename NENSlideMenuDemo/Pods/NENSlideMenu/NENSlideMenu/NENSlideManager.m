//
//  NENSlideManager.m
//  SlideController
//
//  Created by weuse_hao on 2018/9/4.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import "NENSlideManager.h"
#import "SlideTransitionDelegate.h"
@interface NENSlideManager ()

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *presentingVCGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *presentedVCGesture;

@property (nonatomic, strong) UIViewController *presentedViewController;
@property (nonatomic, strong) UIViewController *presentingViewController;
@property (nonatomic, strong) SlideTransitionDelegate *transitionDelegate;

@property (nonatomic, readwrite) UIRectEdge backTargetEdge;

@end

@implementation NENSlideManager

- (instancetype)initWithMenuController:(UIViewController *)menuViewController mainController:(UIViewController *)mainViewController
{
    self = [super init];
    if (self) {
        self.presentedViewController = menuViewController;
        self.presentingViewController = mainViewController;
        self.transitionDelegate = [[SlideTransitionDelegate alloc] initWithPresentedViewController:self.presentedViewController presentingViewController:self.presentingViewController];
        menuViewController.transitioningDelegate = self.transitionDelegate;
        self.targetEdge = UIRectEdgeLeft;
        [self addGestures];
    }
    return self;
}

- (void)addGestures
{
    UIScreenEdgePanGestureRecognizer *presentingVCGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(presentInteractiveTransitionRecognizerAction:)];
    presentingVCGesture.edges = self.targetEdge;
    self.presentingVCGesture = presentingVCGesture;
    [self.presentingViewController.view addGestureRecognizer:presentingVCGesture];
    
    UIPanGestureRecognizer *presentedVCGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismissInteractiveTransitionRecognizerAction:)];
    self.presentedVCGesture = presentedVCGesture;
    [self.presentedViewController.view addGestureRecognizer:presentedVCGesture];
}

- (void)setMenuWidth:(CGFloat)MenuWidth
{
    _MenuWidth = MenuWidth;
    self.presentedViewController.preferredContentSize = CGSizeMake(MenuWidth, self.presentedViewController.view.bounds.size.height);
}

- (void)setTargetEdge:(UIRectEdge)targetEdge
{
    _targetEdge = targetEdge;
    NSAssert((targetEdge == UIRectEdgeTop || UIRectEdgeLeft || UIRectEdgeBottom || UIRectEdgeRight), @"targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.");
    self.backTargetEdge = (targetEdge == UIRectEdgeTop || targetEdge == UIRectEdgeLeft) ? targetEdge << 2 : targetEdge >> 2;
    self.presentingVCGesture.edges = targetEdge;
    self.transitionDelegate.presentTargetEdge = targetEdge;
    self.transitionDelegate.dismissTargetEdge = self.backTargetEdge;
}

- (IBAction)dismissInteractiveTransitionRecognizerAction:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        SlideTransitionDelegate *transitionDelegate = self.transitionDelegate;
        transitionDelegate.gestureRecognizer = sender;
        transitionDelegate.dismissTargetEdge = self.backTargetEdge;
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)presentInteractiveTransitionRecognizerAction:(UIScreenEdgePanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.transitionDelegate.gestureRecognizer = sender;
        self.transitionDelegate.presentTargetEdge = self.targetEdge;
        [self.presentingViewController presentViewController:self.presentedViewController animated:YES completion:nil];
    }
}


@end
