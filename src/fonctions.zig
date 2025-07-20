const std = @import("std");

pub fn lancer() u4 {
    var g = std.Random.DefaultPrng.init(@intCast(std.time.nanoTimestamp()));
    const random = g.random();

    var resultat: u4 = 0;
    var i: u4 = 0;

    while (i < 4) : (i += 1) {
        resultat += random.intRangeAtMost(u4, 0, 1);
    }

    return resultat;
}
