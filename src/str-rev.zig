const std = @import("std");

fn str_rev(allocator: std.mem.Allocator, s: []const u8) ![]u8 {
	const rev = try allocator.alloc(u8, s.len);

	var i: usize = 0;
	var itr = std.mem.reverseIterator(s);
	while (itr.next()) |letter| {
		rev[i] = letter;
		i += 1;
	}

	return rev;
}

test "Expect reversed string" {
	var gpa = std.heap.GeneralPurposeAllocator(std.heap.GeneralPurposeAllocatorConfig{}){};
	defer _ = gpa.deinit();
	const allocator = gpa.allocator();

	const res1 = try str_rev(allocator, "hello");
	defer allocator.free(res1);
	try std.testing.expectEqualStrings(res1, "olleh");

	const res2 = try str_rev(allocator, "world");
	defer allocator.free(res2);
	try std.testing.expectEqualStrings(res2, "dlrow");

	const res3 = try str_rev(allocator, "zig");
	defer allocator.free(res3);
	try std.testing.expectEqualStrings(res3, "giz");
}
