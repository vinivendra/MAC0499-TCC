
#ifndef Project___ObjC_UI_Exports_h
#define Project___ObjC_UI_Exports_h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol UIButtonExport <JSExport>
+ (instancetype)create;
@property (nonatomic, strong) id position;
//
@property (nonatomic, strong) NSString *string;
@end

@protocol UISliderExport <JSExport>
+ (instancetype)create;
@property (nonatomic, strong) id position;
//
@property (nonatomic) float value;
@property (nonatomic) float minimumValue;
@property (nonatomic) float maximumValue;
@end

@protocol UILabelExport <JSExport>
+ (instancetype)create;
@property (nonatomic, strong) id position;
//
@property(nonatomic, copy) NSString *text;
@property (nonatomic) NSTextAlignment alignment;
@end



@interface UIView (Export)
@property (nonatomic, strong) id position;
@end

@interface UIButton (Export) <UIButtonExport>
+ (instancetype)create;
//
@property (nonatomic, strong) NSString *string;
@end

@interface UISlider (Export) <UISliderExport>
+ (instancetype)create;
//
@end

@interface UILabel (Export) <UILabelExport>
+ (instancetype)create;
//
@property (nonatomic) NSTextAlignment alignment;
@end


#endif
