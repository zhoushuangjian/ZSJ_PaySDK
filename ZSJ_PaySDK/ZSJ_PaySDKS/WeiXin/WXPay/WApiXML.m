//
//  WApiXML.m
//  ZSJ_PaySDK
//
//  Created by 周双建 on 16/1/8.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import "WApiXML.h"

@implementation WApiXML
// 开始解析数据
-(void)StartAnalysisData:(NSData *)data{
    // 初始化前面的对像
    self->dictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    self->contentString = [NSMutableString string];
    // 初始化解析器
    xmlParser = [[NSXMLParser alloc] initWithData:data];
    // 设置代理
    [xmlParser setDelegate:self];
    // 能否开始解析
    [xmlParser parse];
}
// 获取数据
-(NSMutableDictionary*)GetAnalysisData{
    return dictionary;
}
// 实现代理
//解析文档开始
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    //NSLog(@"解析文档开始");
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    //NSLog(@"遇到启始标签:%@",elementName);
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //NSLog(@"遇到内容:%@",string);
    [contentString setString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //NSLog(@"遇到结束标签:%@",elementName);
    if( ![contentString isEqualToString:@"\n"] && ![elementName isEqualToString:@"root"]){
        [dictionary setObject: [contentString copy] forKey:elementName];
     }
}
//解析文档结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    //NSLog(@"文档解析结束");
}

@end
