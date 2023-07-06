//
//  XYEditViewController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import "XYEditViewController.h"
#import "JPImageresizerView.h"

@interface XYEditViewController ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *rotateButton;
@property (weak, nonatomic) IBOutlet UIButton *horizontalButton;
@property (weak, nonatomic) IBOutlet UIButton *verticallyButton;
@property (weak, nonatomic) IBOutlet UIButton *tailoringButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@property (nonatomic, weak) JPImageresizerView *imageresizerView;

@end

@implementation XYEditViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    NSBundle *currentBundle = [NSBundle bundleForClass:self.class];
    return [super initWithNibName:nibNameOrNil bundle:currentBundle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addViews];
    if (@available(iOS 11.0,*)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 设置按钮,如果是通过 pod 三方导入(因为资源bundle不同)
    [self setupButtonImages];
}


- (void)setupButtonImages{
    // OC 三方引入资源文件,直接在xib中拿不到,这里手动处理一下
    NSBundle *currentBundle = [NSBundle bundleForClass:self.class];
    if (currentBundle == [NSBundle mainBundle]) { return; }
    
    [self.backButton setImage:[self imageWithName:@"SR_WhiteBack@3x"] forState:UIControlStateNormal];
    [self.rotateButton setImage:[self imageWithName:@"sr_eidt_rotate_icon@3x"] forState:UIControlStateNormal];
    [self.horizontalButton setImage:[self imageWithName:@"sr_eidt_mirror_horizontal_icon@3x"] forState:UIControlStateNormal];
    [self.verticallyButton setImage:[self imageWithName:@"sr_eidt_mirror_vertically_icon@3x"] forState:UIControlStateNormal];
    [self.tailoringButton setImage:[self imageWithName:@"sr_tailoring_icon@3x"] forState:UIControlStateNormal];
    [self.resetButton setImage:[self imageWithName:@"sr_eidt_reset_icon@3x"] forState:UIControlStateNormal];
}

- (UIImage *)imageWithName:(NSString *)name{
    NSBundle *currentBundle = [NSBundle bundleForClass:self.class];
    NSString *imageBundlePath = [[currentBundle resourcePath] stringByAppendingPathComponent:@"XYAlbum.bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithPath:imageBundlePath];
    NSString *imagePath = [imageBundle pathForResource:name ofType:@"png"];
    return [UIImage imageNamed:imagePath];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)addViews{
    CGFloat top = [[UIApplication sharedApplication] statusBarFrame].size.height;
    self.top.constant += 44;
    JPImageresizerConfigure *configure = [JPImageresizerConfigure defaultConfigureWithResizeImage:self.image make:^(JPImageresizerConfigure *configure) {
        configure.jp_contentInsets(UIEdgeInsetsMake(self.top.constant+44+10, 0, (20 + 50 + 20), 0));
    }];
    
    JPImageresizerView *imageresizerView = [JPImageresizerView imageresizerViewWithConfigure:configure imageresizerIsCanRecovery:^(BOOL isCanRecovery) {
    
    } imageresizerIsPrepareToScale:^(BOOL isPrepareToScale) {

    }];
    imageresizerView.frameType = JPConciseFrameType;
    [self.view insertSubview:imageresizerView atIndex:0];
    self.imageresizerView = imageresizerView;
}

- (IBAction)popAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rotateAction:(UIButton *)sender {
    [self.imageresizerView rotation];
}

- (IBAction)verticallyAction:(UIButton *)sender {
    [self.imageresizerView setVerticalityMirror:!self.imageresizerView.verticalityMirror animated:YES];
}

- (IBAction)horizontalAction:(UIButton *)sender {
    [self.imageresizerView setHorizontalMirror:!self.imageresizerView.horizontalMirror animated:YES];
}

- (IBAction)resetAction:(UIButton *)sender {
    [self.imageresizerView recovery];
}

- (IBAction)tailoringAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [self.imageresizerView imageresizerWithComplete:^(UIImage *resizeImage) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(imageEidtFinish:)]) {
            [weakSelf.delegate imageEidtFinish:resizeImage];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            [weakSelf popAction:nil];
        }
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
