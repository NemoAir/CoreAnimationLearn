//
//  ViewDrewLearhController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/18.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "ViewDrewLearhController.h"
#import "NemoLayer.h"
#import "NemoView.h"
@interface ViewDrewLearhController ()

@end

@implementation ViewDrewLearhController

- (void)viewDidLoad {
    [super viewDidLoad];
    NemoView *view = [[NemoView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    view.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
