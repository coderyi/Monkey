# AESCrypt-ObjC - Simple AES encryption / decryption for iOS and OS X

AESCrypt is a simple to use, opinionated AES encryption / decryption Objective-C class that just works.

AESCrypt uses the AES-256-CBC cipher and encodes the encrypted data with base64.

A corresponding gem to easily handle AES encryption / decryption in Ruby is available at http://github.com/Gurpartap/aescrypt.

## Installation

Add this line to your class:

    #import "AESCrypt.h"

## Usage

    NSString *message = @"top secret message";
    NSString *password = @"p4ssw0rd";

Encrypting

    NSString *encryptedData = [AESCrypt encrypt:message password:password];

Decrypting

    NSString *message = [AESCrypt decrypt:encryptedData password:password];

## Common sense

AESCrypt includes Base64 and Crypto extensions for NSData and NSString classes. If you're already using an extension that provides these, there is no need to use the included classes. Change the code in the AESCrypt class to correspond to your existing implementation of these extensions.

## Corresponding usage in Ruby

The AESCrypt Ruby gem, available at http://github.com/Gurpartap/aescrypt, understands what you're talking about in your Objective-C code. The purpose of the Ruby gem and Objective-C class is to have something that works out of the box across the server (Ruby) and client (Objective-C). However, a standard encryption technique is implemented, which ensures that you can handle the data with any AES compatible library available across the web. So, you're not locked-in.

Here's how you would use the Ruby gem:

    message = "top secret message"
    password = "p4ssw0rd"

Encrypting

    encrypted_data = AESCrypt.encrypt(message, password)

Decrypting

    message = AESCrypt.decrypt(encrypted_data, password)

See the Ruby gem README at http://github.com/Gurpartap/aescrypt for more details.

## License

NSData+CommonCrypto is Copyright (c) 2008-2009, Jim Dovey

AESCrypt is Copyright (c) 2012 Gurpartap Singh

See LICENSE for license terms.
