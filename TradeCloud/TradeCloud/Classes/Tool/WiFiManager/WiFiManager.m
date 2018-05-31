//
//  WiFiManager.m
//  TradeCloud
//
//  Created by zhangming on 2018/5/28.
//  Copyright © 2018年 zhangming. All rights reserved.
//

#import "WiFiManager.h"

#import<SystemConfiguration/CaptiveNetwork.h>

#import<SystemConfiguration/SystemConfiguration.h>

#import<CoreFoundation/CoreFoundation.h>

@implementation WiFiManager

+ (NSString *)GetWifiName{
    
    NSString *wifiName = @"Not Found";
    
    CFArrayRef myArray = CNCopySupportedInterfaces();
    
    if (myArray != nil) {
        
        CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        
        if (myDict != nil) {
            
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            
            wifiName = [dict valueForKey:@"SSID"];
            
        }
        
    }
    
    return wifiName;
}

@end
