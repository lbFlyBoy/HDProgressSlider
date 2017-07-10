//
//  ViewController.m
//  HDProgressSlider
//
//  Created by admin on 2017/7/10.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import "HDProgressSlider.h"

@interface ViewController ()
@property (nonatomic, strong) HDProgressSlider *progress;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *reduceButton;

@end

@implementation ViewController
static float count = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _progress = [[HDProgressSlider alloc] init];
    _progress.backgroundColor = [UIColor whiteColor];
    _progress.progress = 3;
    [self.view addSubview:self.progress];
    
    _addButton = [[UIButton alloc] init];
    [_addButton setTitle:@"+" forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addButton setBackgroundColor:[UIColor blackColor]];
    [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    
    _reduceButton = [[UIButton alloc] init];
    [_reduceButton setTitle:@"-" forState:UIControlStateNormal];
    [_reduceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_reduceButton setBackgroundColor:[UIColor blackColor]];
    [_reduceButton addTarget:self action:@selector(reduceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.reduceButton];
}

- (void)addAction:(UIButton *)btn{
    self.progress.progress = count++>=10?10:count;
    
}

- (void)reduceAction:(UIButton *)btn{
    
    self.progress.progress = count--<=0?0:count;
}

- (void)viewDidLayoutSubviews{
    self.progress.frame = CGRectMake(15, 64, CGRectGetWidth([UIScreen mainScreen].bounds) - 30, 38);
    
    self.addButton.frame = CGRectMake(15, CGRectGetMaxY(self.progress.frame) + 30, 100, 30);
    
     self.reduceButton.frame = CGRectMake(CGRectGetMaxX(self.addButton.frame) + 100, CGRectGetMaxY(self.progress.frame) + 30, 100, 30);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
