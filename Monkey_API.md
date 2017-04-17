
这些数据是从GitHub提供的接口来的，地址是https://developer.github.com/v3/

数据整理出来希望可以帮助到您。

API的hostname是https://api.github.com

### Search users（搜索用户）

官方地址:https://developer.github.com/v3/search/#search-users

作用:Search users ，依照参数规则可以产生用户排名
API简单说明:GET /search/users

示例:
##### Users排名
世界users排名objective-c followers

https://api.github.com/search/users?q=language:objective-c&sort=followers&order=desc

中国users排名objective-c followers

https://api.github.com/search/users?sort=followers&page=1&q=location:china+language:Objective-C

中国users排名不分语言 followers

https://api.github.com/search/users?q=location:china&sort=followers&page=2

城市users排名不分语言 followers

https://api.github.com/search/users?sort=followers&page=1&q=location:guangzhou

城市users排名分语言objective-c followers

https://api.github.com/search/users?sort=followers&page=1&q=location:beijing+language:Objective-C
##### 查找用户

https://api.github.com/search/users?q=coderyi

### Search repositories（搜索仓库）

官方地址:https://developer.github.com/v3/search/#search-repositories

作用:Search repositories，依照参数规则可以产生仓库排名
API简单说明:GET /search/repositories

示例:

世界仓库排名objective-c stars

https://api.github.com/search/repositories?q=language:objective-c&sort=stars&order=desc

### Get a single user（获取用户的详细信息）



官方地址:https://developer.github.com/v3/users/#get-a-single-user

作用:Get a single user 

API简单说明:GET /users/:username

示例:

某用户的详细信息   https://api.github.com/users/coderyi

### List user repositories（获取用户所有的仓库）

官方文档地址:https://developer.github.com/v3/repos/#list-user-repositories
作用:List user repositories

API简单说明:GET /users/:username/repos

示例:

查看某个人的所有项目

https://api.github.com/users/coderyi/repos?sort=updated



### List followers of a user（获取用户的粉丝列表）

官方文档地址:https://developer.github.com/v3/users/followers/#list-followers-of-a-user

API简单说明:GET /users/:username/followers

示例:

粉丝

https://api.github.com/users/coderyi/followers



### List users followed by another user（获取用户关注的人列表）
官方文档地址:https://developer.github.com/v3/users/followers/#list-users-followed-by-another-user

API简单说明:GET /users/:username/following

示例:

关注

https://api.github.com/users/coderyi/following

### Get(查看项目详细)
官方文档地址:https://developer.github.com/v3/repos/#get

API简单说明:GET /repos/:owner/:repo

示例:

查看项目详细

https://api.github.com/repos/coderyi/yirefresh

### List contributors（所有对这个项目有贡献的人）
官方文档地址:https://developer.github.com/v3/repos/#list-contributors

作用:List contributors 

API简单说明:GET /repos/:owner/:repo/contributors

示例:

查看项目所有contributors

https://api.github.com/repos/aufree/trip-to-iOS/contributors

### List forks（所有forks这个repos的repos）
官方文档地址:https://developer.github.com/v3/repos/forks/#list-forks

作用:List forks 

API简单说明: GET /repos/:owner/:repo/forks

示例:

https://api.github.com/repos/coderyi/yiswitch/forks

### List Stargazers（所有star这个仓库的人）
官方文档地址:https://developer.github.com/v3/activity/starring/#list-stargazers

作用:List Stargazers 

API简单说明:GET /repos/:owner/:repo/stargazers

示例:
项目的stargazers（在activity那部分）

https://api.github.com/repos/coderyi/yiswitch/stargazers






