const std = @import("std");

fn getMidPoint(list: []const i32) usize {
	return if (list.len % 2 == 0) list.len / 2 else (list.len - 1) / 2;
}

fn binarySearch(list: []const i32, target: i32) i32 {
	var left: usize = 0;
	var right: usize = list.len - 1;

	while (left <= right) {
		const mid = left + (right - left) / 2;

		if (list[mid] < target) {
			left = mid + 1;
		} else if (list[mid] > target) {
			if (mid <= 0) break; // typeof usize cannot be negative
			right = mid - 1;
		} else {
			return @intCast(mid);
		}
	}

	return -1;
}

test "binarySearch()" {
    const arr1 = [_]i32{1, 2, 3, 4, 5};
    try std.testing.expectEqual(2, binarySearch(&arr1, 3));

    const arr2 = [_]i32{1, 2, 3, 4, 5, 6};
    try std.testing.expectEqual(4, binarySearch(&arr2, 5));

    const arr3 = [_]i32{1, 2, 3, 4, 5};
    try std.testing.expectEqual(-1, binarySearch(&arr3, 6));

    const arr4 = [_]i32{'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
    try std.testing.expectEqual(0, binarySearch(&arr4, 'a'));
    try std.testing.expectEqual(25, binarySearch(&arr4, 'z'));
    try std.testing.expectEqual(-1, binarySearch(&arr4, 'A'));
    try std.testing.expectEqual(-1, binarySearch(&arr4, '}'));
    try std.testing.expectEqual(6, binarySearch(&arr4, 'g'));
}
