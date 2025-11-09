const std = @import("std");
const learn_zig = @import("learn_zig");

// read a file and ensure that each line is a given length.
// if a word causes the given length to be exceeded, then that word should go to the next line
// if a line is shorter than the given length, the following line should be merged with it.
// write the output to a new file.
// first case is to assume the file is a single line.
// then move on to assuming it is multi-line.

pub fn main() !void {
	const fileName = "lorem-ipusum.txt";
	var file = try std.fs.cwd().openFile(fileName, .{});
	defer file.close();

	var buf: [1024 * 1024]u8 = undefined;
	var reader = std.fs.File.stdin().reader(&buf);

	// var alloc = std.heap.DebugAllocator(.{}).init;
    // defer _ = alloc.deinit();
    // const alloc = std.mem.Allocator;
    var arena = std.heap.ArenaAllocator.init(std.heap.direct_allocator);
    defer arena.deinit();

    const alloc = &arena.allocator;

	var line_writer = std.Io.Writer.Allocating.init(alloc);
    defer line_writer.deinit();

    while (reader.interface.streamDelimiter(&line_writer.writer, '\n')) |_| {
            const line = line_writer.written();
            std.debug.print("{s}\n", .{line});
            line_writer.clearRetainingCapacity(); // empty the line buffer
            reader.interface.toss(1); // skip the newline
    } else |err| if (err != error.EndOfStream) return err;
}

pub fn createAllocator() !std.mem.Allocator {
    var gpa = std.heap.GeneralPurposeAllocator.init(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    return alloc;
}

pub fn parseArgs() !void {
	var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    var args = try std.process.argsWithAllocator(alloc);
    defer args.deinit();

    while (args.next()) |arg| {
        std.debug.print("{s}\n", .{arg});
    }
}
