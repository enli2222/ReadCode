//
//  ELTableViewCell.m
//  ReadCode
//
//  Created by enli on 2018/8/31.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "ELTableViewCell.h"
#import "Masonry.h"
@interface ELTableViewCell(){
    UILabel *lbTitle,*lbUrl,*lbPath;
    UIButton *btnDelete,*btnReload,*btnDetail;
    UIViewController *_parent;
}
@end

@implementation ELTableViewCell
@synthesize project = _project;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setProject:(ELProject *)project{
    _project = project;
    lbTitle.text = _project.title;
    lbUrl.text = _project.url;
    lbPath.text = _project.path;
}

-(instancetype)initWithController:(UIViewController *)vc  reuseIdentifier:(NSString *)reuseIdentifier;{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _parent = vc;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 25)];
//        lbTitle.font = [UIFont fontWithName:@"iconfont" size:24];
        lbTitle.text = @"名称";
        [self.contentView addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@5);
            make.left.equalTo(@5);
            make.width.mas_equalTo(self).offset(-10);
        }];
        lbUrl = [[UILabel alloc]initWithFrame:CGRectMake(5, 30, 100, 25)];
        lbUrl.text = @"URL";
        [self.contentView addSubview:lbUrl];
        [lbUrl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@30);
            make.left.equalTo(@5);
            make.width.mas_equalTo(self).offset(-10);
        }];
        lbPath = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, 100, 25)];
        lbPath.text = @"PATH";
        [self.contentView addSubview:lbPath];
        [lbPath mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@55);
            make.left.equalTo(@5);
            make.width.mas_equalTo(self).offset(-10);
        }];
        btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnDelete setTitle:@"删除" forState:UIControlStateNormal];
        [btnDelete setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [btnDelete setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btnDelete setBackgroundColor:[UIColor blueColor]];
        btnDelete.layer.cornerRadius = 5;
        btnDelete.layer.masksToBounds = YES;
        [btnDelete addTarget:_parent action:@selector(onDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnDelete];
        [btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@85);
            make.left.equalTo(@10);
            make.width.mas_equalTo(self.mas_width).offset(-20).multipliedBy(1.0/3);
            make.height.equalTo(@25);
        }];
        btnReload = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnReload setTitle:@"重新下载" forState:UIControlStateNormal];
        [btnReload setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [btnReload setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btnReload setBackgroundColor:[UIColor blueColor]];
        btnReload.layer.cornerRadius = 5;
        btnReload.layer.masksToBounds = YES;
        [btnReload addTarget:_parent action:@selector(onReloadClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnReload];
        [btnReload mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@85);
            make.left.mas_equalTo(self->btnDelete.mas_right).offset(20);
            make.width.mas_equalTo(self.mas_width).offset(-20).multipliedBy(1.0/3);
            make.height.equalTo(@25);
        }];
        btnDetail = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnDetail setTitle:@"详情" forState:UIControlStateNormal];
        [btnDetail setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [btnDetail setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btnDetail setBackgroundColor:[UIColor blueColor]];
        btnDetail.layer.cornerRadius = 5;
        btnDetail.layer.masksToBounds = YES;
        [btnDetail addTarget:_parent action:@selector(onDetailClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnDetail];
        [btnDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@85);
            make.left.mas_equalTo(self->btnReload.mas_right).offset(20);
            make.width.mas_equalTo(self.mas_width).offset(-20).multipliedBy(1.0/3);
            make.height.equalTo(@25);
        }];

    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    CGRect f = frame;
    f.origin.x = 10;
    f.origin.y = f.origin.y + 5;
    f.size.width = frame.size.width - 20;
    f.size.height = frame.size.height - 10;
    [super setFrame:f];
}

- (CATransform3D)transform3d{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 2.5 / -2000;
    return transform;
}

-(void)unfold:(BOOL)openFlag animated:(BOOL)animated completion:(void (^)(void))completion{
//    UIView * rotaionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
//    rotaionView.backgroundColor = [UIColor redColor];
//    rotaionView.layer.anchorPoint = CGPointMake(0.5, 0);
//    rotaionView.layer.transform = [self transform3d];
//    rotaionView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:rotaionView];
//    CABasicAnimation *ani = [[CABasicAnimation alloc]init];
//    ani.keyPath = @"transform.rotation.x";
//    ani.beginTime = 0.0;
//    ani.fromValue =[NSNumber numberWithFloat: M_PI  ];
//    ani.toValue = [NSNumber numberWithFloat: 0.0];
//    ani.duration = 1.5;
//    ani.repeatCount = 1;
////    ani.delegate = self;
//    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    [rotaionView.layer addAnimation:ani forKey:@"rotation.x"];
}

+(CGFloat)getCellHeight:(BOOL)openFlag{
    if (openFlag) {
        return 125;
    }else{
        return 68;
    }
}

@end
