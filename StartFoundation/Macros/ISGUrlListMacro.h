//
//  ISGUrlListMacro.h
//  iShanggang
//
//  Created by 鲍晓飞 on 17/5/17.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#ifndef ISGUrlListMacro_h
#define ISGUrlListMacro_h

#define sTestServerUrl                  @"wap.baidu.com"

// 开屏广告
static NSString *const sServiceUrlLaunchAd             = @"mobile/login/flowrelog/isOpen.action";

// 首页
static NSString *const sServiceUrlBanner               = @"mobile/banner/list.action";
static NSString *const sServiceUrlBannerClick          = @"mobile/login/flowrelog/flowCount.action";
static NSString *const sServiceUrlJobList              = @"mobile/recruitment/list.json";
static NSString *const sServiceUrlBigNews              = @"mobile/report/list.action";
static NSString *const sServiceUrlAllSecondJobList     = @"mobile/recruitmentPosition/getSecondList.action";
static NSString *const HOME_WEASSGINMENT               = @"make/money/getMakeMoneyList.action";

static NSString *const HOME_ZMall_Banner_URL           = @"zprod/v1/product/findHotProductList.htm";


// 搜索结果界面
static NSString *const sServiceUrlCityArea             = @"mobile/address/getArea.action" ;//CityArea
static NSString *const sServiceUrlFetchJob             = @"mobile/wordBook/getWordByCode.action";

// 选择城市
static NSString *const sServiceUrlAllHotCity           = @"mobile/address/selectHotCity.json";

// 工作详情
static NSString *const sServiceUrlJobDetail            = @"mobile/recruitment/detail.json" ;      //jobDetail
static NSString *const sServiceUrlCollect              = @"mobile/recruitment/collect.action";
static NSString *const sServiceUrlApplyJob             = @"mobile/recruitment/applyRec.json";

// 招聘大厅
static NSString *const sServiceUrlReMall               = @"mobile/recruitmentPosition/getSecondList.action";
static NSString *const sServiceUrlJobHotFullTime       = @"mobile/recruitmentPosition/list.action";
static NSString *const sServiceUrlJobHotpartTime       = @"mobile/recruitmentPosition/part.action";
static NSString *const sServiceUrlRHJobList            = @"mobile/wordBook/getWordByCode.action";

// 更多热门职务
static NSString *const sServiceUrlMoreJob              = @"mobile/recruitmentPosition/getAllList.action";//到2级职位
static NSString *const sServiceUrlMorePartJob          = @"mobile/recruitmentPosition/getPartList.action";

// 意见反馈
static NSString *const userSuggestionURL               = @"mobile/userSuggestion/showPage.action";
static NSString *const userImgUploadURL                = @"mobile/userSuggestion/imgUpload.action";
static NSString *const commitURL                       = @"mobile/userSuggestion/commit.action";

// 忘记密码
static NSString *const updatePasswordURL               = @"mobile/login/user/resetPassword.action";

// 登录
static NSString *const accountInfoURL                  = @"mobile/user/userCenterMsg.action";
static NSString *const accountLoginURL                 = @"mobile/login/user/login.action";

// 注册
static NSString *const registerURL                     = @"mobile/login/user/register.action";

// 银行卡
static NSString *const ADDBANKINFO                     = @"mobile/bankcard/add.action";
static NSString *const BANKLIST                        = @"mobile/bank/list.action";

// 登录短信验证码
//static NSString *const getCodeURL                      = @"mobile/login/PQLogin/getCheckCode.action";
static NSString *const getCodeURL                      = @"mobile/login/PQLogin/getQuickCheckCode.action";

// 注册获取验证码
//static NSString *const getRegisterCodeURL              = @"mobile/login/PQLogin/getCheckCode.action";
static NSString *const getRegisterCodeURL              = @"mobile/login/PQLogin/getQuickCheckCode.action";

// 获取绑定手机时的手机验证码(会校验该手机是否已被绑定为用户名)
static NSString *const getCodeList                     = @"mobile/user/getCMMsg.action";

// 修改用户手机号, 并且根据条件更新用户用户名
static NSString *const COMMINTURL                      = @"mobile/user/changeMobile.action";

//修改登录密码
static NSString *const resetPassword                   = @"mobile/login/user/resetPassword.action";

//新的提现接口 为了旧版本的提现接口正常使用
static NSString *const MYWALLET_NewRewardListURL                   = @"mobile/reward/listNew.action";

// 支出明细
static NSString *const MYWALLET_RewardListURL                   = @"mobile/reward/list.action";
static NSString *const MYWALLET_WiseRewardListURL               = @"mobile/wise/list.action";
static NSString *const MYWALLET_SalaryIncomeURL           = @"mobile/u/wages/listGroupMonth.json";

