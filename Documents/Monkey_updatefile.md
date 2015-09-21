#更新日志
2015.9.21
主要最低支持版本iOS7.0提高至iOS8.0
1.由于Xcode7出现
“embedded dylibs/frameworks are only supported on iOS 8.0 and later (@rpath/ISO8601DateFormatter.framework/ISO8601DateFormatter) for architecture x86_64”错误，所有的embedded binaries库不能加载，发现修改Deployment Target为8.0以上就能修复此问题。但其实这个问题在Xcode6.3上我并不会出现。

2.bitcode的问题
iOS9 SDK新增了对App瘦身的功能，详情见[App thining](https://developer.apple.com/library/prerelease/ios/documentation/IDEs/Conceptual/AppDistributionGuide/AppThinning/AppThinning.html#//apple_ref/doc/uid/TP40012582-CH35)。为了正常使用友盟DK，需要在Build Setting中将**Enable bitcode**关闭,或设置编译标识ENABLE_BITCODE=NO。

注：bitcode仅在Xcode7以上显示并默认开启。

3.HTTP传输安全的问题
为了强制增强数据访问安全， iOS9 默认会把 所有的http请求 所有从NSURLConnection 、 CFURL 、 NSURLSession发出的 HTTP 请求，都改为 HTTPS 请求：iOS9.x-SDK编译时，默认会让所有从NSURLConnection 、 CFURL 、 NSURLSession发出的 HTTP 请求统一采用TLS 1.2 协议。

如不更新，可通过在 Info.plist 中声明，倒退回不安全的网络请求。而这一做法，官方文档称为ATS，全称为App Transport Security，是iOS9的一个新特性。

<key>NSAppTransportSecurity</key>
<dict>
    <!--Connect to anything (this is probably BAD)-->
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>

http://dev.umeng.com/social/ios/ios9

https://github.com/ChenYilong/iOS9AdaptationTips