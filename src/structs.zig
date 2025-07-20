const enums = @import("enums.zig");
const std = @import("std");
const f = @import("fonctions.zig");

const Plateau = struct {
    var plateau = enums.case[2][15];

    //pub fn move(joueur: Joueur) void {
    //const input = std.io.getStdIn().reader();

    // if (input != 'Q') {}
    //}
};

const Joueur = struct {
    const couleur: enums.case = enums.case.BLANC;
    var piece_depart: u4 = 7;
    var piece_fin: u4 = 0;

    pub fn victoire() bool {
        return piece_fin == 7;
    }
};
