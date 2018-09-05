//
//  SlideTransitionInteractionController.m
//  SlideController
//
//  Created by weuse_hao on 2018/9/3.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import "SlideTransitionInteractionController.h"

@interface SlideTransitionInteractionController ()
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIGestureRecognizer *gestureRecognizer;
@property (nonatomic, readonly) UIRectEdge edge;
@end

@implementation SlideTransitionInteractionController

//| ----------------------------------------------------------------------------
- (instancetype)initWithGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer edgeForDragging:(UIRectEdge)edge
{
    NSAssert(edge == UIRectEdgeTop || edge == UIRectEdgeBottom ||
             edge == UIRectEdgeLeft || edge == UIRectEdgeRight,
             @"edgeForDragging must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.");
    
    self = [super init];
    if (self)
    {
        _gestureRecognizer = gestureRecognizer;
        
        _edge = edge;
        
        // Add self as an observer of the gesture recognizer so that this
        // object receives updates as the user moves their finger.
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

//| ----------------------------------------------------------------------------
- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Use -initWithGestureRecognizer:edgeForDragging:" userInfo:nil];
}

- (void)dealloc
{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}


//| ----------------------------------------------------------------------------
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Save the transitionContext for later.
    self.transitionContext = transitionContext;
    
    [super startInteractiveTransition:transitionContext];
}

//| ----------------------------------------------------------------------------
//! Returns the offset of the pan gesture recognizer from the edge of the
//! screen as a percentage of the transition container view's width or height.
//! This is the percent completed for the interactive transition.
//
- (CGFloat)percentForGesture:(UIGestureRecognizer *)gesture
{

    UIView *transitionContainerView = self.transitionContext.containerView;
    // Figure out what percentage we've gone.
    CGFloat width = CGRectGetWidth(transitionContainerView.bounds);
    CGFloat height = CGRectGetHeight(transitionContainerView.bounds);
    if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        CGPoint locationInSourceView = [gesture locationInView:transitionContainerView];
        
        // Return an appropriate percentage based on which edge we're dragging
        // from.
        if (self.edge == UIRectEdgeRight)
            return (width - locationInSourceView.x) / width;
        else if (self.edge == UIRectEdgeLeft)
            return locationInSourceView.x / width;
        else if (self.edge == UIRectEdgeBottom)
            return (height - locationInSourceView.y) / height;
        else if (self.edge == UIRectEdgeTop)
            return locationInSourceView.y / height;
        else
            return 0.f;
    } else { // pan gesture
        UIPanGestureRecognizer *panGes = (UIPanGestureRecognizer *)gesture;
        CGPoint translation = [panGes translationInView:transitionContainerView];
        CGFloat translationX = translation.x;
        if (self.edge == UIRectEdgeLeft) {
            if (translationX < 0) {
                return 0.f;
            } else {
                return fabs(translationX)  / width;
            }
        } else if (self.edge == UIRectEdgeRight) {
            if (translationX >0) {
                return 0.f;
            } else {
                return fabs(translationX)  / width;
            }
        } else {
            return 0.f;
        }
    }
}

- (IBAction)gestureRecognizeDidUpdate:(UIGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:

            break;
        case UIGestureRecognizerStateChanged:

            [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            break;
        case UIGestureRecognizerStateEnded:

            if ([self percentForGesture:gestureRecognizer] >= 0.5f)
                [self finishInteractiveTransition];
            else
                [self cancelInteractiveTransition];
            break;
        default:

            [self cancelInteractiveTransition];
            break;
    }
}






@end
