//
//  ViewController.m
//  TeamC
//
//  Created by 海下直哉 on 2014/09/30.
//  Copyright (c) 2014年 meer07. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <NTYCSVTable.h>

@interface ViewController ()<MKMapViewDelegate,UISearchBarDelegate>
@end

@implementation ViewController{
    CLLocationManager *locationManager;
    NSMutableArray *teien,*musium,*jizou;
    UISearchBar *searchBar;
    CGSize windowSize;
    MKMapView *mapview;
    NSString *searchword;
    float longitude,latitude;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    /* GPSの利用 */
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    
    //位置情報取得開始
    [locationManager startUpdatingLocation];
    
    windowSize = [[UIScreen mainScreen] bounds].size;
    [self setMapView];
    [self SetSearchBar];
    teien = [self getDataFromCSV:@"teien"];
    musium = [self getDataFromCSV:@"musium"];
    jizou = [self getDataFromCSV:@"jizou"];
    
    [self setPinOn:teien];
}

-(NSMutableArray *)getDataFromCSV:(NSString *)csvFileName
{
    // CSVファイルからセクションデータを取得する
    NSString *csvFile = [[NSBundle mainBundle] pathForResource:csvFileName ofType:@"csv"];
    NSData *csvData = [NSData dataWithContentsOfFile:csvFile];
    NSString *csv = [[NSString alloc] initWithData:csvData encoding:NSUTF8StringEncoding];
    
    NSScanner *scanner = [NSScanner scannerWithString:csv];
    // 改行文字の選定
    NSCharacterSet *chSet = [NSCharacterSet newlineCharacterSet];
    NSString *line;
    
    // レコードを入れる NSMutableArray
    NSMutableArray *row = [NSMutableArray array];
    
    while (![scanner isAtEnd]) {
        // 一行づつ読み込んでいく
        [scanner scanUpToCharactersFromSet:chSet intoString:&line];
        NSArray *array = [line componentsSeparatedByString:@","];
        [row addObject:array];
        
        // 改行文字をスキップ
        [scanner scanCharactersFromSet:chSet intoString:NULL];
    }
    return row;
}

/*処理*/
//取得したとき
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    longitude = newLocation.coordinate.longitude;
    latitude = newLocation.coordinate.latitude;
    
    NSLog(@"%f",newLocation.coordinate.longitude);
    NSLog(@"%f",newLocation.coordinate.latitude);
}

//位置取得失敗
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //エラーに応じてUIAlertを提示
    if (error) {
        NSString* message = nil;
        if ([error code] == kCLErrorDenied) {
            [locationManager stopUpdatingLocation]; message = [NSString stringWithFormat:@"このアプリは位置情報サービスが許可されていません。"];
        } else {
            message = [NSString stringWithFormat:@"位置情報の取得に失敗しました。"];
        }
        if (message != nil) {
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMapView{
    mapview = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height)];
    mapview.showsUserLocation = YES;
    [mapview setUserTrackingMode:MKUserTrackingModeFollow];
    [self setMapRegion];
    [self.view addSubview:mapview];
}

-(void)setMapRegion{
    MKCoordinateRegion cr = mapview.region;
    cr.span.latitudeDelta = 0.5;
    cr.span.longitudeDelta = 0.5;
    [mapview setRegion:cr animated:NO];
}

-(void)SetSearchBar{
    searchBar = [[UISearchBar alloc] init];
    //id view = [searchBar.subviews objectAtIndex:0];
    //[view setHidden:YES];
    searchBar.delegate = self;
    searchBar.keyboardType = UIKeyboardTypeDefault;
    searchBar.showsCancelButton = YES;
    searchBar.barStyle = UIBarStyleDefault;
    //searchBar.tintColor = [UIColor clearColor];
    searchBar.frame = CGRectMake(0, 0, 320, 60);
    [self.view addSubview:searchBar];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *) searchText {
    searchword = searchText;
    NSLog(@"%@",searchword);
}

-(void)searchBarCancelButtonClicked:(UISearchBar*)searchBar{
    [searchBar resignFirstResponder];
}

-(void)setPinOn:(NSMutableArray *)array{
    for (int i = 1; i < array.count; i++) {
        NSMutableArray *dataArray = (NSMutableArray *)array[i];
        MKPointAnnotation *pin = [MKPointAnnotation new];
        pin.title = (NSString *)dataArray[1];
        float longitude = ((NSString *)dataArray[3]).floatValue;
        float latitude = ((NSString *)dataArray[4]).floatValue;
        pin.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        [mapview addAnnotation:pin];
    }
}
@end
