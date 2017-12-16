// ================================================================================================
//  TKXML.h
//  Fast processing of XML files
//
// ================================================================================================
//  Created by Tom Bradley on 21/10/2009.
//  Version 1.5
//  
//  Copyright 2012 71Squared All rights reserved.b
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
// ================================================================================================
#import <Foundation/Foundation.h>
@class TKXML;


// ================================================================================================
//  Error Codes
// ================================================================================================
enum TKXMLErrorCodes {
    D_TKXML_SUCCESS = 0,

    D_TKXML_DATA_NIL,
    D_TKXML_DECODE_FAILURE,
    D_TKXML_MEMORY_ALLOC_FAILURE,
    D_TKXML_FILE_NOT_FOUND_IN_BUNDLE,
    
    D_TKXML_ELEMENT_IS_NIL,
    D_TKXML_ELEMENT_NAME_IS_NIL,
    D_TKXML_ELEMENT_NOT_FOUND,
    D_TKXML_ELEMENT_TEXT_IS_NIL,
    D_TKXML_ATTRIBUTE_IS_NIL,
    D_TKXML_ATTRIBUTE_NAME_IS_NIL,
    D_TKXML_ATTRIBUTE_NOT_FOUND,
    D_TKXML_PARAM_NAME_IS_NIL
};


// ================================================================================================
//  Defines
// ================================================================================================
#define D_TKXML_DOMAIN @"com.thinkive.tbxml"

#define TKMAX_ELEMENTS 100
#define TKMAX_ATTRIBUTES 100

#define TKXML_ATTRIBUTE_NAME_START 0
#define TKXML_ATTRIBUTE_NAME_END 1
#define TKXML_ATTRIBUTE_VALUE_START 2
#define TKXML_ATTRIBUTE_VALUE_END 3
#define TKXML_ATTRIBUTE_CDATA_END 4

// ================================================================================================
//  Structures
// ================================================================================================

/** The TBXMLAttribute structure holds information about a single XML attribute. The structure holds the attribute name, value and next sibling attribute. This structure allows us to create a linked list of attributes belonging to a specific element.
 */
typedef struct _TKXMLAttribute {
	char * name;
	char * value;
	struct _TKXMLAttribute * next;
} TKXMLAttribute;



/** The TBXMLElement structure holds information about a single XML element. The structure holds the element name & text along with pointers to the first attribute, parent element, first child element and first sibling element. Using this structure, we can create a linked list of TBXMLElements to map out an entire XML file.
 */
typedef struct _TKXMLElement {
	char * name;
	char * text;
	
	TKXMLAttribute * firstAttribute;
	
	struct _TKXMLElement * parentElement;
	
	struct _TKXMLElement * firstChild;
	struct _TKXMLElement * currentChild;
	
	struct _TKXMLElement * nextSibling;
	struct _TKXMLElement * previousSibling;
	
} TKXMLElement;

/** The TBXMLElementBuffer is a structure that holds a buffer of TBXMLElements. When the buffer of elements is used, an additional buffer is created and linked to the previous one. This allows for efficient memory allocation/deallocation elements.
 */
typedef struct _TKXMLElementBuffer {
	TKXMLElement * elements;
	struct _TKXMLElementBuffer * next;
	struct _TKXMLElementBuffer * previous;
} TKXMLElementBuffer;



/** The TBXMLAttributeBuffer is a structure that holds a buffer of TBXMLAttributes. When the buffer of attributes is used, an additional buffer is created and linked to the previous one. This allows for efficient memeory allocation/deallocation of attributes.
 */
typedef struct _TKXMLAttributeBuffer {
	TKXMLAttribute * attributes;
	struct _TKXMLAttributeBuffer * next;
	struct _TKXMLAttributeBuffer * previous;
} TKXMLAttributeBuffer;


// ================================================================================================
//  Block Callbacks
// ================================================================================================
typedef void (^TKXMLSuccessBlock)(TKXML *tkxml);
typedef void (^TKXMLFailureBlock)(TKXML *tkxml, NSError *error);
typedef void (^TKXMLIterateBlock)(TKXMLElement *element);
typedef void (^TKXMLIterateAttributeBlock)(TKXMLAttribute *attribute, NSString *attributeName, NSString *attributeValue);


// ================================================================================================
//  TBXML Public Interface
// ================================================================================================

@interface TKXML : NSObject {
	
@private
	TKXMLElement * rootXMLElement;
	
