//
//  DetailViewController.h
//  testArrributedString
//
//  Created by 地引秀和 on 2014/08/05.
//  Copyright (c) 2014年 Jibiki Wroks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
