const std = @import("std");
const print = std.debug.print;

fn toLower(allocator: std.mem.Allocator, input: []const u8) ![]u8 {
	var result = try allocator.alloc(u8, input.len);

	// 65 - 90 inclusive
	for (input, 0..) |c, i| {
		if (c >= 'A' and c <= 'Z') {
			result[i] = c + 32;
		} else {
			result[i] = c;
		}
	}
	return result;
}

test "toLower(): Correctly converts lowercase to uppercase" {
	const allocator = std.testing.allocator;

	const res1 = try toLower(allocator, "HELLO");
	defer allocator.free(res1);
	try std.testing.expectEqualStrings("hello", res1);

	const res2 = try toLower(allocator, "WORLD");
	defer allocator.free(res2);
	try std.testing.expectEqualStrings("world", res2);

	const res3 = try toLower(allocator, "Zig");
	defer allocator.free(res3);
	try std.testing.expectEqualStrings("zig", res3);

	const res4 = try toLower(allocator, "Lorem Ipsum");
	defer allocator.free(res4);
	try std.testing.expectEqualStrings("lorem ipsum", res4);
}
