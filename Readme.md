##项目说明
仿新闻客户端GWNews，通过学习此项目，get iOS开发Good技能

####1.主要功能：
1）初次打开显示广告页

2）进入应用显示主页面，可切换不同页面，包括新闻页，阅读页等

3）点击新闻页，可滑动栏目，切换不同栏目显示相应的新闻列表

4）点击新闻，显示详情页
####2.素材来源
1）通过itunes下载，解压缩网易新闻.ipa,显示NewsBoard.app包内容，得到图片素材

2）通过网络抓包工具Charles抓取App的http请求链接，得到广告接口，新闻接口，详情接口的数据来源
####3.项目结构
框架：MOVE模型

#####3.1Model:数据模型类

1)基类BaseInfo, 包括数据实体通用属性及从获取数据实体的方法

2)广告实体AdvertInfo,页面实体PageInfo,栏目实体ColumnInfo,新闻实体NewsInfo,详情实体DetailInfo

#####3.2Operation:网络请求操作类

1）网络请求基类GWNetworkOperation

通过URL网络请求获取数据实体所需数据，在各个子类中将Json数据转为字典，返给模型层，填充相应的数据实体

2)子类包括获取广告/广告图片/新闻/详情操作(页面实体与栏目实体的数据是从plist中获取)

3）采用委托设计模式，返回数据后由实现协议的类(各个页面ViewController)执行后续操作。

#####3.3View:视图类

视图基类GWBaseViewController，实现GWNetworkOperationDelegate协议

页面组成

1)广告页AdvertPage

从网络获取广告图片，缓存本地；设置固定时间内不显示广告

2)主页TabBarController

TabBarItem是带有Naivgation的一堆ViewController
包括新闻页NewsPage，阅读页，视听页等；

TabBarItem数量及内容从plist中获取

3)新闻页

- 上面是栏目条columnBarWidget(UIScrollView与Button组成)
- 下面是新闻列表自定义横向TableView
GWLandscapTableView,通过UIScrollView的contentSize实现横向滚动
- 每个Cell(GWLandscapCell)由NewsWidget组成
NewsWidget由竖向TableView组成，每个Cell(NewsTableViewCell)组成
- (注：横向tableView,还可以通过CollectionView实现)

4）详情页由UIWebView组成，解析html模板，将详情实体数据替换到模板中

#####3.4Event:界面的事件

点击、滑动、状态改变等触发的事件

#####3.5工具类

1)字符串：编码转换，删除空格等功能

2)日期格式：字符与日期格式转换，获取年月日

3)文件管理：封装NSFileManager，增、删、拷贝、移动、重命名文件操作

4)提示信息控件：封装UIActivityIndicatorView，设置提示信息位置，背景、透明度等样式及显示和隐藏

5)Button通用控件：此处主要封装了点击变色

6)封装NSUserDefaults,此处主要用于存储第一次显示广告的时间

7)宏定义:自定义日志宏(显示类名方法名),设备类型，文件存储路径，iOS版本，URL路径，接口等

8)Json库：将Json格式字符串转为对象(字典数组)，将对象转为Json字符串


###4.技术总结
######1)抽象出共同特性，作为基类，方便扩展，利于修改
######2)将数据源，数据业务逻辑从VC中抽离，功能解耦
######3)封装网络请求，利用委托模式回调
######4)将复杂的VC按照界面逻辑分离中多个VC
######5)图片缓存本地
######6)多线程下载图片，使用通知主线程更新UI
######7)建立通用控件代码库，提高开发效率


####5.项目截图
![](https://github.com/VivyGuo/GWNews/raw/master/Screenshot/NewsReader.gif)

---

学习路程：

1.书籍

语言基础：《Objective-C程序设计(第四版)》

开发流程：《iOS编程(第四版)》BNR出品

技能进阶：《Effectiv Objective-C 2.0》(52个有效方法，好书)

其他参考：《iOS设计模式解析》《iOS与OSX多线程和内存管理》《iOS开发进阶》(部分)

2.视频 

各大网站基础教学视频(感谢之);
斯坦福iOS8开发C193P课程部分

3.项目

Github上优秀项目

各种练手小例子若干

各种博客文章，官方文档，问答网站，答疑解难

---

项目流水(可忽略)

1.建立项目目录
Define Global
Model Operation View
DB Utility ThirdSDK Resources 

2.自定义宏：日志输出宏，设备判断宏

3.配置：
1)项目信息，Target->Info->Bundle Version,Bundle Name
2)项目版本，Project->Info->Configurations,证书：Target->Building Settings->Code Signing
3)预定义宏，Target->Building Settings->Preprocessors Macros
4)预编译文件，Target->Building Settings->Prefix Header

4.应用程序图标，加载启动图片
Target->Info,删除"LaunchScreen interface files base.."项
Target->General,Launch Image Source选择启动图片资源

5.加入JSON library
Target->Building Phases ->CompileSources->JSON库文件设置维不使用ARC -fno-objc-arc

6.Model:BaseInfo,AdvertInfo,ColumnInfo,NewsInfo
7.URLDefine.h
8.Operation:
1）GWNetworkOperation:网络请求操作基类
2）GWGetAdvert:请求广告信息
3）GWGetImage:请求广告图片
9.View
1）AdvertPage广告页：请求广告信息，显示广告

修改了广告模型类AdvertInfo
网络请求改为从http获取，而非本地服务器Json文件

10.增加文件缓存路径常量、广告常量、iOS系统版本常量
增加工具类：格式化日期类，格式化字符串类，文件操作类，系统配置

11.新建导航栏基类 GWBaseNavPage ，设置导航栏背景样式、按钮样式、Title样式
新建新闻页面(NewsPage)，视听、阅读等页面继承导航栏基类

12.新建主界面HomeTabBarController
从plist文件读取Page数组，生成相应PageViewController 添加到TabBar

增加了AdvertPage获取广告失败处理操作：直接显示主页
GWNetworkOperation中出现data无法通过UTF8编码转换为string，改为ASCII编码

13.新闻页增加栏目条
ColumnBarWidget由UIButton和UIScrollView组成

从plist中读取栏目数量、title等信息生成UIButton

14.新闻页

新闻页由自定义横向TableView组成(GWLandscapTableView),每个Cell(GWLandscapCell)由NewsWidget组成
NewsWidget由竖向TableView组成，每个Cell(NewsTableViewCell)组成

15.修复Bug
1）修复新闻页面初始空白，点击栏目才出内容Bug(setColumnIndex)
2）修复新闻Cell每项显示一样问题(Model层NewsInfo add 问题)
3）修复切换栏目条，程序退出问题（NewsWidget reloadData）

16.加入新闻详情
DetailPage->GWDetail->DetailInfo
根据template.html替换为DetailInfo参数，加载到UIWebView

17.修改获取新闻图片
通过多线程下载图片，使用通知更新NewsCell
新闻详情页显示图片











