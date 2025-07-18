const std = @import("std");

pub fn lancer() u4 {
    var resultat: u8 = 0;
    var i: u4 = 0;

    while (i < 4) : (i += 1) {
        resultat += std.Random.intRangeAtMost(0, 1);
    }

    return resultat;
}