// 支付密码 密码校验 登录
static NSString *const secretCommonURL                 = @"asgapi/v1/common/deal.action";

// 提现
static NSString *const DRAWMONEY_COMMITCASH            = @"mobile/user/withdramcash.action";
static NSString *const DRAWMONEY_CODE                  = @"mobile/user/getWithrawSession.action";
static NSString *const WITHDRAW_CANDRAW_AMOUNT         = @"mobile/user/getWithdrawAmount.action";
// 收入明细
static NSString *const INCOMEURL                       = @"mobile/reward/list.action";

// 邀请好友
static NSString *const bannerURL                       = @"mobile/banner/list.action";

// 我的银行卡
static NSString *const BANKCARD_LIST                   = @"mobile/bankcard/list.action";
static NSString *const BANKCARD_DELETE                 = @"mobile/bankcard/delete.action";

// 工作申请列表
static NSString *const JobApplyListUrl                 = @"mobile/recruitment/applyList.action";

// 新增工作历史
static NSString *const AddWorkURL                      = @"mobile/user/addworkhistory.action";

// 个人简历
static NSString *const uploadIconURL                   = @"mobile/user/personalNikeImg.action";

// 合同列表
static NSString *const contractURL                     = @"mobile/list.action";

// 合同详情
static NSString *const contractDetailURL               = @"mobile/contractDetail.action";

// 上传个人简历信息
static NSString *const uploadProfileDataURL            = @"mobile/currentUser/saveOrUpdateVitae.action";

// 上传个人简历所有信息
static NSString *const getProfileDataURL               = @"mobile/user/personalVitaeMsg.action";

// 实名认证
static NSString *const UPLOADIDENTITYURL               = @"mobile/idCard/idPicUpload.action";
static NSString *const commitIDcardURL                 = @"mobile/idCard/idsubmit.action";
static NSString *const checkIdCardURL                  = @"mobile/idCard/select.action";

// 退出
static NSString *const QUITURL                         = @"mobile/login/user/logout.action";

// 培训经历
static NSString *const trainListURL                    = @"mobile/training/list.action";
static NSString *const deleteTrainingURL               = @"mobile/training/delete.action";

// 工作经历
static NSString *const workingURL                      = @"mobile/user/findworkhistory.action";
static NSString *const deleteworkURL                   = @"mobile/user/deleteworkhistory.action";

// 我的岗位和我的收藏
static NSString *const JobCollertionURL                = @"mobile/recruitment/collectList.action";

// 我的邀请好友
static NSString *const inviteFriendURL                 = @"mobile/user/findIntroduceUsers.action";

// 分享
static NSString *const shareToFriendURL                = @"mobile/userShare/share_register.action?introducer_id=";

// 培训经历上传
static NSString *const TrainURL                        = @"mobile/training/saveOrUpdate.action";

// 我的工作台
static NSString *const setDefaultCompanyBrandURL       = @"mobile/companyBrand/setDefaultCompanyBrand.json";

// 求职设置
static NSString *const getPreferenceJobURL             = @"/mobile/user/preferencePosition/getData.action";
static NSString *const savePreferenceJobURL            = @"/mobile/user/preferencePosition/saveOrUpdate.action";

#pragma mark --    --------------------------  APP 设置相关URL ----------------------------------
// 版本更新
static NSString *const APPUpdateURL                    = @"mobile/appUpdate.action";

#pragma mark    ---芝蚂城的相关接口
static NSString *const sServerUrlBasicZhima            = @"http://zmallapidev.99zmall.com:91/";

//微信--用户信息
static NSString *const WX_BIND_USERINFO                 = @"weixin/getWeixinUserInfo.action";
//微信--绑定手机号验证码
static NSString *const WX_BIND_VERIFICATIONCODE         = @"weixin/getCheckCode.action";
//微信--绑定手机号
static NSString *const WX_BIND_BINDPHONE                = @"weixin/bindUserPhone.action";
//微信--解绑微信
static NSString *const WX_BIND_UNBIND                   = @"weixin/unbindWechatUser.action";
//微信--登录设置绑定微信
static NSString *const WX_BIND_BINDUSER                 = @"weixin/bindWechatUser.action";
//支付宝获取支付字符串
static NSString * const zhifubaoPayUrl = @"mobile/pay/alipay/pay.action";
//微信支付获取支付字符串
static NSString * const weixinPayUrl = @"mobile/pay/app/tenpay/prepay.action";

//房间
static NSString * const Mine_ROOM = @"mobile/companyBrand/suiteList.action";



#endif /* ISGUrlListMacro_h */
