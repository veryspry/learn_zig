const std = @import("std");

// todo accept variable inputs here like u64 u32 etc.
fn nthFibonacciLoop(n: u64) u64 {
	// 0, 1, 1, 2, 3, 5, 8, 13, 21, 34
	if (n == 0) return 0;
	if (n == 1) return 1;

	var res: u64 = 0;

	var prev1: u64 = 0;
	var prev2: u64 = 1;

	var i: usize = 1;
	while (i < n): (i += 1) {
		res = prev1 + prev2;
		prev1 = prev2;
		prev2 = res;
	}

	return res;
}

test "nthFibonacciLoop(): Correctly calculates sum of fibonacci sequence to given level" {
	try std.testing.expectEqual(0, nthFibonacciLoop(0));
	try std.testing.expectEqual(1, nthFibonacciLoop(1));
	try std.testing.expectEqual(1, nthFibonacciLoop(2));
	try std.testing.expectEqual(21, nthFibonacciLoop(8));
}

fn nthFibonacciRecursive(n: u64) u64 {
	if (n <= 1) return n;

	return nthFibonacciRecursive(n - 1) + nthFibonacciRecursive(n - 2);
}

test "nthFibonacciRecursive(): Correctly calculates sum of fibonacci sequence to given level" {
	try std.testing.expectEqual(0, nthFibonacciRecursive(0));
	try std.testing.expectEqual(1, nthFibonacciRecursive(1));
	try std.testing.expectEqual(1, nthFibonacciRecursive(2));
	try std.testing.expectEqual(21, nthFibonacciRecursive(8));
}
