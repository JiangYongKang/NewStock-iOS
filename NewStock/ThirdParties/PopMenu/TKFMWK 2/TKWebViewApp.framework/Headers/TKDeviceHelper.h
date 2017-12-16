//
//  TKDeviceHelper.h
//  TKUtil
//
//  Created by liubao on 14-10-31.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKDevice.h"

//extern NSString *CTSettingCopyMyPhoneNumber();

#define TKIFPGA_NAMESTRING                @"iFPGA"

#define TKIPHONE_1G_NAMESTRING            @"iPhone 1G"
#define TKIPHONE_3G_NAMESTRING            @"iPhone 3G"
#define TKIPHONE_3GS_NAMESTRING           @"iPhone 3GS"
#define TKIPHONE_4_NAMESTRING             @"iPhone 4"
#define TKIPHONE_4S_NAMESTRING            @"iPhone 4S"
#define TKIPHONE_5_NAMESTRING             @"iPhone 5"
#define TKIPHONE_5C_NAMESTRING            @"iPhone 5C"
#define TKIPHONE_5S_NAMESTRING            @"iPhone 5S"
#define TKIPHONE_6_NAMESTRING             @"iPhone 6"
#define TKIPHONE_6PLUS_NAMESTRING         @"iPhone 6Plus"
#define TKIPHONE_6S_NAMESTRING            @"iPhone 6S"
#define TKIPHONE_6SPLUS_NAMESTRING        @"iPhone 6SPlus"
#define TKIPHONE_SE_NAMESTRING            @"iPhone SE"
#define TKIPHONE_7_NAMESTRING             @"iPhone 7"
#define TKIPHONE_7PLUS_NAMESTRING         @"iPhone 7Plus"

#define TKIPHONE_UNKNOWN_NAMESTRING       @"Unknown iPhone"

#define TKIPOD_1G_NAMESTRING              @"iPod touch 1G"
#define TKIPOD_2G_NAMESTRING              @"iPod touch 2G"
#define TKIPOD_3G_NAMESTRING              @"iPod touch 3G"
#define TKIPOD_4G_NAMESTRING              @"iPod touch 4G"
#define TKIPOD_5G_NAMESTRING              @"iPod touch 5G"
#define TKIPOD_6G_NAMESTRING              @"iPod touch 6G"
#define TKIPOD_7G_NAMESTRING              @"iPod touch 7G"
#define TKIPOD_8G_NAMESTRING              @"iPod touch 8G"
#define TKIPOD_9G_NAMESTRING              @"iPod touch 9G"
#define TKIPOD_UNKNOWN_NAMESTRING         @"Unknown iPod"

#define TKIPAD_1G_NAMESTRING              @"iPad 1G"
#define TKIPAD_2G_NAMESTRING              @"iPad 2G"
#define TKIPAD_3G_NAMESTRING              @"iPad 3G"
#define TKIPAD_4G_NAMESTRING              @"iPad 4G"
#define TKIPAD_5G_NAMESTRING              @"iPad 5G"
#define TKIPAD_6G_NAMESTRING              @"iPad 6G"
#define TKIPAD_7G_NAMESTRING              @"iPad 7G"
#define TKIPAD_8G_NAMESTRING              @"iPad 8G"
#define TKIPAD_9G_NAMESTRING              @"iPad 9G"
#define TKIPAD_UNKNOWN_NAMESTRING         @"Unknown iPad"

#define TKAPPLETV_2G_NAMESTRING           @"Apple TV 2G"
#define TKAPPLETV_3G_NAMESTRING           @"Apple TV 3G"
#define TKAPPLETV_4G_NAMESTRING           @"Apple TV 4G"
#define TKAPPLETV_UNKNOWN_NAMESTRING      @"Unknown Apple TV"

#define TKIOS_FAMILY_UNKNOWN_DEVICE       @"Unknown iOS device"

#define TKSIMULATOR_NAMESTRING            @"iPhone Simulator"
#define TKSIMULATOR_IPHONE_NAMESTRING     @"iPhone Simulator"
#define TKSIMULATOR_IPAD_NAMESTRING       @"iPad Simulator"
#define TKSIMULATOR_APPLETV_NAMESTRING    @"Apple TV Simulator"

