//
//  CustomTableViewCell.h
//  MJRefreshTestDemo
//
//  Created by wxj on 2019/2/21.
//  Copyright © 2019年 zkml－wxj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewModel.h"

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic,copy) CustomTableViewModel *model;

@end
