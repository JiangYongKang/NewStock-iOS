//
//  DEMODataSource.m
//  MLPAutoCompleteDemo
//
//  Created by Eddy Borja on 5/28/14.
//  Copyright (c) 2014 Mainloop. All rights reserved.
//

#import "DEMODataSource.h"
#import "DEMOCustomAutoCompleteObject.h"
#import "StockCodesInstance.h"

@interface DEMODataSource ()

@property (strong, nonatomic) NSArray *countryObjects;

@end


@implementation DEMODataSource


#pragma mark - MLPAutoCompleteTextField DataSource


//example of asynchronous fetch:
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        /*if(self.simulateLatency){
            float seconds = arc4random_uniform(4)+arc4random_uniform(4);
            NSLog(@"sleeping fetch of completions for %f", seconds);
            sleep(seconds);
        }
        
        NSArray *completions;
        completions = [self allCountryObjects];*/
        NSLog(@"%@",string);
        //NSLog(@"%@",[textField text]);
        NSMutableArray *mutableCountries = [NSMutableArray new];
        NSArray *array = [StockCodesInstance sharedStockCodesInstance].stockCodesArray;
        NSString *text = [string lowercaseString];
        for (int i=0; i<[array count]; i++)
        {
            StockCodeInfo* item = [array objectAtIndex:i];
            
            NSString *code = item.s;
            NSString *name = item.n;
            NSString *pin = item.p;
            
            if([code hasPrefix:string])
            {
                /*if ([item.m intValue]==1)
                {
                    code = [NSString stringWithFormat:@"SH%@",item.s];
                }
                else if ([item.m intValue]==2)
                {
                    code = [NSString stringWithFormat:@"SZ%@",item.s];
                }
                else
                {
                    code = item.s;
                }*/
                DEMOCustomAutoCompleteObject *country = [[DEMOCustomAutoCompleteObject alloc] initWithCountry:[NSString stringWithFormat:@"%@(%@)",item.n,code]];
                country.symbol = item.s;
                country.symbolTyp = item.t;
                country.marketCd = item.m;
                [mutableCountries addObject:country];
                
                //[mutableCountries addObject:item];
            }
            else if([name containsString:string])
            {
                /*if ([item.m intValue]==1)
                {
                    code = [NSString stringWithFormat:@"SH%@",item.s];
                }
                else if ([item.m intValue]==2)
                {
                    code = [NSString stringWithFormat:@"SZ%@",item.s];
                }
                else
                {
                    code = item.s;
                }*/
                DEMOCustomAutoCompleteObject *country = [[DEMOCustomAutoCompleteObject alloc] initWithCountry:[NSString stringWithFormat:@"%@(%@)",item.n,code]];
                country.symbol = item.s;
                country.symbolTyp = item.t;
                country.marketCd = item.m;
                [mutableCountries addObject:country];
                
                //[mutableCountries addObject:item];
            }
            else if([pin containsString:text])
            {
                /*if ([item.m intValue]==1)
                {
                    code = [NSString stringWithFormat:@"SH%@",item.s];
                }
                else if ([item.m intValue]==2)
                {
                    code = [NSString stringWithFormat:@"SZ%@",item.s];
                }
                else
                {
                    code = item.s;
                }*/
                DEMOCustomAutoCompleteObject *country = [[DEMOCustomAutoCompleteObject alloc] initWithCountry:[NSString stringWithFormat:@"%@(%@)",item.n,code]];
                country.symbol = item.s;
                country.symbolTyp = item.t;
                country.marketCd = item.m;
                [mutableCountries addObject:country];
                
                //[mutableCountries addObject:item];
            }
            
            if([mutableCountries count]>30)
            {
                break;
            }
        }
        
        handler(mutableCountries);
    });
}

/*
 - (NSArray *)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
 {
 
 if(self.simulateLatency){
 CGFloat seconds = arc4random_uniform(4)+arc4random_uniform(4); //normal distribution
 NSLog(@"sleeping fetch of completions for %f", seconds);
 sleep(seconds);
 }
 
 NSArray *completions;
 if(self.testWithAutoCompleteObjectsInsteadOfStrings){
 completions = [self allCountryObjects];
 } else {
 completions = [self allCountries];
 }
 
 return completions;
 }
 */

- (NSArray *)allCountryObjects
{
    if(!self.countryObjects){
        NSArray *array = [StockCodesInstance sharedStockCodesInstance].stockCodesArray;
        NSMutableArray *mutableCountries = [NSMutableArray new];
        for(StockCodeInfo *item in array){
            //DEMOCustomAutoCompleteObject *country = [[DEMOCustomAutoCompleteObject alloc] initWithCountry:item.s];
            
            NSString *code;
            if ([item.m intValue]==1)
            {
                code = [NSString stringWithFormat:@"SH%@",item.s];
            }
            else if ([item.m intValue]==2)
            {
                code = [NSString stringWithFormat:@"SZ%@",item.s];
            }
            else
            {
                code = item.s;
            }
            DEMOCustomAutoCompleteObject *country = [[DEMOCustomAutoCompleteObject alloc] initWithCountry:[NSString stringWithFormat:@"%@(%@)",item.n,code]];
            country.symbol = item.s;
            country.symbolTyp = item.t;
            country.marketCd = item.m;
            [mutableCountries addObject:country];
        }
        
        [self setCountryObjects:[NSArray arrayWithArray:mutableCountries]];
    }
    
    return self.countryObjects;
}





@end
