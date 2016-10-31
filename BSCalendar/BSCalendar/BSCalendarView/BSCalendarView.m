//
//  BSCalendarView.m
//  BSCalendar
//
//  Created by 毕帅 on 2016/10/31.
//  Copyright © 2016年 毕帅. All rights reserved.
//

#import "BSCalendarView.h"
#import "CheckInCollectionViewCell.h"
#import "UIColor+Category.h"
#import "NSDate+Category.h"

@interface BSCalendarView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *calenderCollectionView;

@property (nonatomic, strong) NSArray *weekArr;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *today;

@end

@implementation BSCalendarView

static NSString *const reuseIdentifier = @"cell";

static NSString *const fontTitleColor_1 = @"#333333";
static NSString *const fontTitleColor_2 = @"#666666";
static NSString *const fontTitleColor_3 = @"#999999";

- (void)drawRect:(CGRect)rect {
    
    self.frame = [[UIScreen mainScreen] bounds];
    [self setupView];
    
}

- (void)setupView {
    
    [self setupCalenderCollectionView];
}

// 设置label显示不同样式
- (void)settingLabel {
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.centerLabel.text];
    NSRange startRange = [self.centerLabel.text rangeOfString:@"年"];
    NSRange endRange = [self.centerLabel.text rangeOfString:@"月"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:fontTitleColor_3] range:NSMakeRange(0, self.centerLabel.text.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.f] range:NSMakeRange(0, self.centerLabel.text.length)];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:fontTitleColor_1] range:range];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f] range:range];
    self.centerLabel.attributedText = str;
}

- (void)setupCalenderCollectionView {
    self.calenderCollectionView.delegate = self;
    self.calenderCollectionView.dataSource = self;
    [self.calenderCollectionView registerNib:[UINib nibWithNibName:@"CheckInCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.today = [NSDate date];
    self.date = self.today;
    self.centerLabel.text = [NSString stringWithFormat:@"%ld年%ld月", [self.date dateWithYear], [self.date dateWithMonth]];
    [self settingLabel];
}

#pragma mark - 按钮点击事件
- (IBAction)btnAction:(id)sender {
    UIButton *btn  = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
        {
            [UIView transitionWithView:self.calenderCollectionView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                self.date = [self.date dateWithLastMonth];
                self.centerLabel.text = [NSString stringWithFormat:@"%ld年%ld月", [self.date dateWithYear], [self.date dateWithMonth]];
                [self.calenderCollectionView reloadData];
            } completion:nil];
        }
            break;
        case 2:
        {
            [UIView transitionWithView:self.calenderCollectionView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                self.date = [self.date dateWithNextMonth];
                self.centerLabel.text = [NSString stringWithFormat:@"%ld年%ld月", [self.date dateWithYear], [self.date dateWithMonth]];
                [self.calenderCollectionView reloadData];
            } completion:nil];
        }
            break;
            
        default:
            break;
    }
    [self settingLabel];
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((collectionView.frame.size.width - 1) / 7, 29);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 7;
    } else {
        return 42;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CheckInCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.titleLabel.font = [UIFont systemFontOfSize:11];
        cell.titleLabel.text = self.weekArr[indexPath.row];
        cell.titleLabel.textColor = [UIColor colorWithHexString:fontTitleColor_3];
    }else {
        cell.titleLabel.font = [UIFont systemFontOfSize:14];
        //        cell.titleLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
        NSInteger daysInThisMonth = [self.date dateWithTotaldaysInThisMonth];
        NSInteger firstWeekDay = [self.date dateWithFirstWeekdayInThisMonth];
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i < firstWeekDay || i > firstWeekDay + daysInThisMonth - 1) {
            cell.titleLabel.text = @"";
        } else {
            day = i - firstWeekDay + 1;
            cell.titleLabel.text = [NSString stringWithFormat:@"%ld", day];
            
            cell.titleLabel.textColor = [UIColor colorWithHexString:fontTitleColor_1];
            // 本月
            if ([self.today dateWithYear] == [self.date dateWithYear] && [self.today dateWithMonth] == [self.date dateWithMonth]) {
                // 今天
                if (day == [self.today dateWithDay]) {
                    cell.titleLabel.textColor = [UIColor redColor];
                    // 本月今天之后
                } else if (day > [self.today dateWithDay]) {
                    cell.titleLabel.textColor = [UIColor colorWithHexString:fontTitleColor_3];
                }
                // 本月之后的日子
            } else if ([self.today compare:self.date] == NSOrderedAscending) {
                cell.titleLabel.textColor = [UIColor colorWithHexString:fontTitleColor_3];
            }
        }
    }
    return cell;
    
}

#pragma mark - lazy load
- (NSArray *)weekArr {
    if (!_weekArr) {
        _weekArr = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    }
    return _weekArr;
}

@end
