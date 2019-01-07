//
//  ShareManager.m
//  iShanggang
//
//  Created by lijun on 2017/7/4.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import "ShareManager.h"

@implementation ShareManager

+ (instancetype)shareManager{

    static ShareManager *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[self alloc]init];
    });
    return manger;
}

#pragma mark - Share

- (void)shareImageToWeChat:(NSInteger )type withInfo:(ISG_ShareInfo *)shareInfo {
    NSString *title = shareInfo.title;
    NSString *content = shareInfo.content;
    NSString *url = shareInfo.shareUrl;
    NSString *shareIcon = shareInfo.shareIcon;
    UIImage *viewImage = [self handleImageWithURLStr:shareIcon];
    if (shareIcon.length == 0) {
        viewImage = [UIImage imageNamed:@"share_logo"];
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = content;
    [message setThumbImage:viewImage];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    message.mediaObject = ext;
    
    SendMessageToWXReq *req = [SendMessageToWXReq new];
    req.bText = NO;
    req.message = message;
    if (type == 0) {
        req.scene = WXSceneSession;//分享到微信好友
    }else{
        req.scene = WXSceneTimeline;//分享到微信朋友圈
    }
    [WXApi sendReq:req];
}

//分享到QQ好友
- (void)shareImageToQQ:(NSInteger )type withInfo:(ISG_ShareInfo *)shareInfo {
    NSString *title = shareInfo.title;
    NSString *content = shareInfo.content;
    NSString *url = shareInfo.shareUrl;
    NSString *shareIcon = shareInfo.shareIcon;
    NSData *viewData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareIcon]];
    if (shareIcon.length == 0) {
        viewData = UIImageJPEGRepresentation([UIImage imageNamed:@"share_logo"], 1);
    }
    
    QQApiNewsObject *urlObj = [QQApiNewsObject
                               objectWithURL:[NSURL URLWithString:url]
                               title:title
                               description:content
                               previewImageData:viewData
                               targetContentType:QQApiURLTargetTypeNews];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:urlObj];
    //将内容分享到qq
    if (type == ISGShareTypeQQ) {
        [QQApiInterface sendReq:req];
    }else{
        [QQApiInterface SendReqToQZone:req];
    }
}

//分享到短信
- (void)smsShareWithViewControll:(UIViewController *)viewC  smsBody:(NSString *)body {
    _viewC = viewC;
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            NSString *smsBody = body;
            picker.body=smsBody;
            [_viewC presentViewController:picker animated:YES completion:nil];
        }
        else {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"该设备不支持短信功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
    else {
        //@"iOS版本过低,iOS4.0以上才支持程序内发送短信"
    }
}

#pragma mark - message delegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [_viewC dismissViewControllerAnimated:NO completion:nil];
    switch (result) {
        case MessageComposeResultCancelled:
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        default:
            break;
    }
}

- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark - private
- (UIImage *)handleImageWithURLStr:(NSString *)imageURLStr {
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLStr]];
    NSData *newImageData = imageData;
    
    // 压缩图片data大小
    newImageData = UIImageJPEGRepresentation([UIImage imageWithData:newImageData scale:0.1], 0.5f);
    UIImage *image = [UIImage imageWithData:newImageData];
    
    // 压缩图片分辨率(因为data压缩到一定程度后，如果图片分辨率不缩小的话还是不行)
    CGSize newSize = CGSizeMake(300, 300);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,(NSInteger)newSize.width, (NSInteger)newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
