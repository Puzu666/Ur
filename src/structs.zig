const std = @import("std");

const err = @import("errorsets.zig");
const enums = @import("enums.zig");
const f = @import("fonctions.zig");

const Piece = struct {
    var Type = enums.case.VIDE;
};

const Coup = struct {
    var piece = enums.case.VIDE;
    var posIni: u8 = 0;
    var posFin: u8 = 0;

    pub fn coupValide(plateau: Plateau) err.Ur_Errors!bool {
        if (posFin - posIni > 4) {
            return err.Ur_Errors.DEPLACEMENT_IMPOSSIBLE;
        }

        if (posIni == -1) {
            if (plateau.countPiece(f.couleur(piece.Type) == enums.case.BLEU) > 8) {
                return err.Ur_Errors.TOUTES_LES_PIECES_SONT_JOUEES;
            }
        }

        if (f.couleur(plateau.getCase(posIni).Type) != f.couleur(piece.Type)) {
            return err.Ur_Errors.CASE_SANS_PIECE;
        }

        if (posFin > 16) {
            return false;
        }

        if (f.couleur(plateau.getCase(posFin).Type) == f.couleur(piece.Type) or f.estFleurOcc(plateau.getCase(posFin).Type)) {
            return false;
        }

        return true;
    }
};

const Plateau = struct {
    var debut_bleu: [4]Piece = {};
    var debut_rouge: [4]Piece = {};
    var territoire_contestee: [9]Piece = {};
    var fin_bleu: [3]Piece = {};
    var fin_rouge: [3]Piece = {};

    pub fn getCase(index: u8, couleur: bool) enums.case {
        if (index < 4) {
            return if (couleur) debut_bleu[index] else debut_rouge[index];
        } else if (index >= 13) {
            return if (couleur) fin_bleu[index] else fin_rouge[index];
        } else {
            return territoire_contestee[index - 4];
        }
    }

    pub fn countPiece(couleur: bool) u8 {
        var temp: u8 = 0;

        if (couleur) {
            for (debut_bleu) |elem| {
                if (couleur(elem) == enums.case.BLEU) {
                    temp += 1;
                }
            }
            for (fin_bleu) |elem| {
                if (couleur(elem) == enums.case.BLEU) {
                    temp += 1;
                }
            }
            for (territoire_contestee) |elem| {
                if (couleur(elem) == enums.case.BLEU) {
                    temp += 1;
                }
            }
        } else {
            for (debut_rouge) |elem| {
                if (couleur(elem) == enums.case.ROUGE) {
                    temp += 1;
                }
            }
            for (fin_rouge) |elem| {
                if (couleur(elem) == enums.case.ROUGE) {
                    temp += 1;
                }
            }
            for (territoire_contestee) |elem| {
                if (couleur(elem) == enums.case.ROUGE) {
                    temp += 1;
                }
            }
        }

        return temp;
    }
};
