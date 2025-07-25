const std = @import("std");
const enums = @import("enums.zig");
const stru: type = @import("structs.zig");

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

pub fn victoire(Couleur: bool, joueurs: stru.Joueurs, plateau: stru.Plateau) bool {
    const temp: enums.case = if (Couleur) enums.case.BLEU else enums.case.ROUGE;
    const plateauVide: bool = false;
    for (0..15) |index| {
        if (couleur(plateau.getCase(index)) == temp) {
            plateauVide = true;
        }
    }

    if (Couleur) {
        return joueurs.bleu == 0 and plateauVide;
    }
}

pub fn creerCoup(deplacement: u4, posIni: i8, plateau: stru.Plateau, Couleur: bool, joueurs: stru.Joueurs) bool!stru.Coup {
    const tempCouleur = if (Couleur) enums.case.BLEU else enums.case.ROUGE;
    const joueur = if (Couleur) joueurs.bleu else joueurs.rouge;
    if (posIni != -1) {
        if (couleur(plateau.getCase(posIni)) != tempCouleur) {
            unreachable;
        }
    } else if (joueur == 0) {
        unreachable;
    }

    const coup: stru.Coup = {};
    const tempPiece: stru.Piece = if (estFleurOcc(plateau.getCase(posIni))) (if (Couleur) enums.Type.BLEU_FLEUR else enums.Type.ROUGE_FLEUR) else (if (Couleur) enums.Type.BLEU else enums.Type.ROUGE);

    coup.piece = tempPiece;
    coup.posIni = posIni;
    coup.posFin = posIni + deplacement;

    const valide: bool = coup.coupValide();

    if (!valide) {
        return false;
    }

    return coup;
}
