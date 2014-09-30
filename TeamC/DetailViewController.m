//
//  DetailViewController.m
//  TeamC
//
//  Created by 海下直哉 on 2014/09/30.
//  Copyright (c) 2014年 meer07. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController (){
    UIScrollView *sv;
    UIImageView *imageView;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setScrollView{
    sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    sv.backgroundColor = [UIColor whiteColor];
}

@end
