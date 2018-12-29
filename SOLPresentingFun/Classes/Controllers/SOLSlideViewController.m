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


@end
