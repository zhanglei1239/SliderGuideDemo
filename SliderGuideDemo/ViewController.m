//
//  ViewController.m
//  SliderGuideDemo
//
//  Created by Mac on 15/12/29.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "ViewController.h"
#import "ClipImageView.h"
@interface ViewController ()
{
    UIScrollView * guideScroll;
    NSMutableArray * dataArray;
    float SWidth;
    float SHeight;
    UIButton * btnGoin;
    ClipImageView * clipImage;
    UILabel * lblGoNextTip;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SWidth = [[UIScreen mainScreen] bounds].size.width;
    SHeight = [[UIScreen mainScreen] bounds].size.height;
    
    lblGoNextTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SWidth, 40)];
    [lblGoNextTip setText:@"这里应该就要进入应用内部了!"];
    [lblGoNextTip setTextAlignment:NSTextAlignmentCenter];
    lblGoNextTip.center = CGPointMake(SWidth/2, SHeight/2);
    [self.view addSubview:lblGoNextTip];
     
    dataArray = [NSMutableArray array];
    guideScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SWidth, SHeight)];
    guideScroll.pagingEnabled = YES;
    [self.view addSubview:guideScroll];
    
    [self initData];
    [self initScrollView];

}

-(void)initData{
    [dataArray addObject:@"guide_1"];
    [dataArray addObject:@"guide_2"];
    [dataArray addObject:@"guide_3"];
}

-(void)initScrollView{
    int count = 0;
    for (NSString * imgName in dataArray) {
        if (count == dataArray.count-1) {
            clipImage = [[ClipImageView alloc] initWithFrame:CGRectMake(count*SWidth, 0, SWidth, SHeight)];
            [clipImage clipImage:[UIImage imageNamed:imgName] backgroundImage:nil];
            clipImage.delegate = self;
            [guideScroll addSubview:clipImage];
            
            UIButton * btnClip = [[UIButton alloc] initWithFrame:CGRectMake(count*SWidth+(SWidth-100)/2, SHeight-90, 100, 40)];
            [btnClip addTarget:self action:@selector(clipImage:) forControlEvents:UIControlEventTouchUpInside];
            [guideScroll addSubview:btnClip];
        }else{
            UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(count*SWidth, 0, SWidth, SHeight)];
            [img setImage:[UIImage imageNamed:imgName]];
            [guideScroll addSubview:img];
        }
        count++;
    }
    [guideScroll setContentSize:CGSizeMake(count*SWidth, guideScroll.frame.size.height)];
}

-(void)clipImage:(id)sender{
    [clipImage clip];
}

-(void)ClipFinishCallBack:(ClipImageView *)clipImg{
    [guideScroll performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
