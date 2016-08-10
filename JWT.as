package com.fabricemontfort
{
	import com.hurlant.crypto.Crypto;
	import com.hurlant.crypto.hash.HMAC;
	import com.hurlant.util.Base64;
	import com.hurlant.util.Hex;
	
	import flash.utils.ByteArray;
	
	/** 
	 * This class was created by Fabrice Montfort 
	 * It is offered under MIT license with no warranty  
	 */
	public class JWT
	{
		public static function encode(payload:Object, key:String = null, algo:String = "HS256"):String
		{
			var header:Object = new Object();
			header.typ = 'JWT';
			header.alg = algo;
			var segments:Array = new Array();
			segments.push(urlsafeB64Encode(jsonEncode(header)));
			segments.push(urlsafeB64Encode(jsonEncode(payload)));
			var signing_input:String = segments.join(".");
			var signature:String = sign(signing_input, key, algo);
			segments.push(signature);
			return segments.join(".");
		}
		
		public static function decode(jwt:String, key:String = null, algo:String = "HS256"):Object
		{
			var tks:Array = String(jwt).split('.');
			
			if (tks.length != 3) {
				throw new Error('Wrong number of segments');
			}
			
			var headb64:String = tks[0];
			var bodyb64:String = tks[1];
			var cryptob64:String = tks[2];
			
			var head:Object = jsonDecode(urlsafeB64Decode(headb64));
			
			var payload:Object = jsonDecode(urlsafeB64Decode(bodyb64));

			if (!head.alg) {
				throw new Error('Empty algorithm');
			}

			var verify:String = sign(headb64 + "." + bodyb64, key, algo);
	
			if (cryptob64 != verify) {
				throw new Error('Signature verification failed');
			}
			return payload;
		}
		
		public static function jsonEncode(input:Object):String
		{
			var json:String = JSON.stringify(input);
			
			return json;
		}
		
		public static function jsonDecode(input:String):Object
		{
			var json:Object = JSON.parse(input);
			
			return json;
		}
		
		public static function urlsafeB64Encode(input:String):String
		{
			input = com.hurlant.util.Base64.encode(input);
			
			var exp1:RegExp = /\+/gi;
			var exp2:RegExp = /\//gi;
			var exp3:RegExp = /=/gi;
			
			input = input.replace(exp1, "-");
			input = input.replace(exp2, "_");
			input = input.replace(exp3, "");
			
			return input;
		}
		
		public static function urlsafeB64Decode(input:String):String
		{
			var remainder:int = String(input).length % 4;
			
			if (remainder) {
				var padlen:int = 4 - remainder;
				input += String('====').substr(0, padlen);
			}
			
			var exp1:RegExp = /-/gi;
			var exp2:RegExp = /\_/gi;
			
			input = input.replace(exp1, "+");
			input = input.replace(exp2, "\\");

			return com.hurlant.util.Base64.decode(input);
		}
		
		public static function sign(msg:String, key:String, method:String = 'HS256'):String
		{
			var hmac:HMAC = Crypto.getHMAC("sha256");
			
			var k:String = key;
			var kdata:ByteArray;
			var kformat:String = String("text");
			switch (kformat) {
				case "hex": kdata = Hex.toArray(k); break;
				case "b64": kdata = com.hurlant.util.Base64.decodeToByteArray(k); break;
				default:
					kdata = Hex.toArray(Hex.fromString(k));
			}
			
			var txt:String = msg;
			var data:ByteArray;
			var format:String = String("text");
			switch (format) {
				case "hex": data = Hex.toArray(txt); break;
				case "b64": data = com.hurlant.util.Base64.decodeToByteArray(txt); break;
				default:
					data = Hex.toArray(Hex.fromString(txt));
			}
			var currentResult:ByteArray = hmac.compute(kdata, data);
			
			var signature:String = com.hurlant.util.Base64.encodeByteArray(currentResult);
			
			var exp1:RegExp = /\+/gi;
			var exp2:RegExp = /\//gi;
			var exp3:RegExp = /=/gi;
			signature = signature.replace(exp1, "-");
			signature = signature.replace(exp2, "_");
			signature = signature.replace(exp3, "");
			
			return signature;
		}
	}
}
