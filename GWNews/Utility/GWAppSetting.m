//
//  Created by hejinbo on 14-4-29.
//  Copyright (c) 2014年 KingCloud. All rights reserved.
//

#import "GWAppSetting.h"

@implementation GWAppSetting

+ (NSString *)getValue:(NSString *)key
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    return [userDef objectForKey:key];
}

+ (void)setValue:(id)value forKey:(NSString *)key
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    [userDef setObject:value forKey:key];
    [userDef synchronize];
}

@end
