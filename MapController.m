//
//  MapController.m
//  TeamC
//
//  Created by 海下直哉 on 2014/09/30.
//  Copyright (c) 2014年 meer07. All rights reserved.
//

#import "MapController.h"

@implementation MapController

-(void)SetMapView:(CGSize)windowSize{
    mapview = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height)];
    [self.view addSubview:mapview];
}

@end
