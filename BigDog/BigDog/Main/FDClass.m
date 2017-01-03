//
//  FDClass.m
//  FTAgreement
//
//  Created by syf on 15/12/14.
//  Copyright © 2015年 SYF. All rights reserved.
//

#import "FDClass.h"
#import "MJExtension.h"
@implementation FDClass

MJExtensionLogAllProperties
MJCodingImplementation

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if(oldValue == NULL || [oldValue isKindOfClass:[NSNull class]] || oldValue == nil){
        return @"" ;
    }
     
    return oldValue;
}
@end
