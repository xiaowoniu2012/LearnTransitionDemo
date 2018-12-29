//
//  SOLPanGestureAnimator.m
//  SOLPresentingFun
//
//  Created by smart on 2018/12/7.
//  Copyright © 2018 Soleares. All rights reserved.
//

#import "SOLPanGestureAnimator.h"
@interface SOLPanGestureAnimator()
@property (nonatomic,strong) id<UIViewControllerContextTransitioning> contextData;
@property (nonatomic,strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic,strong) UIView *targetView;
@property (nonatomic,copy) void(^handleGestureRecognized)(void);
@end

@implementation SOLPanGestureAnimator

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
- (instancetype)initWithView:(UIView *)view
             recognizerBlock:(void(^ __nullable)(void))block {
    if (self = [super init]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGetureRecognizer:)];
        [view addGestureRecognizer:pan];
        _targetView = view;
        _handleGestureRecognized = [block copy];
    }
    return self;
}
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.contextData = transitionContext;
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
}

-(CGAffineTransform)transformFromRect:(CGRect)fromRect toRect:(CGRect)toRect{
    CGAffineTransform moveTrans = CGAffineTransformMakeTranslation(CGRectGetMidX(toRect) - CGRectGetMidX(fromRect), CGRectGetMidY(toRect) - CGRectGetMidY(fromRect));
    CGAffineTransform scaleTrans = CGAffineTransformMakeScale(toRect.size.width / fromRect.size.width, toRect.size.height / fromRect.size.height);
    
    return CGAffineTransformConcat(scaleTrans, moveTrans);
}

- (void)handlePanGetureRecognizer:(UIPanGestureRecognizer *)recognizer {
    UIView* view = self.targetView;
    UIViewController *fromvc = [self.contextData viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        if (self.handleGestureRecognized) {
            self.handleGestureRecognized();
        }

    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (self.isInteracting) {
            CGPoint translation = [recognizer translationInView:view.window];
            
            CGFloat percentage = fabs(translation.x / CGRectGetWidth(view.bounds));
            CGAffineTransform move = CGAffineTransformMakeTranslation(translation.x*(1-percentage), translation.y);
            CGAffineTransform scale = CGAffineTransformMakeScale(1-percentage, 1-percentage);
            CGAffineTransform combine = CGAffineTransformConcat(scale, move);
            fromvc.view.transform = combine;
            [self updateInteractiveTransition:percentage];
        }
        
    } else if (recognizer.state >= UIGestureRecognizerStateEnded) {
        if (self.isInteracting) {
            CGPoint translation = [recognizer translationInView:view];
            CGFloat percentage = fabs(translation.x / CGRectGetWidth(view.bounds));
            if (percentage >0.5) {
                [self finishInteractiveTransition];
            } else {
                fromvc.view.transform  = CGAffineTransformIdentity;
                [self cancelInteractiveTransition];
                
            }
            self.interacting = NO;
        }
        
    }
}


- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    [super updateInteractiveTransition:percentComplete];
    UIView *toView = [self.contextData viewForKey:UITransitionContextToViewKey];
    toView.alpha = percentComplete;
}
- (void)cancelInteractiveTransition {
    [super cancelInteractiveTransition];
    [self.contextData completeTransition:NO];
}
- (void)finishInteractiveTransition {
    [super finishInteractiveTransition];
    UIView *toView = [self.contextData viewForKey:UITransitionContextToViewKey];
    toView.alpha = 1.0;
    [self addtionDissmissal];
}

#pragma mark - Helper methods
- (void)addtionDissmissal{

    UIView *fromView = [self.contextData viewForKey:UITransitionContextFromViewKey];
    [UIView animateWithDuration:1.0 animations:^{
        fromView.frame =  CGRectMake(100, 100, 100, 50);
    } completion:^(BOOL finished) {
        [fromView removeFromSuperview];
        [self.contextData completeTransition:YES];
    }];
}



@end
