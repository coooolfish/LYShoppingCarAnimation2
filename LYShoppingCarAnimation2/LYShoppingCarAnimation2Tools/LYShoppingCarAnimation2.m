//
//  LYShoppingCarAnimation2.m
//  LYShoppingCarAnimation2
//
//  Created by ly on 2017/3/21.
//  Copyright © 2017年 ly. All rights reserved.
//

#import "LYShoppingCarAnimation2.h"

@interface LYShoppingCarAnimation2()<CAAnimationDelegate>{
    UIView *_superView;
}
@end

@implementation LYShoppingCarAnimation2

-(id)init{
    self = [super init];
    
    if (self) {//设置默认属性
        
        _isrotate = YES;
        _rotateSpeed = 2;
        _zoomingType = zooming;
        _animationTime_setion1 = 0.3;
        _animationTime = 1;
        
        _viewSize = CGSizeMake(50, 50);
        _defaultColor = [UIColor yellowColor];
    }
    
    return self;
}

/**
 * 添加动画 有图片的情况下传图片
 */
-(void)addAnimation:(UIView *)superView withImage:(UIImage *)image{
    CGPoint controlPoint ;
    
    //    [@"" isEqual:<#(id)#>]
    
    if (CGPointEqualToPoint(CGPointZero, _startPoint) || CGPointEqualToPoint(CGPointZero, _endPoint)) {
        NSLog(@"起点终点是必须要设置的");
        return;
    }
    
    if (_endPoint.x == _startPoint.x) {//x坐标相等的情况下
        double radius = 0;
        
        if (_endPoint.y > _startPoint.y) {
            radius = (_endPoint.y - _startPoint.y)/2.0;
        }
        else{
            radius = (_startPoint.y - _endPoint.y)/2.0;
        }
        
        if(_curveHeight == 0){
            _curveHeight = radius;
        }
        if(_endPoint.y > _startPoint.y){
            controlPoint = CGPointMake(_startPoint.x + _curveHeight, _endPoint.y - radius);
        }
        else{
            controlPoint = CGPointMake(_startPoint.x + _curveHeight, _startPoint.y - radius);
        }
    }
    else if (_endPoint.y == _startPoint.y){
        double radius = 0;
        if (_endPoint.x > _startPoint.x) {
            radius = (_endPoint.x - _startPoint.x)/2.0;
        }
        else{
            radius = (_startPoint.x - _endPoint.x)/2.0;
        }
        if(_curveHeight == 0){
            _curveHeight = radius;
        }
        if(_endPoint.x > _startPoint.x){
            controlPoint = CGPointMake(_startPoint.y + _curveHeight, _endPoint.x - radius);
        }
        else{
            controlPoint = CGPointMake(_startPoint.y + _curveHeight, _startPoint.x - radius);
        }
    }
    else{
        
        controlPoint = CGPointMake(_endPoint.x, _startPoint.y);
        
        
    }
    
    
    _superView = superView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 50, 50)];
    //    imageView.backgroundColor = [UIColor redColor];
    //    imageView.layer.cornerRadius = 25;
    imageView.contentMode = UIViewContentModeScaleToFill;
    if (image) {
        imageView.image = image;
        imageView.backgroundColor = [UIColor clearColor];
    }
    else{
        imageView.backgroundColor = _defaultColor;
    }
    
    imageView.center = _startPoint;
    [imageView setTag:100];
    [superView addSubview:imageView];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    animation.duration = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _startPoint.x, _startPoint.y);
    CGPathAddQuadCurveToPoint(path, NULL, controlPoint.x, controlPoint.y, _endPoint.x, _endPoint.y);
    animation.path = path;
    
    [imageView.layer addAnimation:animation forKey:nil];
    
    CGPathRelease(path);
    
    CABasicAnimation *rotationAnimation =[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    rotationAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    rotationAnimation.toValue=[NSNumber numberWithFloat:1.0];
    rotationAnimation.duration=0.3;
    rotationAnimation.autoreverses=NO;
    rotationAnimation.repeatCount=0;
    rotationAnimation.removedOnCompletion=NO;
    rotationAnimation.fillMode=kCAFillModeForwards;
    //    [imageView.layer addAnimation:rotationAnimation forKey:nil];
    
    CABasicAnimation * rotationAnimation2 =[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    rotationAnimation2.fromValue=[NSNumber numberWithFloat:1.0];
    rotationAnimation2.toValue=[NSNumber numberWithFloat:0.1];
    rotationAnimation2.duration=0.7;
    rotationAnimation2.beginTime = 0.3; // 2秒后执行
    rotationAnimation2.autoreverses=NO;
    rotationAnimation2.repeatCount=0;
    rotationAnimation2.removedOnCompletion=NO;
    rotationAnimation2.fillMode=kCAFillModeForwards;
    //    [imageView.layer addAnimation:rotationAnimation forKey:nil];
    
    
    /* 旋转 */
    
    // 对Y轴进行旋转（指定Z轴的话，就和UIView的动画一样绕中心旋转）
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 设定动画选项
    animation3.duration = 1; // 持续时间
    animation3.repeatCount = MAXFLOAT; // 重复次数
    
    // 设定旋转角度
    animation3.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation3.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
    
    // 添加动画
    //    [imageView.layer addAnimation:animation forKey:@"rotate-layer"];
    
    /* 动画组 */
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    // 动画选项设定
    group.duration = 1.0;
    group.repeatCount = 0;
    
    // 添加动画
    group.animations = [NSArray arrayWithObjects:rotationAnimation, rotationAnimation2, animation3, nil];
    [imageView.layer addAnimation:group forKey:nil];
}

- (void)animationDidStart:(CAAnimation *)anim{
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    UIImageView *imageView = [_superView viewWithTag:100];
    [imageView removeFromSuperview];
}

@end