	TKXMLElementBuffer * currentElementBuffer;
	TKXMLAttributeBuffer * currentAttributeBuffer;
	
	long currentElement;
	long currentAttribute;
	
	char * bytes;
	long bytesLength;
}


@property (nonatomic, readonly) TKXMLElement * rootXMLElement;

+ (id)newTKXMLWithXMLString:(NSString*)aXMLString error:(NSError **)error;
+ (id)newTKXMLWithXMLData:(NSData*)aData error:(NSError **)error;
+ (id)newTKXMLWithXMLFile:(NSString*)aXMLFile error:(NSError **)error;
+ (id)newTKXMLWithXMLFile:(NSString*)aXMLFile fileExtension:(NSString*)aFileExtension error:(NSError **)error;

+ (id)newTKXMLWithXMLString:(NSString*)aXMLString __attribute__((deprecated));
+ (id)newTKXMLWithXMLData:(NSData*)aData __attribute__((deprecated));
+ (id)newTKXMLWithXMLFile:(NSString*)aXMLFile __attribute__((deprecated));
+ (id)newTKXMLWithXMLFile:(NSString*)aXMLFile fileExtension:(NSString*)aFileExtension __attribute__((deprecated));


- (id)initWithXMLString:(NSString*)aXMLString error:(NSError **)error;
- (id)initWithXMLData:(NSData*)aData error:(NSError **)error;
- (id)initWithXMLFile:(NSString*)aXMLFile error:(NSError **)error;
- (id)initWithXMLFile:(NSString*)aXMLFile fileExtension:(NSString*)aFileExtension error:(NSError **)error;

- (id)initWithXMLString:(NSString*)aXMLString __attribute__((deprecated));
- (id)initWithXMLData:(NSData*)aData __attribute__((deprecated));
- (id)initWithXMLFile:(NSString*)aXMLFile __attribute__((deprecated));
- (id)initWithXMLFile:(NSString*)aXMLFile fileExtension:(NSString*)aFileExtension __attribute__((deprecated));


- (int) decodeData:(NSData*)data;
- (int) decodeData:(NSData*)data withError:(NSError **)error;

@end

// ================================================================================================
//  TBXML Static Functions Interface
// ================================================================================================

@interface TKXML (StaticFunctions)

+ (NSString*) elementName:(TKXMLElement*)aXMLElement;
+ (NSString*) elementName:(TKXMLElement*)aXMLElement error:(NSError **)error;
+ (NSString*) textForElement:(TKXMLElement*)aXMLElement;
+ (NSString*) textForElement:(TKXMLElement*)aXMLElement error:(NSError **)error;
+ (NSString*) valueOfAttributeNamed:(NSString *)aName forElement:(TKXMLElement*)aXMLElement;
+ (NSString*) valueOfAttributeNamed:(NSString *)aName forElement:(TKXMLElement*)aXMLElement error:(NSError **)error;

+ (NSString*) attributeName:(TKXMLAttribute*)aXMLAttribute;
+ (NSString*) attributeName:(TKXMLAttribute*)aXMLAttribute error:(NSError **)error;
+ (NSString*) attributeValue:(TKXMLAttribute*)aXMLAttribute;
+ (NSString*) attributeValue:(TKXMLAttribute*)aXMLAttribute error:(NSError **)error;

+ (TKXMLElement*) nextSiblingNamed:(NSString*)aName searchFromElement:(TKXMLElement*)aXMLElement;
+ (TKXMLElement*) childElementNamed:(NSString*)aName parentElement:(TKXMLElement*)aParentXMLElement;

+ (TKXMLElement*) nextSiblingNamed:(NSString*)aName searchFromElement:(TKXMLElement*)aXMLElement error:(NSError **)error;
+ (TKXMLElement*) childElementNamed:(NSString*)aName parentElement:(TKXMLElement*)aParentXMLElement error:(NSError **)error;

/** Iterate through all elements found using query.
 
 Inspiration taken from John Blanco's RaptureXML https://github.com/ZaBlanc/RaptureXML
 */
+ (void)iterateElementsForQuery:(NSString *)query fromElement:(TKXMLElement *)anElement withBlock:(TKXMLIterateBlock)iterateBlock;
+ (void)iterateAttributesOfElement:(TKXMLElement *)anElement withBlock:(TKXMLIterateAttributeBlock)iterateBlock;


@end
