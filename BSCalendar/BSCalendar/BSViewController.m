//
//  BSViewController.m
//  BSCalendar
//
//  Created by 毕帅 on 2016/10/31.
//  Copyright © 2016年 毕帅. All rights reserved.
//

#import "BSViewController.h"
#import "BSCalendarView.h"

@interface BSViewController ()

@end

@implementation BSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"日历by骗人的孩纸";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
    
    BSCalendarView *calendarView = [[[NSBundle mainBundle] loadNibNamed:@"BSCalendarView" owner:nil options:nil] lastObject];
    UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
    [myWindow addSubview:calendarView];
    
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
