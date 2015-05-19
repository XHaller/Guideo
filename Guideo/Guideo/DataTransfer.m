//
//  DataTransfer.m
//  Guideo
//
//  Created by 亮亮 李 on 15/5/17.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import "DataTransfer.h"


@implementation DataTransfer

+ (NSDictionary *)requestObjectWithURL:(NSString *)urladdress httpMethod:(NSString *)httpMethod params:(NSDictionary *)sendParams
{
    NSMutableString *postString = [[NSMutableString alloc] init];
    
    for (id key in sendParams)
    {
        [postString appendString:key];
        [postString appendString:@"="];
        [postString appendString:[sendParams objectForKey:key]];
        [postString appendString:@"&"];
    }
    
    [postString deleteCharactersInRange:NSMakeRange([postString length]-1, 1)];
    
    NSString *post =[[NSString alloc] initWithString:postString];
    NSLog(@"PostData: %@",post);
    
    NSURL *url=[NSURL URLWithString:urladdress];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:httpMethod];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPBody:postData];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error;
    NSHTTPURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %ld", (long)[response statusCode]);
    
    if ([response statusCode] >= 200 && [response statusCode] < 300)
    {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
        
        NSError *error = nil;
        NSDictionary *jsonData = [NSJSONSerialization
                                  JSONObjectWithData:urlData
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
        
        return jsonData;
    } else {
        return NULL;
    }

}


+ (NSArray *)requestArrayWithURL:(NSString *)urladdress httpMethod:(NSString *)httpMethod params:(NSDictionary *)sendParams
{
    NSMutableString *postString = [[NSMutableString alloc] init];
    
    for (id key in sendParams)
    {
        [postString appendString:key];
        [postString appendString:@"="];
        [postString appendString:[sendParams objectForKey:key]];
        [postString appendString:@"&"];
    }
    
    [postString deleteCharactersInRange:NSMakeRange([postString length]-1, 1)];
    
    NSString *post =[[NSString alloc] initWithString:postString];
    NSLog(@"PostData: %@",post);
    
    NSURL *url=[NSURL URLWithString:urladdress];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:httpMethod];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPBody:postData];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error;
    NSHTTPURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %ld", (long)[response statusCode]);
    
    if ([response statusCode] >= 200 && [response statusCode] < 300)
    {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
        
        NSError *error = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:urlData options: NSJSONReadingMutableContainers error:&error];
        
        return jsonArray;
    } else {
        return NULL;
    }
    
}



@end
