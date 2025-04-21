#ifndef common_h
#define common_h

#include <arpa/inet.h>
#include <dlfcn.h>
#include <ifaddrs.h>
#include <objc/runtime.h>
#include <os/log.h>
#include <spawn.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <unistd.h>

#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>
#import <IOKit/hid/IOHIDService.h>
#import <UIKit/UIKit.h>

#define NSLog2(FORMAT, ...) os_log(OS_LOG_DEFAULT,"%{public}@", [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])

#define PRODUCT         "ChargeLimiter"
#define GSERV_PORT      1230
#define TRACE           false
#define FLOAT_ORIGINX   100
#define FLOAT_ORIGINY   100
#define FLOAT_WIDTH     80
#define FLOAT_HEIGHT    60
#define log_prefix      @"ChargeLimiterLogger"

#define LOG_PATH        "/var/root/aldente.log"
#define CONF_PATH       "/var/root/aldente.conf"
#define DB_PATH         "/var/root/aldente.db"

#endif // common_h

