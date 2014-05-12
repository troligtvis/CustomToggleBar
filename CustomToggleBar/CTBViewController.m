//
//  CBViewController.m
//  CustomBars
//
//  Created by Kj Drougge on 2014-05-11.
//  Copyright (c) 2014 Kj Drougge. All rights reserved.
//

#import "CTBViewController.h"

@interface CTBViewController ()

@end

@implementation CTBViewController{
    UIDynamicAnimator *_animator;
    UIDynamicItemBehavior *itemBehaviour;
    UIGravityBehavior *_gravity;
    UICollisionBehavior *_collision;
    
    UIView *_bar;
    UIView *_barStopDown;
    UIView *_barStopUp;
    UIButton *_barButton;
    
    BOOL _isBarHidden;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isBarHidden = NO;
    
    _barButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_barButton setTitle:@"Toggle Down" forState:UIControlStateNormal];
    [_barButton setFrame:CGRectMake(100, 150, 100, 50)];
    [_barButton addTarget:self action:@selector(toggleBar) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.view addSubview:_barButton];
    
    // Creating boundaries for the bar
    _barStopDown =  [[UIView alloc] initWithFrame:CGRectMake(0, 60, [[UIScreen mainScreen] bounds].size.width, 10)];
    _barStopUp =  [[UIView alloc] initWithFrame:CGRectMake(0, -120, [[UIScreen mainScreen] bounds].size.width, 10)];
    [self.view addSubview:_barStopDown];
    [self.view addSubview:_barStopUp];
    
    
    _bar = [[UIView alloc] initWithFrame:CGRectMake(0, -100, [[UIScreen mainScreen] bounds].size.width, 70)];
    _bar.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_bar];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[_bar]];
    _gravity.gravityDirection = CGVectorMake(0.0, 0.0);
    [_animator addBehavior:_gravity];
    
    itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[_bar]];
    itemBehaviour.elasticity = 0.55;
    itemBehaviour.allowsRotation = NO;
    [_animator addBehavior:itemBehaviour];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:@[_bar]];
    
    [_collision addBoundaryWithIdentifier:@"_barStopDown" fromPoint:CGPointMake(60, 60) toPoint:CGPointMake(60, 60)];
    [_collision addBoundaryWithIdentifier:@"_barStopUp" fromPoint:CGPointMake(60, -100) toPoint:CGPointMake(60, -100)];
    
    [_animator addBehavior:_collision];
    
}


-(void)toggleBar{
    
    if(!_isBarHidden){
        _gravity.gravityDirection = CGVectorMake(0.0, 1.0);
        [_barButton setTitle:@"Toggle Up" forState:UIControlStateNormal];
        _isBarHidden = YES;
    } else {
        // Reverse the gravity
        _gravity.gravityDirection = CGVectorMake(0.0, -1.0);
        [_barButton setTitle:@"Toggle Down" forState:UIControlStateNormal];
        _isBarHidden = NO;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
