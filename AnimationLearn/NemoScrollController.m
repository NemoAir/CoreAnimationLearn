//
//  NemoScrollController.m
//  AnimationLearn
//
//  Created by Nemo on 14/11/19.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "NemoScrollController.h"

@interface NemoScrollController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutletCollection(UISlider) NSArray *sliders;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *insetLabels;

@property (nonatomic, strong) UILabel *headerView;

@property (nonatomic, assign) BOOL isRefreshing;

@property (nonatomic, assign) NSInteger refreshCount;

@end

@implementation NemoScrollController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
  return  [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.scrollView.backgroundColor = [UIColor colorWithRed:1.000 green:0.733 blue:0.611 alpha:1.000];
    self.scrollView.delegate = self;
    self.isRefreshing = NO;
    self.refreshCount = 0;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds)+ 100);
    [self creatHeaderView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
}
- (void)keyboardDidShow:(NSNotification *)notif
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    CGFloat height = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, height, 0)];
}
- (void)keyboardDidHide:(NSNotification *)notif{
    [self hideKeyboard];
}
- (void)hideKeyboard
{

    for (UIGestureRecognizer *ges in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:ges];
    }
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];

    [self.view endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

 
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    NSValue *newvalue = change[NSKeyValueChangeNewKey];

    CGPoint point = [newvalue CGPointValue];
    NSLog(@"contentOffset:x=%.3f,y= %.3f",point.x,point.y );
//    if (point.y < -5) {
//        self.headerView.text = @"刷新中...";
//
//        [self performSelector:@selector(endRefresh) withObject:nil afterDelay:3.0f];
//    }
    if (!self.isRefreshing) {
        if (point.y < -30) {
            
            self.headerView.text = @"......";
            self.headerView.textAlignment = NSTextAlignmentCenter;
            self.headerView.textColor = [UIColor blackColor];

            if (point.y < - 50) {
                if (self.refreshCount%5 == 0 && self.refreshCount > 0) {
                    self.headerView.text = @"哎，你咋这么无聊呢...";
                    
                }else{
                    self.headerView.text = @"拉呀，再往下拉就刷给你看...";

                }
                self.headerView.textColor = [UIColor colorWithRed:0.938 green:0.238 blue:1.000 alpha:1.000];

            }
            if (point.y < -60) {
                self.refreshCount ++;
                self.headerView.text = @"刷牙，刷牙，好累啊...";
                self.headerView.textColor = [UIColor colorWithRed:0.617 green:0.234 blue:1.000 alpha:1.000];
                self.isRefreshing = YES;
                self.scrollView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
                
                [self performSelector:@selector(TriggerendRefresh) withObject:nil afterDelay:2.0f];

            }
            
        }
    }
}
-(void)TriggerendRefresh
{
  
    self.headerView.text = @"人家已经给你刷新完了哟...";
    [self performSelector:@selector(endRefresh) withObject:self afterDelay:0.5];
   
}
- (void)endRefresh{
    
    UISlider *slider;
    
    for (UISlider *sli in self.sliders) {
        if (sli.tag == 10) {
            slider = sli;
        }
    }
    [slider setValue:0 animated:YES];
    self.isRefreshing = NO;
    self.headerView.text = @"";
    [self sliderChanges:slider];
}
- (void)creatHeaderView{
    CGRect frame = CGRectMake(0, -60, CGRectGetWidth([UIScreen mainScreen].bounds), 60);
    self.headerView = [[UILabel alloc]initWithFrame:frame];
    self.headerView.textAlignment = NSTextAlignmentCenter;
    self.headerView.text = @"刷新中...";
    self.headerView.textColor = [UIColor colorWithRed:0.162 green:0.155 blue:0.623 alpha:1.000];
    self.headerView.backgroundColor = [UIColor colorWithRed:0.765 green:0.897 blue:1.000 alpha:1.000];
    [self.scrollView addSubview:self.headerView];
    

}
- (IBAction)sliderChanges:(UISlider *)sender {
    CGFloat value = sender.value;
    
    NSInteger index = [self.sliders indexOfObject:sender];
    
    UILabel *lable = self.insetLabels[index];
    lable.text = [NSString stringWithFormat:@"%f.3",value];
    UIEdgeInsets inset = self.scrollView.contentInset;
    switch (sender.tag) {
        case 10:
        {
        inset.top = value;
        }
            break;
        case 11:
        {
        inset.left = value;
        }
            break;
        case 12:
        {
        inset.bottom = value;
        }
            break;
        case 13:
        {
        inset.right = value;
        }
            break;
        default:
            break;
    }
    self.scrollView.contentInset = inset;

    
}

-(void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

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
