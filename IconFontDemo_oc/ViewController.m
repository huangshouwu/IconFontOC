//
//  ViewController.m
//  IconFontDemo_oc
//
//  Created by huang shervin on 2019/5/8.
//  Copyright © 2019年 huang shervin. All rights reserved.
//

#import "ViewController.h"
#import "SGTIconFontManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray* labelIconName = @[@"check-circle",@"CI",@"Dollar",@"compass"];
    CGFloat labelBottom = 150;
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, labelBottom+10, [UIScreen mainScreen].bounds.size.width, 30)];//UILabel.init(frame: CGRect.init(x: 20, y: labelBottom+10, width: UIScreen.main.bounds.size.width-40, height: 30));
    titleLabel.font = [UIFont systemFontOfSize:30];//UIFont.systemFont(ofSize: 40);
    titleLabel.text = @"这是OC版本的IconFont";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    labelBottom = CGRectGetMaxY(titleLabel.frame) + 20;
    
    for (NSInteger i= 0;i<labelIconName.count;i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, labelBottom + 10, [UIScreen mainScreen].bounds.size.width -40, 30)];
        label.font = [UIFont fontWithName:[SGTIconFontManager fontName] size:20];
        label.text = [NSString stringWithFormat:@"这是一个 %@ iconfont文本",[SGTIconFontManager iconFontName:labelIconName[i]]];
        [self.view addSubview:label];
        labelBottom = CGRectGetMaxY(label.frame);
    }
    
    NSArray* imageIconName = @[@"icon4",@"icon7_hover",@"icon10",@"icon12"];
    labelBottom += 20;
    for (NSInteger i = 0; i<imageIconName.count; i++) {
        UIImageView* image1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, labelBottom + 10, 30, 30)];
        image1.image = [SGTIconFontManager iconFontName:imageIconName[i] size:30 color:UIColor.orangeColor];
        [self.view addSubview:image1];
        
        UIImageView* image2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image1.frame) + 20, CGRectGetMinY(image1.frame), CGRectGetWidth(image1.frame), CGRectGetHeight(image1.frame))];
        image2.image = [SGTIconFontManager iconFontName:imageIconName[i] size:30 color:UIColor.redColor];
        [self.view addSubview:image2];
        
        UIImageView* image3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(image2.frame) + 20, CGRectGetMinY(image1.frame), CGRectGetWidth(image1.frame), CGRectGetHeight(image1.frame))];
        image3.image = [SGTIconFontManager iconFontName:imageIconName[i] size:30 color:UIColor.blueColor];
        [self.view addSubview:image3];
        
        labelBottom = CGRectGetMaxY(image1.frame);
    }
}


@end
