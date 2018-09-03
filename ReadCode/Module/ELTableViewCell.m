//
//  ELTableViewCell.m
//  ReadCode
//
//  Created by enli on 2018/8/31.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "ELTableViewCell.h"

@implementation ELTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    CGRect f = frame;
    f.origin.x = 10;
    f.origin.y = f.origin.y + 6;
    f.size.width = frame.size.width - 20;
    f.size.height = frame.size.height - 12;
    [super setFrame:f];
}

@end
