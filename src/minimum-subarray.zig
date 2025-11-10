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

test "minimumSubarray" {
	// target: 7
	// expect: 2
	var arr1 = [6]i32{2,3,1,2,4,3};
	try std.testing.expectEqual(2, minimumSubarray(&arr1, 7));

	// target: 4
	// expect: 1
	var arr2 = [3]i32{1,4,4};
	try std.testing.expectEqual(1, minimumSubarray(&arr2, 4));

	// target: 11
	// expect: 0
	var arr3 = [8]i32{1,1,1,1,1,1,1,1};
	try std.testing.expectEqual(0, minimumSubarray(&arr3, 11));

	// target: 5
	// expect: 2
	var arr4 = [5]i32{2, 3, 2, 2, 1};
	try std.testing.expectEqual(2, minimumSubarray(&arr4, 5));

	// target: 5
	// expect: 1
	var arr5 = [5]i32{5, 1, 2, 2, 3};
	try std.testing.expectEqual(1, minimumSubarray(&arr5, 5));
}
