const std = @import("std");

// create a binary search tree from an array (function for this)
// create function to search the tree
// Create AVL tree. Aka self-balancing binary search tree

const Node = struct {
    value: i32,
    left: ?*Node = null,
    right: ?*Node = null,
};

fn createBinarySearchTree(allocator: std.mem.Allocator, values: []const i32) !?*Node {
    if (values.len == 0) return null;

    const mid = if (values.len % 2 == 0) values.len / 2 else (values.len - 1) / 2;

    const root = try allocator.create(Node);
    root.* = Node{ .value = values[mid] };

    std.debug.print("Mid: {}\n", .{mid});

    root.left = try createBinarySearchTree(allocator, values[0..mid]);
    root.right = try createBinarySearchTree(allocator, values[mid + 1..]);

    return root;
}

fn freeTree(allocator: std.mem.Allocator, node: ?*Node) void {
    if (node) |n| {
    	freeTree(allocator, n.left);
    	freeTree(allocator, n.right);
    	allocator.destroy(n);
    }
}

test "createBinarySearchTree()" {
	var gpa = std.heap.GeneralPurposeAllocator(.{}){};
	defer _ = gpa.deinit();
	const allocator = gpa.allocator();

    const tree = try createBinarySearchTree(allocator, &[_]i32{1, 2, 3, 4, 5});
    defer freeTree(allocator, tree);
    std.debug.print("Tree: {any}\n", .{tree});

    try std.testing.expect(tree != null);
    try std.testing.expect(tree.?.value == 3);
    try std.testing.expect(tree.?.left != null);
    try std.testing.expect(tree.?.left.?.value == 2);
    try std.testing.expect(tree.?.right != null);
    try std.testing.expect(tree.?.right.?.value == 5);
}
