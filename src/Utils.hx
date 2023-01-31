package src;

class Utils {
	static public function trim(item:String):String {
		var isSpace:(char:String) -> Bool = function(char) return char == ' ';

		return item.split('').filter(isSpace).join('');
	}

	static public function trimAll(items:Array<String>):Array<String> {
		for (item in items) {
			item = trim(item);
		}
		return items;
	}

	static public function sum(arr:Array<Int>):Int {
		var sum:Int = 0;
		for (i in arr) {
			sum += i;
		}
		return sum;
	}
}
