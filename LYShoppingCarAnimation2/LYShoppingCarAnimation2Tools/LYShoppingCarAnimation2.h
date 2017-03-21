//
//  LYShoppingCarAnimation2.h
//  LYShoppingCarAnimation2
//
//  Created by ly on 2017/3/21.
//  Copyright © 2017年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    zooming = 0,//先放大后缩小
    boost_only,//仅仅放大
    shrink_only,//仅仅缩小
    zooming_inverse, //小缩小后放大
    zooming_none //无放缩动画
} ZoomingType;


//typedef enum : NSUInteger {
//    curve_Bessel = 0,//贝塞尔曲线
//    curve_Parabola //抛物线
//} CurveType;

@interface LYShoppingCarAnimation2 : NSObject

@property (assign, nonatomic) BOOL isrotate;//是否需要旋转  默认旋转
@property (assign, nonatomic) NSInteger rotateSpeed;//旋转速度

@property (assign, nonatomic) ZoomingType zoomingType;//放大缩小的类型  默认先放大后缩小
@property (assign, nonatomic) CGFloat animationTime_setion1;// 放大缩小或者缩小放大 前部份动画的时间 默认0.3s
@property (assign, nonatomic) CGFloat animationTime;//动画总时间  默认1s

//曲线
@property (assign, nonatomic) CGPoint startPoint; // 起点
@property (assign, nonatomic) CGPoint endPoint; //终点
@property (assign, nonatomic) CGFloat curveHeight;//曲线顶点高度
//@property (assign, nonatomic) CurveType curveType; //轨迹的曲线类型， 默认 贝塞尔曲线 当起点终点是相同的 x坐标 或者y坐标的时候最好用抛物线

@property (assign, nonatomic) CGSize viewSize;//动画的view的原始大小 默认(50, 50)
@property (strong, nonatomic) UIColor *defaultColor;//当没有图片的时候的颜色


/**
 * 添加动画 有图片的情况下传图片
 */
-(void)addAnimation:(UIView *)superView withImage:(UIImage *)image;
@end
