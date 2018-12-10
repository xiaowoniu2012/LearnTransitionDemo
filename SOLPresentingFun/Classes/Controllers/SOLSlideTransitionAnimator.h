//
//  SOLSlideTransitionAnimator.h
//  PresentingFun
//
//  Created by Jesse Wolff on 10/31/13.
//  Copyright (c) 2013 Soleares, Inc. All rights reserved.
//

@import Foundation;
#import "SOLBaseTransitionAnimator.h"

@protocol  BVInteractiveAnimator <UIViewControllerInteractiveTransitioning>
-(__kindof id<UIViewControllerInteractiveTransitioning>)interactiveAnimatorForNavOperation:(UINavigationControllerOperation)operation;

@end
typedef NS_ENUM(NSInteger, SOLEdge) {
    SOLEdgeTop,
    SOLEdgeLeft,
    SOLEdgeBottom,
    SOLEdgeRight,
    SOLEdgeTopRight,
    SOLEdgeTopLeft,
    SOLEdgeBottomRight,
    SOLEdgeBottomLeft,
    SOLEdgeCustom,
};

@interface SOLSlideTransitionAnimator : SOLBaseTransitionAnimator

@property (nonatomic, assign) SOLEdge edge;
@property (nonatomic, assign) CGRect fromRect;

+ (NSDictionary *)edgeDisplayNames;

- (CGRect)rectOffsetFromRect:(CGRect)rect atEdge:(SOLEdge)edge;

@end
