import Sys;
import mcli.Dispatch;
import src.TreeSolver as Ts;
import src.Node as Nd;
import src.Utils;

/**
	This is a sample programm that solves ege problems. Enjoy!
	Possible modes are : 19 , 20 , 21.
**/
class Ege_cli extends mcli.CommandLine {
	/**
		Should the tree be printed(Bool).
	**/
	public var verbose:Bool;

	/**
		Winnig value in the tree(only for 2 piles).
	**/
	public var max_range:Int = 0;

	/**
		Start value for 2 pile trees.
	**/
	public var start_value:Int = 0;

	/**
		for mode 19 - depth of a tree.
	**/
	public var depth:Int = 0;

	public function runDefault(mode:Int, maxVal:Int, operations:String) {
		switch (mode) {
			case 19:
				solve19(maxVal, operations);
			case 20:
				solve20(maxVal, operations);
			case 21:
				solve21(maxVal, operations);
		}
	}

	private function solve21(maxVal:Int, operations:String) {
		var solutions:Array<Int> = [];
		var tree:src.Node;
		var local_depth:Int = depth;
		var oper = Utils.trimAll(operations.split(','));
		var values:Array<Int> = [];
		if (start_value != 0) {
			values.push(start_value);
		}
		if (max_range == 0) {
			max_range = maxVal;
		}
		if (local_depth == 0) {
			local_depth = 5;
		}

		for (i in 1...max_range + 1) {
			values.push(i);
			tree = Nd.constructTree(values, oper, local_depth);
			if (Ts.solveTree(tree, maxVal, dnm(3))) {
				solutions.push(i);
			}
			if (verbose) {
				Sys.println(tree.getPrintableTree());
			}
			values.pop();
		}
		Sys.println(solutions);
	}

	private function solve20(maxVal:Int, operations:String) {
		var solutions:Array<Int> = [];
		var tree:src.Node;
		var oper = Utils.trimAll(operations.split(','));
		var values:Array<Int> = [];
		var local_depth:Int = depth;
		if (start_value != 0) {
			values.push(start_value);
		}
		if (max_range == 0) {
			max_range = maxVal;
		}
		if (local_depth == 0) {
			local_depth = 4;
		}

		for (i in 1...max_range + 1) {
			values.push(i);
			tree = Nd.constructTree(values, oper, local_depth);
			if (Ts.solveTree(tree, maxVal, d)) {
				solutions.push(i);
			}
			if (verbose) {
				Sys.println(tree.getPrintableTree());
			}
			values.pop();
		}
		Sys.println(solutions);
	}

	private function solve19(maxVal:Int, operations:String) {
		var solutions:Array<Int> = [];
		var tree:src.Node;
		var oper = Utils.trimAll(operations.split(','));
		var values:Array<Int> = [];
		var local_depth:Int = depth;
		if (start_value != 0) {
			values.push(start_value);
		}
		if (max_range == 0) {
			max_range = maxVal;
		}
		if (local_depth == 0) {
			local_depth = 3;
		}

		for (i in 1...max_range + 1) {
			values.push(i);
			tree = Nd.constructTree(values, oper, local_depth);
			if (Ts.solveTree(tree, maxVal, m)) {
				solutions.push(i);
			}
			if (verbose) {
				Sys.println(tree.getPrintableTree());
			}
			values.pop();
		}
		Sys.println(solutions);
	}

	/**
		Show  this message.
	**/
	public function help() {
		Sys.println(this.showUsage());
		Sys.exit(0);
	}

	static public function main() {
		new Dispatch(Sys.args()).dispatch(new Ege_cli());
	}
}
