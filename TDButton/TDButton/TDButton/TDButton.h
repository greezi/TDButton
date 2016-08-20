//
//  TDButton.h
//

#import <UIKit/UIKit.h>

@interface TDButton : UIButton

@end


/* 图标在上，文本在下按钮的图文间隔比例（0-1），默认0.3 */
#define TD_ButtonTopRadio 0.3
/* 图标在下，文本在上按钮的图文间隔比例（0-1），默认0.3 */
#define TD_ButtonBottomRadio 0.3

typedef enum{
    TDAligenmentStyleNormal,    // 默认(图片左,文字右)
    TDAligenmentStyleLeft,      // 左对齐(文字左,图片右)
    TDAligenmentStyleCenter,    // 居中对齐(文字左,图片右)
    TDAligenmentStyleRight,     // 右对齐(文字左,图片右)
    TDAligenmentStyleTop,       // 图片上，文字下(居中对齐)
    TDAligenmentStyleBottom,    // 文字上，图片下(居中对齐)
}TDAligenmentStyle;

typedef void(^ClickBlock)();

@interface TDCustomButton : UIButton
/*---------------------常规属性-------------------------*/
/** 设置样式 */
@property (nonatomic, assign) TDAligenmentStyle buttonStyle;
/** 设置圆角 */
@property (nonatomic, assign) CGFloat buttonCornerRadius;
/** 是否启用高亮状态(默认启用) */
@property (nonatomic, assign) BOOL canHeightlight;

/*------------以下属性是缩放动画需要的属性------------*/
/** 需要执行的block */
@property (nonatomic, copy, nonnull) ClickBlock clickBlock;
/** 缩小的比率，小于=1.0,大于0.0 */
@property (nonatomic, assign) CGFloat buttonScale;

/*----------------------构造方法------------------------*/

+ (instancetype _Nonnull)TD_ShareButton;
/**
 *  根据样式初始化按钮
 *
 *  @param style 样式
 *
 *  @return 按钮
 */
- (instancetype _Nonnull)initWitAligenmentStyle:(TDAligenmentStyle)style;
/**
 *  糯米动画效果Button <注意：此方法按下去无论如何都会执行block>
 *
 *  @param style     样式
 *  @param tempBlock 需要执行的block
 *
 *  @return 按钮
 */
- (instancetype _Nonnull)initWitAligenmentStyle:(TDAligenmentStyle)style andBlock:(nonnull ClickBlock)tempBlock;
/**
 *   糯米动画效果Button <注意：此方法按当坐标移动到按钮之外会取消执行block>
 *
 *  @param style     样式
 *  @param tempBlock 需要执行的block
 *
 *  @return 按钮
 */
- (instancetype _Nonnull)initWitAligenmentStyleOutsideCancel:(TDAligenmentStyle)style andBlock:(nonnull ClickBlock)tempBlock;
/**
 *  根据样式初始化按钮并设置边框宽度
 *
 *  @param style   样式
 *  @param borderw 边框宽度
 *
 *  @return 按钮
 */
- (instancetype _Nonnull)initWitAligenmentStyle:(TDAligenmentStyle)style borderW:(CGFloat)borderw;
/**
 *  根据样式初始化按钮并设置边框宽度和边框颜色
 *
 *  @param style   样式
 *  @param borderw 边框宽度
 *  @param color   边框颜色
 *
 *  @return 按钮
 */
- (instancetype _Nonnull)initWitAligenmentStyle:(TDAligenmentStyle)style borderW:(CGFloat)borderw borderColor:(nonnull UIColor *)color;

@end