package;

class TreeIterator {
	public var root:Node;
	public var stack:Array<Node>;

	public function new(root:Node, mode:String = 'nodes/p2c', depth:Int = -1) {
		this.root = root;
		this.stack = new Array<Node>();

		switch [mode, depth] {
			case ['nodes/p2c', _]:
				{
					populateStackNodes();
				}
			case ['leaves', _]:
				{
					populateStackLeaves();
				}
			case ['nthNodes', n]:
				{
					populateStackNthNodes(n);
				}
		}
	}

	public function populateStackNthNodes(depth:Int):Void {
		var node:Node;
		var currDepth:Int;
		var arr = new Array<Node>();
		var stackOfNode:Array<Node> = new Array<Node>();
		var stackOfDepth:Array<Int> = new Array<Int>();

		stackOfNode.push(this.root);
		stackOfDepth.push(1);
		while (true) {
			try {
				node = stackOfNode.pop();
			} catch (e:haxe.Exception) {
				trace(e.message);
				break;
			}
			currDepth = stackOfDepth.pop();
			if (node == null) {
				break;
			}
			if (currDepth == depth) {
				this.stack.push(node);
			} else {
				arr = node.children;
				arr.reverse();
				for (child in arr) {
					stackOfNode.push(child);
					stackOfDepth.push(currDepth + 1);
				}
			}
		}
	}

	public function populateStackLeaves():Void {
		var arr = new Array<Node>();
		var node:Node = this.root;
		var stack:Array<Node> = new Array<Node>();

		stack.push(node);
		while (true) {
			try {
				node = stack.pop();
			} catch (e:haxe.Exception) {
				trace(e.message, 11);
				break;
			}
			if (node == null) {
				break;
			}
			if (node.children.length == 0) {
				this.stack.push(node);
			} else {
				arr = node.children;
				arr.reverse();
				for (child in arr) {
					stack.push(child);
				}
			}
		}
	}

	public function populateStackNodes():Void {
		var arr:Array<Node> = new Array<Node>();
		var node:Node = this.root;
		var stack:Array<Node> = new Array<Node>();

		stack.push(node);
		while (true) {
			try {
				node = stack.pop();
			} catch (e:haxe.Exception) {
				trace(e.message, 11);
				break;
			}
			if (node == null) {
				break;
			}
			if (node.children.length == 0) {
				this.stack.push(node);
			} else {
				this.stack.push(node);
				arr = node.children;
				arr.reverse();
				for (child in arr) {
					stack.push(child);
				}
			}
		}
	}

	public function next():Node {
		return this.stack.pop();
	}

	public function hasNext():Bool {
		return this.stack.length > 0;
	}
}
