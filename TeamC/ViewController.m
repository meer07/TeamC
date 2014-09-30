//
//  ViewController.m
//  TeamC
//
//  Created by 海下直哉 on 2014/09/30.
//  Copyright (c) 2014年 meer07. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>
@end

@implementation ViewController{
    CGSize windowSize;
    MKMapView *mapview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    windowSize = [[UIScreen mainScreen] bounds].size;
    [self setMapView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMapView{
    mapview = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height)];
    [self.view addSubview:mapview];
    
    [self setMapRegion];
    [self.view addSubview:mapview];
}

-(void)setMapRegion{
    MKCoordinateRegion cr = mapview.region;
    //cr.center = co
    cr.span.latitudeDelta = 0.5;
    cr.span.longitudeDelta = 0.5;
    [mapview setRegion:cr animated:NO];
}
@end
