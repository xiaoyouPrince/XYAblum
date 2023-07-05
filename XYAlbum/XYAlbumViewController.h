//
//  XYAlbumViewController.h
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYAlbumTool.h"
#import "AlbumCallBack.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XYAlbumViewControllerDelegate <NSObject>
@optional
/// 用户选择了图片
/// - Parameter image: 从图库选择的图片原图
- (void)didChooseImage:(UIImage *)image;

/// 图片选择完成之后是否需要进入图片编辑页面, 默认进入图片编辑页面
- (BOOL)shouldGotoImageEditWhenChoosed;

/// 图片已经编辑完成
/// - Parameter image: 编辑完成的图片
- (void)didFinishEditImage:(UIImage *)image;

@end

@interface XYAlbumViewController : UINavigationController

/// 加载相册样式
- (instancetype)initWithAlbum;

/// 使用代理方式创建 album 控制器
/// - Parameter delegate: 代理对象, 后续事件回调需要自己实现相关方法
- (instancetype)initWithDelegate:(id<XYAlbumViewControllerDelegate>)delegate;

/// 创建实例,选择完图片之后自动进入编辑页面
/// - Parameters:
///   - getImageBlock: 返回用户选中的图片原图
///   - finishEditBlock: 返回编辑之后的图片
- (instancetype)initWithChooseImageCallback:(XYAlbumGetImageBlock)getImageBlock finishEditBlock:(XYAlbumGetImageBlock)finishEditBlock;


@end

NS_ASSUME_NONNULL_END
