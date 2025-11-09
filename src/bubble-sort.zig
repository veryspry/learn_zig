const std = @import("std");

fn bubbleSort(list: []i32) void {
	for (list) |_| {
		for (list, 0..) |item, j| {
			if (j == list.len - 1) break;
			if (item > list[j + 1]) {
				const temp = item;
				list[j] = list[j + 1];
				list[j + 1] = temp;
			}
		}
	}
}

test "bubbleSort()" {
	var arr1 = [_]i32{3, 2, 1};
	bubbleSort(&arr1);
	try std.testing.expectEqualSlices(i32, &[_]i32{1, 2, 3}, &arr1);

	var arr2 = [_]i32{3090, 2000, 1, 723, 87, 5000};
	bubbleSort(&arr2);
	try std.testing.expectEqualSlices(i32, &[_]i32{1, 87, 723, 2000, 3090, 5000}, &arr2);
}
