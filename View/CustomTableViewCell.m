//
//  CustomTableViewCell.m
//  MJRefreshTestDemo
//
//  Created by wxj on 2019/2/21.
//  Copyright © 2019年 zkml－wxj. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell(){
    UILabel *addressLabel;
}
@end

@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        KWS(ws);
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor purpleColor];
        [ws.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView).offset(24);
            make.left.equalTo(ws.contentView).offset(24);
            make.right.equalTo(ws.contentView).offset(-24);
            make.bottom.equalTo(ws.contentView).offset(-24);
        }];
        
        addressLabel = [[UILabel alloc]init];
        addressLabel.numberOfLines = 0;
        addressLabel.backgroundColor = [UIColor greenColor];
        [bgView addSubview:addressLabel];
        [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(48);
            make.left.equalTo(bgView).offset(24);
            make.right.equalTo(bgView).offset(-24);
        }];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(addressLabel.mas_bottom).offset(48);
        }];
    }
    return self;
}

- (void)setModel:(CustomTableViewModel *)model{
    _model = model;
    addressLabel.text = model.address;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
