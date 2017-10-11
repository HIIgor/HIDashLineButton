//
//  HIViewController.m
//  HIDashLineButton
//
//  Created by xiangyaguo on 10/11/2017.
//  Copyright (c) 2017 xiangyaguo. All rights reserved.
//

#import "HIViewController.h"
#import "HIDashLineButton.h"

@interface HIViewController ()

@property (nonatomic, strong) HIDashLineButton *dashLineButton;

@end

@implementation HIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Demo";
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.dashLineButton];

    self.dashLineButton.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 200 * 0.5,
                                           CGRectGetMidY(self.view.bounds) - 100 * 0.5,
                                           200,
                                           100);
}

- (void)senderAction {
    self.dashLineButton.backgroundColor = [self randomColor];
    self.dashLineButton.layer.borderColor = [self randomColor].CGColor;
    self.dashLineButton.layer.borderWidth = random() % 2;
    self.dashLineButton.layer.cornerRadius = random() % 20;
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:(random() % 255) / 255.f green:(random() % 255) / 255.f blue:(random() % 255) / 255.f alpha:1];
}

- (HIDashLineButton *)dashLineButton {
    if (!_dashLineButton) {
        _dashLineButton = [HIDashLineButton dashLineBorderButtonWithPattern:@[@5, @3] strokeColor:[UIColor greenColor] lineWidth:3 cornerRadius:20];
        [_dashLineButton setBackgroundColor:[UIColor redColor]];
        [_dashLineButton setTitle:@"Hello World" forState:UIControlStateNormal];
        [_dashLineButton addTarget:self action:@selector(senderAction) forControlEvents:UIControlEventTouchUpInside];
    }

    return _dashLineButton;
}

@end
