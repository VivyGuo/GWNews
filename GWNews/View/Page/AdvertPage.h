//
//  AdvertPage.h
//  GWNews
//
//  Created by guowei on 15/12/31.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "GWBaseViewController.h"

@interface AdvertPage : GWBaseViewController{
   IBOutlet UIImageView    *_imageView; 
}

+ (BOOL)canShowAdvertPage;
+ (void)showAdvertPage;

@end
