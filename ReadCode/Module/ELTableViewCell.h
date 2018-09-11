//
//  ELTableViewCell.h
//  ReadCode
//
//  Created by enli on 2018/8/31.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELProject.h"

@interface ELTableViewCell : UITableViewCell

@property (nonatomic,strong)ELProject *project;

+(CGFloat)getCellHeight:(BOOL)openFlag;
-(instancetype)initWithController:(UIViewController *)vc reuseIdentifier:(NSString *)reuseIdentifier;
-(void)unfold:(BOOL)openFlag animated:(BOOL)animated completion:(void (^)(void))completion;

@end
