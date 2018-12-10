//
//  SOLSlideViewController.m
//  PresentingFun
//
//  Created by Jesse Wolff on 10/31/13.
//  Copyright (c) 2013 Soleares, Inc. All rights reserved.
//

#import "SOLSlideViewController.h"
#import "SOLSlideTransitionAnimator.h"
#import "SOLOptions.h"
#import "SOLPanGestureAnimator.h"

@implementation SOLSlideViewController
{
    UIButton *button;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.animator) {
        
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"<Back" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
    button = btn;
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}


- (void)actionButton:(UIButton *)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (id<UIViewControllerAnimatedTransitioning>)animator {
    if (!_animator) {
        SOLOptions *options = [SOLOptions sharedOptions];
        SOLSlideTransitionAnimator *temp = [[SOLSlideTransitionAnimator alloc] init];
        temp.appearing = NO;
        temp.duration = options.duration;
        temp.edge = SOLEdgeCustom;
        
        SOLPanGestureAnimator *interAnimator = [[SOLPanGestureAnimator alloc] initWithView:self.view recognizerBlock:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        interAnimator.presenting = temp.isAppearing;
        temp.interactor = interAnimator;
        self.animator = temp;
        
    }
    return _animator;
}
@end
