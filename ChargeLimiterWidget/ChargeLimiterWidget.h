#import <WidgetKit/WidgetKit.h>
#import <UIKit/UIKit.h>

@interface ChargeLimiterWidgetProvider : NSObject <WidgetProvider>
@end

@interface ChargeLimiterWidgetView : UIView
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIButton *toggleButton;
@end

@interface ChargeLimiterWidget : NSObject
+ (void)initialize;
@end 