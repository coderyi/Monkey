# Monkey for GitHub(已上架)

[![Join the chat at https://gitter.im/coderyi/Monkey](https://badges.gitter.im/coderyi/Monkey.svg)](https://gitter.im/coderyi/Monkey?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/coderyi/Monkey/blob/master/LICENSE.txt) 
[![](https://img.shields.io/github/release/coderyi/Monkey.svg)](https://github.com/coderyi/Monkey/releases)
[![](https://img.shields.io/github/stars/coderyi/Monkey.svg)](https://github.com/coderyi/Monkey/stargazers) 
[![](https://img.shields.io/github/forks/coderyi/Monkey.svg)](https://github.com/coderyi/Monkey/network) 
[![Twitter](https://img.shields.io/badge/twitter-@coderyi9-green.svg?style=flat)](http://twitter.com/coderyi9)

![monkey](http://7u2k5i.com1.z0.glb.clouddn.com/monkey_liantuerweima.png?imageMogr2/thumbnail/!60p) 
[![Slack](https://antbr.herokuapp.com/badge.svg)](https://antbr.herokuapp.com/)

Monkey是一个GitHub第三方客户端，Monkey取名就是表示我们程序猿的意思。Monkey for GitHub是我的第一个上线App，开源项目，希望多多指教。欢迎使用上面的二维码扫描下载。

 

GitHub开源地址:[https://github.com/coderyi/Monkey](https://github.com/coderyi/Monkey)

App Store地址:[https://itunes.apple.com/cn/app/monkey-for-github/id1003765407](https://itunes.apple.com/cn/app/monkey-for-github/id1003765407)

Monkey Mac地址:[https://github.com/coderyi/MonkeyForMac](https://github.com/coderyi/MonkeyForMac)

另外, 你能够获取Android版本[andyiac](https://github.com/andyiac) 写的 [GitHot](https://github.com/andyiac/githot) ，下载链接 [ fir.im/githot](http://fir.im/githot) .    
另外一个Android版本，[monkey-android](https://github.com/yeungeek/monkey-android), 来自[yeungeek](https://github.com/yeungeek)

## Monkey for GitHub


Monkey是一个GitHub第三方客户端，Monkey取名就是表示我们程序猿的意思。它包括下面这些功能

- [x] Monkey可以展示GitHub上的开发者的排名，开发者的排名是根据开发者的followers由高到低进行排名，有区分不同的语言和城市。
- [x] Monkey可以展示GitHub上的仓库的排名，仓库的排名是根据仓库的stars由高到低进行排名的，有区分不同的语言。
- [x] 登录GitHub功能，随手follow开发者和star仓库，支持查看我的GitHub动态。
- [x] 发现模块，包括GitHub仓库的trending；GitHub动态；showcases；搜索；以及其他排名数据


这些数据是从GitHub提供的接口来的，地址是https://developer.github.com/v3/

我创建了一个google group，欢迎进来讨论Monkey相关的东西，,[https://groups.google.com/d/forum/monkeyforgithub](https://groups.google.com/d/forum/monkeyforgithub)

build的话使用如下命令
<pre>
$ git clone https://github.com/coderyi/Monkey.git
$ pod install
</pre>
## Monkey架构

![点击放大](https://raw.githubusercontent.com/coderyi/Monkey/master/Documents/Monkey_architecture_img1.png)


## GitHub Top Users Repositories
**[GitHub排名前50的Objective-C开发者(Objective-C top 50 GitHub developers)](https://github.com/coderyi/Monkey/blob/master/github_top_users_repositories/github_top_users_objective-c_world.md)**

这是GitHub在世界范围内排名前50的Objective-C程序员，并且列出相关信息，从而可以走近他们的程序世界。

数据来自GitHub的API以及自己整理的相关内容。

这个列表是我做[Monkey for GitHub](https://github.com/coderyi/Monkey)这个开源的GitHub第三方客户端的衍生品，欢迎交流意见。
## 关于开源
#### 运行
支持iOS7.0+，支持iPhone的各个尺寸，支持竖屏；可以使用的是Xcode7.0+

#### Monkey API
我整理Monkey for GitHub的所有API，并做了一些说明和示例，希望能够帮助到您。

地址是：https://github.com/coderyi/Monkey/blob/master/Monkey_API.md


#### 项目中使用的开源组件
[NetworkEye](https://github.com/coderyi/NetworkEye)

NetworkEye,a iOS network debug library,It can monitor all HTTP requests within the App and displays all information related to the request.

[YiRefresh](https://github.com/coderyi/YiRefresh)

a simple way to use pull-to-refresh.


[JPFPSStatus](https://github.com/joggerplus/JPFPSStatus)

Show FPS Status on StatusBar



[MKNetworkKit](https://github.com/MugunthKumar/MKNetworkKit)

ARC ready Networking Framework with built in authentication and HTTP 1.1 caching standards support for iOS 5+ devices


[SDWebImage](https://github.com/rs/SDWebImage)

Asynchronous image downloader with cache support with an UIImageView category

[MJPhotoBrowser](http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E5%9B%BE%E7%89%87%E6%B5%8F%E8%A7%88%E5%99%A8/525e06116803fa7b0a000001)

一个比较完整的图片浏览器。



另外项目中使用了友盟的相关服务。


## LICENSE
此开源项目可以用来做任何事情除了原封不动的分发到App Store。

copyright (c) 2015 coderyi.all rights reserved.







## 联系我
对于Monkey，你可以随意提交；如果想加入更多的开发，欢迎联系我！

blog:[http://www.coderyi.com/](http://www.coderyi.com/)

GitHub:[https://github.com/coderyi](https://github.com/coderyi)

email:coderyi@foxmail.com


## App预览



Objective-C的世界范围内程序员排名示例

<img  src="https://raw.githubusercontent.com/coderyi/Monkey/master/Documents/images/6p-1.png" width="320" height="570">



Objective-C的世界范围内仓库排名示例

<img  src="https://raw.githubusercontent.com/coderyi/Monkey/master/Documents/images/6p-2.png" width="320" height="570">

程序员详细页面，支持follow

<img  src="https://raw.githubusercontent.com/coderyi/Monkey/master/Documents/images/6p-3.png" width="320" height="570">

Objective-C的trending界面

<img  src="https://raw.githubusercontent.com/coderyi/Monkey/master/Documents/images/6p-4.png" width="320" height="570">

我的个人动态界面

<img  src="https://raw.githubusercontent.com/coderyi/Monkey/master/Documents/images/6p-5.png" width="320" height="570">


[Knockin' On Heaven's Door-Guns N' Roses-网易云音乐](http://music.163.com/#/song?id=18095057)

<pre>

			写字楼里写字间，写字间里程序员；
			程序人员写程序，又拿程序换酒钱。

			酒醒只在网上坐，酒醉还来网下眠；
			酒醉酒醒日复日，网上网下年复年。

			但愿老死电脑间，不愿鞠躬老板前；
			奔驰宝马贵者趣，公交自行程序员。

			别人笑我忒疯癫，我笑自己命太贱；
			不见满街漂亮妹，哪个归得程序员？
</pre>

如果觉得还不错，赏点酒钱！

<img src="https://raw.githubusercontent.com/coderyi/blog/master/other/images/jiuqian2.png" width="200" height="200">  <img src="https://raw.githubusercontent.com/coderyi/blog/master/other/images/jiuqian1.png" width="200" height="200">