//iPhone 3G 以后各代的CPU型号和频率
#define TKIPHONE_3G_CPUTYPE               @"ARM11"
#define TKIPHONE_3G_CPUFREQUENCY          @"416MHz"
#define TKIPHONE_3GS_CPUTYPE              @"ARM Cortex A8"
#define TKIPHONE_3GS_CPUFREQUENCY         @"660MHz"
#define TKIPHONE_4_CPUTYPE                @"Apple A4"
#define TKIPHONE_4_CPUFREQUENCY           @"1GHz"
#define TKIPHONE_4S_CPUTYPE               @"Apple A5 Double Core"
#define TKIPHONE_4S_CPUFREQUENCY          @"800MHz"
#define TKIPHONE_5_CPUTYPE                @"Apple A6 Double Core";
#define TKIPHONE_5_CPUFREQUENCY           @"1GHz"
#define TKIPHONE_5C_CPUTYPE               @"Apple A6 Double Core";
#define TKIPHONE_5C_CPUFREQUENCY          @"1GHz"
#define TKIPHONE_5S_CPUTYPE               @"Apple A7/M7 Double Core";
#define TKIPHONE_5S_CPUFREQUENCY          @"1.3GHz"
#define TKIPHONE_6_CPUTYPE                @"Apple A8/M8 Double Core";
#define TKIPHONE_6_CPUFREQUENCY           @"1.4GHz"
#define TKIPHONE_6Plus_CPUTYPE            @"Apple A8/M8 Double Core";
#define TKIPHONE_6Plus_CPUFREQUENCY       @"1.4GHz"
#define TKIPHONE_6S_CPUTYPE               @"Apple A9/M9 Double Core";
#define TKIPHONE_6S_CPUFREQUENCY          @"1.8GHz"
#define TKIPHONE_6SPlus_CPUTYPE           @"Apple A9/M9 Double Core";
#define TKIPHONE_6SPlus_CPUFREQUENCY      @"1.8GHz"
#define TKIPHONE_7_CPUTYPE                @"Apple A10/M10 Four Core";
#define TKIPHONE_7_CPUFREQUENCY           @"2.4GHz"
#define TKIPHONE_7Plus_CPUTYPE            @"Apple A10/M10 Four Core";
#define TKIPHONE_7Plus_CPUFREQUENCY       @"2.4GHz"

//iPod touch 4G 的CPU型号和频率
#define TKIPOD_4G_CPUTYPE                 @"Apple A4"
#define TKIPOD_4G_CPUFREQUENCY            @"800MHz"

#define TKIOS_CPUTYPE_UNKNOWN             @"Unknown CPU type"
#define TKIOS_CPUFREQUENCY_UNKNOWN        @"Unknown CPU frequency"

typedef enum {
    TKUIDeviceUnknown,
    
    TKUIDeviceSimulator,
    TKUIDeviceSimulatoriPhone,
    TKUIDeviceSimulatoriPad,
    TKUIDeviceSimulatorAppleTV,
    
    TKUIDevice1GiPhone,
    TKUIDevice3GiPhone,
    TKUIDevice3GSiPhone,
    TKUIDevice4iPhone,
    TKUIDevice4SiPhone,
    TKUIDevice5iPhone,
    TKUIDevice5CPhone,
    TKUIDevice5SPhone,
    TKUIDevice6iPhone,
    TKUIDevice6PlusPhone,
    TKUIDevice6SPhone,
    TKUIDevice6SPlusPhone,
    TKUIDeviceSEPhone,
    TKUIDevice7iPhone,
    TKUIDevice7PlusPhone,
    
    TKUIDevice1GiPod,
    TKUIDevice2GiPod,
    TKUIDevice3GiPod,
    TKUIDevice4GiPod,
    TKUIDevice5GiPod,
    TKUIDevice6GiPod,
    TKUIDevice7GiPod,
    TKUIDevice8GiPod,
    TKUIDevice9GiPod,
    
    TKUIDevice1GiPad,
    TKUIDevice2GiPad,
    TKUIDevice3GiPad,
    TKUIDevice4GiPad,
    TKUIDevice5GiPad,
    TKUIDevice6GiPad,
    TKUIDevice7GiPad,
    TKUIDevice8GiPad,
    TKUIDevice9GiPad,
    
    TKUIDeviceAppleTV2,
    TKUIDeviceAppleTV3,
    TKUIDeviceAppleTV4,
    
    TKUIDeviceUnknowniPhone,
    TKUIDeviceUnknowniPod,
    TKUIDeviceUnknowniPad,
    TKUIDeviceUnknownAppleTV,
    TKUIDeviceIFPGA,
    
} TKUIDevicePlatform;

