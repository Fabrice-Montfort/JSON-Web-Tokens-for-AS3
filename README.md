# JSON-Web-Tokens-for-AS3
Basic class that encode and decode JSON Web Tokens (JWT) for AS3 developers

## JWT ? What for ?
JSON Web Tokens are used by number of REST services over the web.
I created this simple class to play with Firebase REST service on AS3 and AIR.
It works on Web, Desktop and Mobile developments.

## Cryptography
For now, only SHA256 is available. If you know some AS3 lib that deliver SHA384
and SHA512, do not hesitate to let me a message here or better to fork and
upgrade this class.

## Requirements
This class use cryptography. In order to use it, you'll have to get a copy of
As3Crypto wich is available under BSD license here :
http://crypto.hurlant.com

## How to use it for encoding
```
var profile:Object = new Object();
profile.uid = 123;
profile.provider = "custom";
profile.displayName = "John DOE";

var payload:Object = new Object();
payload.token = token; //Token that you got from an OAuth 2.0 authentication
payload.provider = "Your OAuth 2.0 provider";
payload.iat = int(new Date().getTime() / 1000);
payload.v = "0";
payload.d = profile;

var auth:String = JWT.encode(payload, "YOUR_SECRET");
```

##MIT License

Copyright (c) 2016 Fabrice Montfort

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
