const std = @import("std");
const print = std.debug.print;

fn toUpper(allocator: std.mem.Allocator, input: []const u8) ![]u8 {
	var result = try allocator.alloc(u8, input.len);

	// 97-122 (inclusive)
	for (input, 0..) |c, i| {
		if (c >= 'a' and c <= 'z') {
			result[i] = c - 32;
		} else {
			result[i] = c;
		}
	}

	return result;
}

test "toUpper(): Correctly converts lowercase to uppercase" {
	const allocator = std.testing.allocator;

	const res1 = try toUpper(allocator, "hello");
	defer allocator.free(res1);
	try std.testing.expectEqualStrings("HELLO", res1);

	const res2 = try toUpper(allocator, "world");
	defer allocator.free(res2);
	try std.testing.expectEqualStrings("WORLD", res2);

	const res3 = try toUpper(allocator, "zig");
	defer allocator.free(res3);
	try std.testing.expectEqualStrings("ZIG", res3);

	const res4 = try toUpper(allocator, "Zig");
	defer allocator.free(res4);
	try std.testing.expectEqualStrings("ZIG", res4);
}
