//
//  DetailViewController.h
//  ReadCode
//
//  Created by 周鹏 on 2018/8/21.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELProject.h"

@interface DetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
-(instancetype)initWithProject:(ELProject *)project;
@end