typedef enum {
    TKUIDeviceFamilyiPhone,
    TKUIDeviceFamilyiPod,
    TKUIDeviceFamilyiPad,
    TKUIDeviceFamilyAppleTV,
    TKUIDeviceFamilyUnknown,
    
} TKUIDeviceFamily;

/**
 设备分辨率
 */
typedef enum {
    /**
     *  @author 刘宝, 2016-05-12 12:05:21
     *
     *  未知分辨率
     */
    TKUIDeviceResolution_Unknown = 0,
    /**
     *iPhone 1,3,3GS 标准分辨率(320x480px)
     */
    TKUIDeviceResolution_iPhone3      = 1,
    /**
     *iPhone 4,4S 高清分辨率(640x960px)
     */
    TKUIDeviceResolution_iPhone4      = 2,
    /**
     *iPhone 5,5s 高清分辨率(640x1136px)
     */
    TKUIDeviceResolution_iPhone5      = 3,
    /**
     *iPhone 6,6s 高清分辨率(750x1334px)
     */
    TKUIDeviceResolution_iPhone6      = 4,
    /**
     *iPhone 6Plus,6sPlus 高清分辨率(1080x1920px)
     */
    TKUIDeviceResolution_iPhone6Plus  = 5,
    /**
     * iPad 1,2 标准分辨率(1024x768px)
     */
    TKUIDevice_iPadStandardRes        = 20,
    /**
     * iPad 3 High Resolution(2048x1536px)
     */
    TKUIDevice_iPadHiRes              = 21
}TKUIDeviceResolution;


/**
 *  设备相关帮助类
 */
@interface TKDeviceHelper : NSObject

/**
 *  获取系统设备磁盘空间信息
 *
 *  @return 系统设备磁盘空间信息
 */
+(TKDeviceSpace *)getDeviceSpace;

/**
 *  获取设备电池量
 *
 *  @return 设备电池信息
 */
+(NSString *)getDeviceBatteryPer;

/**
 *  获取设备cpu的情况
 *
 *  @return 设备cpu的信息
 */
+(TKDeviceCpu *)getDeviceCpu;

/**
 *  获取设备内存的情况
 *
 *  @return 设备内存的信息
 */
+(TKDeviceMemory *)getDeviceMemory;

/**
 *  获取设备的唯一性id，这里取MAC地址,大于7.0的取identifierForVendor
 *
 *  @return 设备平台信息
 */
+(NSString *) getDeviceMac;

/**
 *  获取系统设备平台(系统自带的，没经过处理翻译)
 *
 *  @return 系统设备平台
 */
+(NSString *)getDevicePlatform;

/**
 *  获取平台类型
 *
 *  @return 获取平台类型
 */
+(TKUIDevicePlatform)getDevicePlatformType;

/**
 *  获取平台类型名称
 *
 *  @return 获取平台类型类型
 */
+(NSString *)getDevicePlatformInfo;

/**
 *  设备是否越狱
 *
 *  @return 是，否
 */
+ (BOOL) isDeviceJailBreak;

/**
 *  是否有蓝牙
 *
 *  @return 是，否
 */
+ (BOOL) isDeviceHasbluetooth;

/**
 *  获取总线的频率
 *
 *  @return 总线的频率
 */
+ (NSString *)getDeviceBusFrequency;

/**
 *  获取设备手机号
 *
 *  @return 手机号
 */
+ (NSString *)getDevicePhone;

/**
 *  获取当前设备的分辨率
 *
 *  @return 对应的分辨率类型
 */
+ (TKUIDeviceResolution)getDeviceResoluation;

/**
 *  获取当前设备的分辨率
 *
 *  @return 对应的分辨率类型
 */
+ (NSString *)getDeviceResoluationDescription;

/**
 *  获取设备的uuid
 *
 *  @return 获取设备的uuid
 */
+ (NSString *)getDeviceUUID;

/**
 *  获取系统版本号
 *
 *  @return 系统版本号
 */
+(NSString *)getDeviceSysVersion;

/**
 *  @author 刘宝, 2016-08-11 23:08:25
 *
 *  获取当前设备的语言
 *
 *  @return 系统语言
 */
+(NSString *)getDeviceSysLanguage;

@end
