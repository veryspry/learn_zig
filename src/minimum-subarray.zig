const std = @import("std");

// https://leetcode.com/problems/minimum-size-subarray-sum/description/


// iterate array and create solutions.
// each solution will have start index and length
// at end of array

fn minimumSubarray(list: []const i32, target: i32) usize {
	var result: usize = 0;

	for (list, 0..) |item1, i| {
		if (item1 == target) {
			result = 1;
			break;
		}

		var sum = item1;
		for (list[i + 1..], 0..) |item2, j| {
			// plus one to account for zero based index
			// plus another one to account for item1
			const resLen = j + 2;

			if (sum + item2 > target) {
				break;
			}

			if (result != 0 and resLen > result) {
				break;
			}

			if (sum + item2 == target) {
				result = resLen;
				break;
			}

			sum = sum + item2;
		}
	}

	return result;
}

fn min(a: usize, b: usize) usize {
	return if (a < b) a else b;
}

fn minimumSubarrayWindow(list: []const i32, target: i32) usize {
	const infinity = std.math.maxInt(usize);
	var result: usize = infinity;

	var leftIdx: usize = 0;
	var rightIdx: usize = 1;

	// temp sum for use with windows
	var sum: i32 = list[leftIdx] + list[rightIdx];

	while (leftIdx < list.len) {
		// if sum equals target we have a new result to check and pointers to move
		// if sum is greater than target we need to shrink the window from the left
		// if sum is less than target we need to increase the window from the right

		if (list[leftIdx] == target or list[rightIdx] == target) {
			result = 1;
			break;
		}

		std.debug.print("Result: {}, Sum: {}\n", .{result, sum});

		if (sum < target) {
			if (rightIdx == list.len - 1) {
				std.debug.print("No result, right at the end. leftIdx: {}, rightIdx: {}\n", .{leftIdx, rightIdx});
				// if right is at end and sum is still less than target,
				// we can't find a(nother) solution
				break;
			} else {
				std.debug.print("Expanding window to the right. leftIdx: {}, rightIdx: {}\n", .{leftIdx, rightIdx});
				// expand the window to the right and check new sum
				rightIdx = rightIdx + 1;
				sum = sum + list[rightIdx];
				continue;
			}
		}

		if (sum == target) {
			result = min(result, rightIdx - leftIdx + 1);
			std.debug.print("Found target. leftIdx: {}, rightIdx: {}, result: {}\n", .{leftIdx, rightIdx, result});
		} else {
			std.debug.print("Sum is greater than target. leftIdx: {}, rightIdx: {}\n", .{leftIdx, rightIdx});
		}

		// if a target was reached or exceeded, reset the window and keep trying
		leftIdx = if (leftIdx + 1 < list.len - 1) leftIdx + 1 else leftIdx;
		rightIdx = if (leftIdx + 1 < list.len - 1) leftIdx + 1 else leftIdx;

		sum = list[leftIdx] + list[rightIdx];
	}

	return if (result == infinity) 0 else result;
}


test "minimumSubarray() and minimumSubarrayWindow()" {
	// target: 7
	// expect: 2
	var arr1 = [6]i32{2,3,1,2,4,3};
	// try std.testing.expectEqual(2, minimumSubarray(&arr1, 7));
	try std.testing.expectEqual(2, minimumSubarrayWindow(&arr1, 7));

	// target: 4
	// expect: 1
	var arr2 = [3]i32{1,4,4};
	// try std.testing.expectEqual(1, minimumSubarray(&arr2, 4));
	try std.testing.expectEqual(1, minimumSubarrayWindow(&arr2, 4));

	// target: 11
	// expect: 0
	var arr3 = [8]i32{1,1,1,1,1,1,1,1};
	// try std.testing.expectEqual(0, minimumSubarray(&arr3, 11));
	try std.testing.expectEqual(0, minimumSubarrayWindow(&arr3, 11));

	// target: 5
	// expect: 2
	var arr4 = [5]i32{2, 3, 2, 2, 1};
	// try std.testing.expectEqual(2, minimumSubarray(&arr4, 5));
	try std.testing.expectEqual(2, minimumSubarrayWindow(&arr4, 5));

	// target: 5
	// expect: 1
	var arr5 = [5]i32{5, 1, 2, 2, 3};
	// try std.testing.expectEqual(1, minimumSubarray(&arr5, 5));
	try std.testing.expectEqual(1, minimumSubarrayWindow(&arr5, 5));
}
