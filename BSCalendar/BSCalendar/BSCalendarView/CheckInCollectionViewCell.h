//
//  CheckInCollectionViewCell.h
//  LoveClimbPet
//
//  Created by 毕帅 on 2016/10/29.
//  Copyright © 2016年 毕帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckInCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) BOOL isCheckIn;

@end
