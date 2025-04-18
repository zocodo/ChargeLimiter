#import "ChargeLimiterWidget.h"

@implementation ChargeLimiterWidgetView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    
    // 状态标签
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.textColor = [UIColor whiteColor];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.statusLabel];
    
    // 开关按钮
    self.toggleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.toggleButton setTitle:@"开关" forState:UIControlStateNormal];
    [self.toggleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.toggleButton addTarget:self action:@selector(toggleButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.toggleButton];
    
    // 布局
    self.statusLabel.frame = CGRectMake(10, 10, self.bounds.size.width - 20, 20);
    self.toggleButton.frame = CGRectMake(10, 40, self.bounds.size.width - 20, 30);
}

- (void)toggleButtonTapped {
    // 通过 URL Scheme 触发主应用的操作
    NSURL *url = [NSURL URLWithString:@"cl:///toggle"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

@end

@implementation ChargeLimiterWidgetProvider

+ (void)reloadWidget {
    // 通知系统重新加载 Widget
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
                                       CFSTR("com.apple.widgetkit.reload"),
                                       NULL,
                                       NULL,
                                       YES);
}

@end

@implementation ChargeLimiterWidget

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 设置解锁监听
        [self setupUnlockMonitor];
    });
}

+ (void)setupUnlockMonitor {
    CFNotificationCenterRef center = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver((__bridge const void *)self,
                                   center,
                                   (CFNotificationCallback)handleUnlockNotification,
                                   CFSTR("com.apple.springboard.lockstate"),
                                   NULL,
                                   CFNotificationSuspensionBehaviorDeliverImmediately);
}

static void handleUnlockNotification(CFNotificationCenterRef center,
                                   void *observer,
                                   CFStringRef name,
                                   const void *object,
                                   CFDictionaryRef userInfo) {
    static BOOL hasLaunched = NO;
    if (!hasLaunched) {
        hasLaunched = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *url = [NSURL URLWithString:@"cl:///"];
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        });
    }
}

@end 