//
//  TKRSA.h
//  TKUtil_V1
//
//  Created by liubao on 15-7-14.
//  Copyright (c) 2015年 liubao. All rights reserved.
//
#ifndef __TKUtil_V1__TKRSA__
#define __TKUtil_V1__TKRSA__
#include <openssl/rsa.h>

#define RSA_KEY_LENGTH 1024

static const char rnd_seed[] = "string to make the random number generator initialized";

class TKRSA
{
public:
	TKRSA();
	~TKRSA();
    
	// init params
	int set_params(unsigned char *pub_expd, int pub_expd_len,
                   unsigned char *pri_expd, int pri_expd_len,
                   unsigned char *module, int module_len, int padding);
    
	// open keys
	int open_prikey_pubkey();
	int open_prikey();
	int open_pubkey();
    
	// private key to encryption and public key to decryption
	int prikey_encrypt(unsigned char *in, int in_len,
                       unsigned char **out, int &out_len);
	int pubkey_decrypt(unsigned char *in, int in_len,
                       unsigned char **out, int &out_len);
	// public key to encryption and private key to decryption
	int pubkey_encrypt(unsigned char *in, int in_len,
                       unsigned char **out, int &out_len);
    int prikey_decrypt(unsigned char *in, int in_len,
                       unsigned char **out, int &out_len);
    
	int close_key();
protected:
	void free_res();
    
private:
	RSA *_pub_key;
	RSA *_pri_key;
    
	unsigned char *_pub_expd;
	unsigned char *_pri_expd;
	unsigned char *_module;
    
	int _pub_expd_len;
	int _pri_expd_len;
	int _module_len;
    int _padding;
};

#endif