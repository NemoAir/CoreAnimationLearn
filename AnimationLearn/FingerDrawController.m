//
//  FingerDrawController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/27.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "FingerDrawController.h"

@interface FingerDrawController ()

@end

@implementation FingerDrawController

-(void)loadView{
    self.view = [[DrawView alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
