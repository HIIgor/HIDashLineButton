//
//  HIDashLineButton.m
//
//
//  Created by HIIgor on 16/3/17.
//  Copyright © 2016 HIIgor. All rights reserved.
//

#import "HIDashLineButton.h"

@interface HIDashLineButton ()
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, copy) NSArray<NSNumber *>* lineDashPattern;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) CAShapeLayer *borderLayer;
@end

@implementation HIDashLineButton

+ (instancetype)dashLineBorderButtonWithPattern:(NSArray <NSNumber *>*)lineDashPattern strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius {
    return [[self alloc] initWithPattern:(NSArray <NSNumber *>*)lineDashPattern strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius];
}

- (instancetype)initWithPattern:(NSArray <NSNumber *>*)lineDashPattern strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius{
    if (self = [super init]) {
        self.lineDashPattern = lineDashPattern;
        self.strokeColor = strokeColor;
        self.lineWidth = lineWidth;
        self.cornerRadius = cornerRadius;
        [self setValue:@(UIButtonTypeCustom) forKey:@"buttonType"];
        [self configDashLineBorder];
    }

    return self;
}

- (void)configDashLineBorder {
    [self.layer addSublayer:self.borderLayer];
    [self setupObserving];
}

- (void)setupObserving {
    [self.layer addObserver:self forKeyPath:@"borderColor" options:NSKeyValueObservingOptionNew context:nil];
    [self.layer addObserver:self forKeyPath:@"borderWidth" options:NSKeyValueObservingOptionNew context:nil];
    [self.layer addObserver:self forKeyPath:@"cornerRadius" options:NSKeyValueObservingOptionNew context:nil];
    [self.layer addObserver:self forKeyPath:@"masksToBounds" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {

    if (object == self.layer) {
        if ([keyPath isEqualToString:@"borderColor"]) {
            self.layer.borderColor = [UIColor clearColor].CGColor;

            _borderLayer.strokeColor = (__bridge CGColorRef)([change valueForKey:NSKeyValueChangeNewKey]);
        }

        if ([keyPath isEqualToString:@"borderWidth"]) {
            self.layer.borderWidth = 0;

            _borderLayer.lineWidth = ((NSNumber *)[change valueForKey:NSKeyValueChangeNewKey]).floatValue;
        }

        if ([keyPath isEqualToString:@"cornerRadius"]) {
            self.layer.cornerRadius = 0;

            self.cornerRadius = ((NSNumber *)[change valueForKey:NSKeyValueChangeNewKey]).floatValue;
            [self setNeedsLayout];
        }

        if ([keyPath isEqualToString:@"masksToBounds"]) {
            self.layer.masksToBounds = NO;
            _borderLayer.masksToBounds = ((NSNumber *)[change valueForKey:NSKeyValueChangeNewKey]).boolValue;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius].CGPath;
    self.borderLayer.frame = self.bounds;
}

- (void)dealloc {
    [self.layer removeObserver:self forKeyPath:@"borderWidth"];
    [self.layer removeObserver:self forKeyPath:@"borderColor"];
    [self.layer removeObserver:self forKeyPath:@"cornerRadius"];
    [self.layer removeObserver:self forKeyPath:@"masksToBounds"];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];

    self.borderLayer.fillColor = backgroundColor.CGColor;
}

- (CAShapeLayer *)borderLayer {
    if (!_borderLayer) {
        _borderLayer = [CAShapeLayer layer];
        _borderLayer.strokeColor = self.strokeColor.CGColor;
        _borderLayer.fillColor = [UIColor greenColor].CGColor;
        _borderLayer.lineDashPattern = self.lineDashPattern;
        _borderLayer.lineWidth = self.lineWidth;
    }

    return _borderLayer;
}

@end
