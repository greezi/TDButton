//
//  TDButton.m
//

#import "TDButton.h"

@implementation TDButton

@end

/* 按钮中文本和图片的间隔 */
#define TD_padding 5
/* 按钮的大小 */
#define TD_btnWidth       self.bounds.size.width
#define TD_btnHeight      self.bounds.size.height
/* 按钮中UILabel文本的大小 */
#define TD_labelWidth     self.titleLabel.bounds.size.width
#define TD_labelHeight    self.titleLabel.bounds.size.height
/* 按钮中image图标的大小 */
#define TD_imageWidth     self.imageView.bounds.size.width
#define TD_imageHeight    self.imageView.bounds.size.height

#define animateDelay 0.12    //默认动画执行时间
#define defaultScale 0.8    //默认缩小的比率


@implementation TDCustomButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        _canHeightlight = YES;
    }
    return self;
}

- (BOOL)isCanHeightlight {
    return self.canHeightlight;
}

-(void)setHighlighted:(BOOL)highlighted {
    if (_canHeightlight) {
        [super setHighlighted:highlighted];
    }
}


+ (instancetype)TD_ShareButton
{
    static TDCustomButton *TDButton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TDButton = [[TDCustomButton alloc] init];
    });
    return TDButton;
}

- (instancetype)initWitAligenmentStyle:(TDAligenmentStyle)style
{
    TDCustomButton *button = [[TDCustomButton alloc] init];
    button.buttonStyle = style;
    return button;
}

- (instancetype _Nonnull)initWitAligenmentStyle:(TDAligenmentStyle)style andBlock:(nonnull ClickBlock)tempBlock {
    TDCustomButton *button = [[TDCustomButton alloc] init];
    button.buttonStyle = style;
    
    [button addTarget:button action:@selector(pressedEvent:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:button action:@selector(unpressedEvent:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    button.clickBlock = tempBlock;
    
    return button;
}

- (instancetype _Nonnull)initWitAligenmentStyleOutsideCancel:(TDAligenmentStyle)style andBlock:(nonnull ClickBlock)tempBlock {
    TDCustomButton *button = [[TDCustomButton alloc] init];
    button.buttonStyle = style;
    
    [button addTarget:button action:@selector(pressedEvent:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:button action:@selector(cancelEvent:) forControlEvents:UIControlEventTouchUpOutside];
    [button addTarget:button action:@selector(unpressedEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.clickBlock = tempBlock;
    
    return button;
}


- (instancetype _Nonnull)initWitAligenmentStyle:(TDAligenmentStyle)style borderW:(CGFloat)borderw {
    TDCustomButton *button = [[TDCustomButton alloc] init];
    button.buttonStyle = style;
    button.layer.borderWidth = borderw;
    return button;
}

- (instancetype _Nonnull)initWitAligenmentStyle:(TDAligenmentStyle)style borderW:(CGFloat)borderw borderColor:(UIColor *)color{
    TDCustomButton *button = [[TDCustomButton alloc] init];
    button.buttonStyle = style;
    button.layer.borderWidth = borderw;
    button.layer.borderColor = color.CGColor;
    return button;
}


- (void)setButtonStyle:(TDAligenmentStyle)buttonStyle
{
    _buttonStyle = buttonStyle;
}

#pragma mark - 计算文本的的宽度
- (CGRect)getTitleLabelWith
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    return frame;
}

#pragma mark - 左对齐
- (void)alignmentLeft
{
    //    获得按钮的文本的frame
    CGRect titleFrame = self.titleLabel.frame;
    //    设置按钮的文本的x坐标为1-－－左对齐
    titleFrame.origin.x = 1;
    //    获得按钮的图片的frame
    CGRect imageFrame = self.imageView.frame;
    //    设置按钮的图片的x坐标紧跟文本的后面
    imageFrame.origin.x = CGRectGetWidth(titleFrame) ;
    
    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
}

#pragma mark - 右对齐【文字在左，图片在右】
- (void)alignmentRight
{
    CGRect frame = [self getTitleLabelWith];
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.x = TD_btnWidth - TD_imageWidth - 1;
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = imageFrame.origin.x - frame.size.width ;
    
    //    重写赋值frame
    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
}



#pragma mark - 居中对齐
- (void)alignmentCenter
{
    //    设置文本的坐标
    CGFloat labelX = (TD_btnWidth - TD_labelWidth - TD_imageWidth - TD_padding) * 0.5;
    CGFloat labelY = (TD_btnHeight - TD_labelHeight) * 0.5;
    //    设置label的frame
    self.titleLabel.frame = CGRectMake(labelX, labelY, TD_labelWidth, TD_labelHeight);
    
    //    设置图片的坐标
    CGFloat imageX = CGRectGetMaxX(self.titleLabel.frame) + TD_padding;
    CGFloat imageY = (TD_btnHeight - TD_imageHeight) * 0.5;
    //    设置图片的frame
    self.imageView.frame = CGRectMake(imageX, imageY, TD_imageWidth, TD_imageHeight);
}

#pragma mark - 图标在上，文本在下(居中)
- (void)alignmentTop
{
    CGRect frame = [self getTitleLabelWith];
    
    CGFloat imageX = (TD_btnWidth - TD_imageWidth) * 0.5;
    self.imageView.frame = CGRectMake(imageX, TD_btnHeight * 0.5 - TD_imageHeight * TD_ButtonTopRadio, TD_imageWidth, TD_imageHeight);
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, TD_btnHeight * 0.5 + TD_labelHeight * TD_ButtonTopRadio, TD_btnWidth, TD_labelHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - 图标在下，文本在上(居中)
- (void)alignmentBottom
{
    CGRect frame = [self getTitleLabelWith];
    
    CGFloat imageX = (TD_btnWidth - TD_imageWidth) * 0.5;
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, TD_btnHeight * 0.5 - TD_labelHeight * (1 + TD_ButtonBottomRadio), TD_btnWidth, TD_labelHeight);
    self.imageView.frame = CGRectMake(imageX, TD_btnHeight * 0.5, TD_imageWidth, TD_imageHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setButtonCornerRadius:(CGFloat)buttonCornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = buttonCornerRadius;
}

/** 布局子控件 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (_buttonStyle) {
        case TDAligenmentStyleNormal:
            break;
        case TDAligenmentStyleLeft:
            [self alignmentLeft];
            break;
        case TDAligenmentStyleCenter:
            [self alignmentCenter];
            break;
        case TDAligenmentStyleRight:
            [self alignmentRight];
            break;
        case TDAligenmentStyleTop:
            [self alignmentTop];
            break;
        case TDAligenmentStyleBottom:
            [self alignmentBottom];
            break;
        default:
            break;
    }
    
}


#pragma mark - 按钮动画效果

//按钮的压下事件 按钮缩小
- (void)pressedEvent:(TDCustomButton *)btn
{
    //缩放比例必须大于0，且小于等于1
    CGFloat scale = (_buttonScale && _buttonScale <=1.0) ? _buttonScale : defaultScale;
    
    [UIView animateWithDuration:animateDelay animations:^{
        btn.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}
//点击手势拖出按钮frame区域松开，响应取消
- (void)cancelEvent:(TDCustomButton *)btn
{
    [UIView animateWithDuration:animateDelay animations:^{
        btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}

//按钮的松开事件 按钮复原 执行响应
- (void)unpressedEvent:(TDCustomButton *)btn
{
    [UIView animateWithDuration:animateDelay animations:^{
        btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        //执行动作响应
        if (self.clickBlock) {
            self.clickBlock();
        }
    }];
}




@end