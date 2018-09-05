//
//  SlideCustomPresentationController.m
//  SlideController
//
//  Created by weuse_hao on 2018/9/3.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import "SlideCustomPresentationController.h"

@interface SlideCustomPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation SlideCustomPresentationController

- (void)presentationTransitionWillBegin
{
    UIBlurEffect *blurEffrct =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *dimmingView = [[UIVisualEffectView alloc]initWithEffect:blurEffrct];
    dimmingView.frame = self.containerView.bounds;
    dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
    self.dimmingView = dimmingView;
    [self.containerView addSubview:dimmingView];
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    self.dimmingView.alpha = 0.f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 1.f;
    } completion:NULL];
    
}

//| ----------------------------------------------------------------------------
- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (completed == NO)
    {
        self.dimmingView = nil;
    }
}

//| ----------------------------------------------------------------------------
- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}


//| ----------------------------------------------------------------------------
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed == YES)
    {
        self.dimmingView = nil;
    }
}

#pragma mark -
#pragma mark Layout

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == self.presentedViewController)
        [self.containerView setNeedsLayout];
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController)
        return ((UIViewController*)container).preferredContentSize;
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}

//| ----------------------------------------------------------------------------
- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    CGRect presentedViewControllerFrame = containerViewBounds;
    if (self.targetEdge == UIRectEdgeTop)
    {
        
    }
    else if (self.targetEdge == UIRectEdgeBottom)
    {
        
    }
    else if (self.targetEdge == UIRectEdgeLeft)
    {
        presentedViewControllerFrame.size.width = presentedViewContentSize.width;
        presentedViewControllerFrame.origin.x = 0;
    }
    else if (self.targetEdge == UIRectEdgeRight)
    {
        presentedViewControllerFrame.size.width = presentedViewContentSize.width;
        presentedViewControllerFrame.origin.x = containerViewBounds.size.width - presentedViewContentSize.width;
    }
    else
        NSAssert(NO, @"targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.");
    

    return presentedViewControllerFrame;
}

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    self.dimmingView.frame = self.containerView.bounds;
}


#pragma mark -
#pragma mark Tap Gesture Recognizer

- (IBAction)dimmingViewTapped:(UITapGestureRecognizer*)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
