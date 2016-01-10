//
//  URLDefine.h
//  GWNews
//
//  Created by guowei on 15/12/21.
//  Copyright © 2015年 guowei. All rights reserved.
//
//正式版0 测试版1
#define ProductType 1

//正式环境使用正式版 Enterprise，AppStroe版OFFICIAL=1
#ifdef OFFICIAL
#undef ProductType
#define ProductType 0
#endif

//本地目录/Library/WebServer/Documents/GWNews/
#if ProductType == 0
#define BaseURL    @"http://c.m.163.com/"
#else
#define BaseURL    @"http://c.m.163.com/" //"http://127.0.0.1/GWNews/"
#endif

#define GWRequestTimeout    10
//服务器数据接口
#define NewsURL     BaseURL "nc/article/%@/0-20.html"
#define DetailURL   BaseURL "nc/article/%@/full.html"
#define ChartURL    BaseURL "chart.json"
#define H5URL       BaseURL "H5/content.html"

#define CityCodeURLFmt  @"http://apistore.baidu.com/microservice/cityinfo?cityname=%@"



