//
//  KVCFliterArrayController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/19.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "KVCFliterArrayController.h"
@import ObjectiveC.runtime;
@interface KVCFliterArrayController ()
@property (nonatomic, strong) NSMutableArray *contanier;
@property (strong, nonatomic) IBOutlet UITextView *originData;
@property (strong, nonatomic) IBOutlet UITextView *distinctData;
@property (strong, nonatomic) IBOutlet UITextView *allData;
@end

@implementation KVCFliterArrayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contanier = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        UILabel *lable = [UILabel new];
        lable.text = @"wang";
        objc_setAssociatedObject(lable, @"name", @"wang", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.contanier addObject:lable];
    }
    for (int i = 0; i < 3; i++) {
        UILabel *lable = [UILabel new];
        lable.text = @"jie";
        objc_setAssociatedObject(lable, @"name", @"jie", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.contanier addObject:lable];
    }
    for (int i = 0; i < 2; i++) {
        UILabel *lable = [UILabel new];
        lable.text = @"nemo";
        objc_setAssociatedObject(lable, @"name", @"nemo", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.contanier addObject:lable];
    }
    for (int i = 0; i < 5; i++) {
        UILabel *lable = [UILabel new];
        lable.text = @"wang jie";
        objc_setAssociatedObject(lable, @"name", @"wang jie", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.contanier addObject:lable];
    }
    
    UITextView *textView = [[UITextView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:textView];
    NSMutableArray *namesArray = [NSMutableArray array];
    for (UILabel *lable in self.contanier) {
        NSString *name = objc_getAssociatedObject(lable, @"name");
        [namesArray addObject:name];
    }
    NSLog(@"namesArray:%@",namesArray);
    self.originData.text = [namesArray componentsJoinedByString:@","];
    
    NSArray *distinctUnionNameArray = [self.contanier valueForKeyPath:@"@distinctUnionOfObjects.text"];
    self.distinctData.text = [distinctUnionNameArray componentsJoinedByString:@","];
    NSLog(@"distinctUniomName:%@",distinctUnionNameArray);
    
    NSArray *unionNameArray = [self.contanier valueForKeyPath:@"@unionOfObjects.text"];
    self.allData.text = [unionNameArray componentsJoinedByString:@","];
    NSLog(@"unionName:%@",unionNameArray);
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
