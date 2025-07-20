const std = @import("std");

const f = @import("fonctions.zig");

const stdReader = std.io.getStdIn().reader();
const stdWriter = std.io.getStdOut().writer();
var buffer: [20]u8 = undefined;
pub fn main() !void {
    const resultat = f.lancer();
    try stdWriter.print("Allo! : {}\n", .{resultat});
}
