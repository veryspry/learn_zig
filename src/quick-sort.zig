const std = @import("std");

fn quickSort(list: []i32) void {
	if (list.len <= 1) return; // empty / single element slice is already sorted.

	const pivot = list.len - 1;

	var i: usize = 0;

	for (list, 0..) |item, j| {
		if (j == pivot) break;
		if (item < list[pivot]) {
			std.mem.swap(i32, &list[i], &list[j]);
			i += 1;
		}
	}

	std.mem.swap(i32, &list[i], &list[pivot]);

	quickSort(list[0..i]);
	quickSort(list[i + 1..]);
}


test "quickSort()" {
	var arr1 = [_]i32{3, 2, 1};
	quickSort(&arr1);
	try std.testing.expectEqualSlices(i32, &[_]i32{1, 2, 3}, &arr1);

	var arr2 = [_]i32{10, 7, 12, 8, 3, 6, 2};
	quickSort(&arr2);
	try std.testing.expectEqualSlices(i32, &[_]i32{2, 3, 6, 7, 8, 10, 12}, &arr2);
}
