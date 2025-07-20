const enums = @import("enums.zig");
const std = @import("std");
const f = @import("fonctions.zig");

const Piece = struct {
    const Type = enums.case.VIDE;
};

const Plateau = struct {
    var debut_bleu: [4]Piece = {};
    var debut_rouge: [4]Piece = {};
    var territoire_contestee: [9]Piece = {};
    var fin_bleu: [3]Piece = {};
    var fin_rouge: [3]Piece = {};
};
