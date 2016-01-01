//
//  AdvertPage.h
//  GWNews
//
//  Created by guowei on 15/12/31.
//  Copyright © 2015年 guowei. All rights reserved.
//

#import "GWBaseController.h"

@interface AdvertPage : GWBaseController{
   IBOutlet UIImageView    *_imageView; 
}

+ (BOOL)canShowAdvertPage;
+ (void)showAdvertPage;

@end
