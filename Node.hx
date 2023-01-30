package;

import sys.io.File;
import Math;

class Node {
	public var values:Array<Int>;
	public var oper:String = '';
	public var children:Array<Node> = [];
	public var isWinning:Bool = false;
	public var depth:Int;
	public var isOver:Bool = false;

	public function new(val:Array<Int>, oper:String, children:Array<Node>, totalDepth:Int = 1) {
		this.values = val;
		this.oper = oper;
		this.children = children;
		this.depth = totalDepth;
	}

	public function getPrintableTree(level = 0) {
		var res:String = '';

		for (i in 0...level) {
			res += '\t\t';
		}

		if (this.isOver == true) {
			res += '(!) ';
		} else {
			for (i in this.values) {
				res += '$i' + ',';
			}
		}
		res += '\n';
		try {
			for (child in this.children) {
				res += child.getPrintableTree(level + 1);
			}
		} catch (e:haxe.Exception) {}

		return res;
	}

	public function performOper(oper:String, index:Int = 0):Array<Int> {
		var arr:Array<Int> = this.values.copy();

		switch oper.substring(0, 1) {
			case '+':
				arr[index] += Std.parseInt(oper.substring(1));
			case '-':
				arr[index] -= Std.parseInt(oper.substring(1));
			case '*':
				arr[index] *= Std.parseInt(oper.substring(1));
			case '/':
				arr[index] = Math.round(arr[index] / Std.parseInt(oper.substring(1)));
		}
		return arr;
	}

	static public function constructTree(startValues:Array<Int>, oper:Array<String>, depth:Int, optimal:Bool = false):Node {
		var getLeaves:Iterator<Node>;
		var root = new Node(startValues, '+', [], depth);
		if (oper[0].charAt(0) == '-') {
			root.oper = '-';
		}

		for (i in 1...depth) {
			getLeaves = new TreeIterator(root, 'leaves');
			for (leaf in getLeaves) {
				if (i % 2 != depth % 2 && optimal) {
					for (j in 0...leaf.values.length) {
						leaf.children.push(new Node(leaf.performOper(oper.slice(-1).join(''), j), oper.slice(-1).join(''), [], i));
					}
				} else if (i == depth - 1) {
					for (j in 0...leaf.values.length) {
						leaf.children.push(new Node(leaf.performOper(oper.slice(-1).join(''), j), oper.slice(-1).join(''), [], i));
					}
				} else {
					for (j in 0...leaf.values.length) {
						for (op in oper) {
							leaf.children.push(new Node(leaf.performOper(op, j), op, [], i));
						}
					}
				}
			}
		}
		return root;
	}

	public function iterator(mode:String = 'nodes/p2c'):Iterator<Node> {
		return new TreeIterator(this, mode);
	}
}
