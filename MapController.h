//
//  MapController.h
//  TeamC
//
//  Created by 海下直哉 on 2014/09/30.
//  Copyright (c) 2014年 meer07. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MapController : NSObject{
    MKMapView *mapview;
}

-(void)SetMapView;
@end
