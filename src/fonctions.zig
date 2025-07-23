const std = @import("std");
const enums = @import("enums.zig");

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

pub fn couleur(case: enums.case) enums.case {
    if (case == enums.case.BLEU or case == enums.case.BLEU_FLEUR) {
        return enums.case.BLEU;
    }
    if (case == enums.case.ROUGE or case == enums.case.ROUGE_FLEUR) {
        return enums.case.ROUGE;
    }

    return enums.VIDE;
}

pub fn estFleurOcc(case: enums.case) bool {
    return if (case == enums.case.BLEU_FLEUR or case == enums.case.ROUGE_FLEUR) true else false;
}
