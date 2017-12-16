//
//  TKDevice.h
//  TKUtil_V1
//
//  Created by liubao on 14-11-10.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynModel.h"

/**
 *  系统设备空间
 */
@interface TKDeviceSpace :DynModel
/**
 *  总共磁盘空间
 */
@property (nonatomic,copy)NSString *totalSpace;

/**
 *  空闲磁盘空间
 */
@property (nonatomic,copy)NSString *freeSpace;

/**
 *  已用磁盘空间
 */
@property (nonatomic,copy)NSString *useSpace;

/**
 *  空闲磁盘空间百分比
 */
@property (nonatomic,copy)NSString *freeSpacePer;

/**
 *  已用磁盘空间百分比
 */
@property (nonatomic,copy)NSString *useSpacePer;

@end

/**
 *  系统设备电池
 */
@interface TKDeviceBattery : DynModel

/**
 *当前电池量
 */
@property (nonatomic,copy)NSString *curCapacity;

/**
 *  最大电池量
 */
@property (nonatomic,copy)NSString *maxCapacity;

/**
 *  空余电池量
 */
@property (nonatomic,copy)NSString *freeCapacity;

@end

/**
 *  系统设备CPU
 */
@interface TKDeviceCpu : DynModel

/**
 *  cpu频率
 */
@property (nonatomic,copy)NSString *cpuFrequency;

/**
 *  cpu类型
 */
@property (nonatomic,copy)NSString *cpuType;

/**
 *  cpu数目
 */
@property (nonatomic,assign)NSInteger cpuNum;

/**
 *  各个cpu的利用率
 */
@property (nonatomic,retain)NSArray *cpuUse;

@end


/**
 *  系统设备内存
 */
@interface TKDeviceMemory : DynModel

/**
 *总共内存
 */
@property (nonatomic,copy)NSString *totalMemory;

/**
 *  使用内存
 */
@property (nonatomic,copy)NSString *useMemory;

/**
 *  空闲内存
 */
@property (nonatomic,copy)NSString *freeMemory;

/**
 *  使用内存百分比
 */
@property (nonatomic,copy)NSString *useMemoryPer;

/**
 *  空闲内存百分比
 */
@property (nonatomic,copy)NSString *freeMemoryPer;

@end
