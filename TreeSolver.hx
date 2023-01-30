package;

import Lambda;

enum Mode {
	d;
	m;
	dnm(depth:Int);
}

class TreeSolver {
	static public function evalNodes(root:Node, max:Int):Void {
		var isDescending:Bool = root.oper.charAt(0) == '-';
		for (node in root) {
			if (isDescending) {
				if (Utils.sum(node.values) < max) {
					node.isOver = true;
				}
			} else {
				if (Utils.sum(node.values) > max) {
					node.isOver = true;
				}
			}
		}
	}

	static public function solveTree(root:Node, max:Int, mode:Mode):Bool {
		function solveSimpleCases(root:Node, mode:String, depth:Int = -1):Void {
			var iter:TreeIterator;
			var condition:Bool;
			if (depth == -1) {
				depth = root.depth;
			}
			var range:Array<Int> = [for (i in 1...depth + 1) i];

			range.reverse();
			for (i in range) {
				condition = i % 2 == depth % 2;
				iter = new TreeIterator(root, 'nthNodes', i);
				for (node in iter) {
					if (node.isOver) {
						if (condition) {
							node.isWinning = true;
						} else {
							node.isWinning = false;
						}
					} else if (i == depth) {
						if (node.isOver) {
							node.isWinning = true;
						} else {
							node.isWinning = false;
						}
					} else {
						if (!condition && mode == 'does') {
							if (Lambda.count(node.children, (child:Node) -> child.isWinning == true) > 0) {
								node.isWinning = true;
							} else {
								node.isWinning = false;
							}
						} else if (condition && mode == 'does') {
							if (Lambda.count(node.children, (child:Node) -> child.isWinning == false) == 0) {
								node.isWinning = true;
							} else {
								node.isWinning = false;
							}
						} else if (mode == 'maybe') {
							if (Lambda.count(node.children, (child:Node) -> child.isWinning == true) > 0) {
								node.isWinning = true;
							} else {
								node.isWinning = false;
							}
						}
					}
				}
			}
		}

		var result:Bool = true;
		evalNodes(root, max);
		switch (mode) {
			case d:
				solveSimpleCases(root, 'does', 2);
				result = root.isWinning == false;
				solveSimpleCases(root, 'does');
			case m:
				solveSimpleCases(root, 'maybe');
			case dnm(depth):
				solveSimpleCases(root, 'does', depth);
				result = root.isWinning == false;
				solveSimpleCases(root, 'does');
			case _:
				trace(1);
		}
		return root.isWinning == true && result;
	}
}
