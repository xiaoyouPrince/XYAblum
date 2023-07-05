//
//  AlbumCallBack.h
//  XYAlbum
//
//  Created by 渠晓友 on 2023/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XYAlbumGetImageBlock)(UIImage *);

@interface AlbumCallBack : NSObject
/** 选择完成图片回调   */
@property (nonatomic, copy)         XYAlbumGetImageBlock getImageBlock;
/** 编辑完成图片回调 */
@property (nonatomic, copy)         XYAlbumGetImageBlock finishEditBlock;
/** 是否直接进入编辑页面 */
@property (nonatomic, assign)         BOOL shouldGotoEditAfterChooseImage;
@end

NS_ASSUME_NONNULL_END
