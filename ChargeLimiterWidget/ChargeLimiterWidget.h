#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChargeLimiterWidgetView : UIView
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIButton *toggleButton;
@end

@interface ChargeLimiterWidgetProvider : NSObject
+ (void)reloadWidget;
@end

@interface ChargeLimiterWidget : NSObject
+ (void)initialize;
@end

NS_ASSUME_NONNULL_END 