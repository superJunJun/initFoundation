//
//  LJLocationHelper.m
//  iShanggang
//
//  Created by  bxf on 2017/6/10.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import "LJLocationHelper.h"
#import "ISGLocationInfoModel.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface LJLocationHelper ()<BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>
{
    BMKGeoCodeSearch *_geoCodeSearch;
    BMKReverseGeoCodeSearchOption *_reverseGeoCodeOption;
}
@property (nonatomic, strong) BMKLocationService* locService;

@end

@implementation LJLocationHelper

- (id)init {
    
    if (self == [super init]) {
        
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
    }
    return self;
}

#pragma mark - BMKLocationServiceDelegate

- (void)startLocation {
    
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
}

/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser {
    NSLog(@"start location");
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser {
    NSLog(@"stop location");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    if (userLocation.location) {
        [_locService stopUserLocationService];
    }
    
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate= userLocation.location.coordinate;

    NSLog(@"latitude == %f longitude == %f",MapCoordinate.latitude,MapCoordinate.longitude);
    if (_geoCodeSearch==nil) {
        //初始化地理编码类
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
    }
    if (_reverseGeoCodeOption==nil) {
        //初始化反地理编码类
        _reverseGeoCodeOption= [[BMKReverseGeoCodeSearchOption alloc] init];
    }
    //需要逆地理编码的坐标位置
    _reverseGeoCodeOption.location = MapCoordinate;
    [_geoCodeSearch reverseGeoCode:_reverseGeoCodeOption];
    
    [ISGLocationInfoModel sharedInstance].longitude = [NSString stringWithFormat:@"%f",MapCoordinate.longitude];
    [ISGLocationInfoModel sharedInstance].latitude = [NSString stringWithFormat:@"%f",MapCoordinate.latitude];
    
    [[NSUserDefaults standardUserDefaults] setObject:@(MapCoordinate.longitude) forKey:@"location_longitude"];
    [[NSUserDefaults standardUserDefaults] setObject:@(MapCoordinate.latitude) forKey:@"location_latitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 代理方法返回反地理编码结果

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (result) {
        BMKAddressComponent *addressDetail = result.addressDetail;
         //获取城市
         NSString *province = addressDetail.province;
         NSString *city = addressDetail.city;
         NSString *area = addressDetail.district;
         NSString *address = result.address;

         [ISGLocationInfoModel sharedInstance].province = province;
         [ISGLocationInfoModel sharedInstance].city = city;
         [ISGLocationInfoModel sharedInstance].area = area;
         [ISGLocationInfoModel sharedInstance].address = address;
        
        // fixMe: 临时方案，pod 中 cordova CDVUIWebViewDelegate 要使用这个位置信息。
        [[NSUserDefaults standardUserDefaults] setObject:province forKey:@"location_province"];
        [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"location_city"];
        [[NSUserDefaults standardUserDefaults] setObject:area forKey:@"location_area"];
        [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"location_address"];
        [[NSUserDefaults standardUserDefaults] synchronize];

         if ([self.delegate respondsToSelector:@selector(locationHelper:successWithModel:)]) {
             [self.delegate locationHelper:self successWithModel:[ISGLocationInfoModel sharedInstance]];
         }
    }
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"location fail");
}

#pragma mark - dealloc
- (void)dealloc {
    _locService.delegate = nil;
}


@end
