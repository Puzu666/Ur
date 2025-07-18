const std = @import("std");
const structs = @import("structs.zig");
const enums = @import("enums.zig");
const f = @import("fonctions.zig");

pub fn main() void {
    var joueur1 = structs.Joueur{};
    var joueur2 = structs.Joueur{ .couleur = enums.case.NOIR };
}
