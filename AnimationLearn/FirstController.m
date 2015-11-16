//
//  FirstController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/19.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "FirstController.h"
#import "AnimationSquareController.h"
#import "PortraitController.h"
#import "ViewDrewLearhController.h"
#import "SakuraAnimationController.h"
#import "NemoScrollController.h"
#import "KVCFliterArrayController.h"
#import "NemoClockController.h"
#import "TransformController.h"
#import "CubicController.h"
#import "RotationYController.h"
#import "SpecialLayerController.h"
#import "DefaultAnimationController.h"
#import "ButterflyController.h"
#import "FingerDrawController.h"
@interface FirstController ()

@end

@implementation FirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)presentController:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 10:
        {
        [self.navigationController pushViewController:[AnimationSquareController new] animated:YES];
        }
            break;
        case 11:
        {
        [self.navigationController pushViewController:[PortraitController new] animated:YES];


        }
            break;
        case 12:
        {
        [self.navigationController pushViewController:[ViewDrewLearhController new] animated:YES];


        }
            break;
        case 13:
        {
        [self.navigationController pushViewController:[SakuraAnimationController new] animated:YES];


        }
            break;
        case 14:
        {
        NemoScrollController *scr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NemoScroll"];
        [self.navigationController pushViewController:scr animated:YES];


        }
            break;
        case 15:
        {
            KVCFliterArrayController *kvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"KVCFilter"];
            [self.navigationController pushViewController:kvc animated:YES];



        }
            break;
        case 16:
        {
        
        NemoClockController *clock = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Clock"];
        [self.navigationController pushViewController:clock animated:YES];
        }
            break;
        case 17:
        {
        TransformController *tra = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"transfrom"];
        [self.navigationController pushViewController:tra animated:YES];
        }
            break;
        case 18:
        {
        CubicController *cube = [[CubicController alloc]initWithNibName:@"CubicController" bundle:nil];
        [self.navigationController pushViewController:cube animated:YES];
        }
            break;
        case 19:
        {
        RotationYController *rotation = [[RotationYController alloc]initWithNibName:@"RotationYController" bundle:nil];
        [self.navigationController pushViewController:rotation animated:YES];
        }
            break;
        case 20:
        {
        SpecialLayerController *special = [[SpecialLayerController alloc]initWithNibName:@"SpecialLayerController" bundle:nil];
        [self.navigationController pushViewController:special animated:YES];
        }
            break;
        case 21:
        {
        DefaultAnimationController *defalut = [[DefaultAnimationController alloc]initWithNibName:@"DefaultAnimationController" bundle:nil];
        [self.navigationController pushViewController:defalut animated:YES];
        }
            break;
        case 22:
        {
        ButterflyController *butterfly = [[ButterflyController alloc]initWithNibName:@"ButterflyController" bundle:nil];
        [self.navigationController pushViewController:butterfly animated:YES];
        }
            break;
        case 23:
        {
        FingerDrawController *draw = [[FingerDrawController alloc]init];
        [self.navigationController pushViewController:draw animated:YES];
        }
            break;
        default:
            break;
    }
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
