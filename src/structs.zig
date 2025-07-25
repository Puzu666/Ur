const std = @import("std");

const enums = @import("enums.zig");
const f = @import("fonctions.zig");

const Piece = struct {
    var Type = enums.case.VIDE;
};

const Coup = struct {
    var piece = enums.case.VIDE;
    var posIni: i8 = 0;
    var posFin: u8 = 0;

    pub fn coupValide(plateau: Plateau) bool {
        if (posFin - posIni > 4) {
            unreachable;
        }

        if (posIni == -1) {
            if (plateau.countPiece(f.couleur(piece.Type) == enums.case.BLEU) > 8) {
                unreachable;
            }
        }

        if (f.couleur(plateau.getCase(posIni).Type) != f.couleur(piece.Type)) {
            unreachable;
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

    pub fn initialisation() void {
        const vide: Piece = enums.case.VIDE;
        const fleur: Piece = enums.case.FLEUR;
        const fin: Piece = enums.case.FIN;
        for (0..3) |index| {
            debut_bleu[index] = vide;
            debut_rouge[index] = vide;
        }
        debut_bleu[3] = fleur;
        debut_rouge[3] = fleur;

        for (0..8) |index| {
            territoire_contestee[index] = vide;
        }
        territoire_contestee[3] = fleur;

        fin_bleu[0] = vide;
        fin_rouge[0] = vide;

        fin_bleu[1] = fleur;
        fin_rouge[1] = fleur;

        fin_bleu[2] = fin;
        fin_rouge[2] = fin;
    }

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
        const tempCouleur: enums.case = if (couleur) enums.case.BLEU else enums.case.ROUGE;
        const debut: [4]Piece = if (couleur) debut_bleu else debut_rouge;
        const fin: [3]Piece = if (couleur) fin_bleu else fin_rouge;
        for (debut) |elem| {
            if (couleur(elem) == tempCouleur) {
                temp += 1;
            }
        }
        for (fin) |elem| {
            if (couleur(elem) == tempCouleur) {
                temp += 1;
            }
        }
        for (territoire_contestee) |elem| {
            if (couleur(elem) == tempCouleur) {
                temp += 1;
            }
        }
        return temp;
    }

    pub fn setCase(index: u8, piece: Piece, couleur: bool) void {
        const caseFleur: Piece = if (couleur(piece.Type) == enums.case.VIDE) enums.case.FLEUR else if (couleur) enums.case.BLEU_FLEUR else enums.case.ROUGE_FLEUR;
        if (index < 3) {
            if (couleur) {
                debut_bleu[index] = piece;
            } else {
                debut_rouge[index] = piece;
            }
        } else if (index == 3) {
            if (couleur) {
                debut_bleu[index] = caseFleur;
            } else {
                debut_rouge[index] = caseFleur;
            }
        } else if (index == 13) {
            if (couleur) {
                fin_bleu[index - 13] = piece;
            } else {
                fin_rouge[index - 13] = piece;
            }
        } else if (index == 14) {
            if (couleur) {
                fin_bleu[index - 13] = caseFleur;
            } else {
                fin_rouge[index - 13] = caseFleur;
            }
        } else if (index == 7) {
            territoire_contestee[index - 4] = caseFleur;
        } else {
            territoire_contestee[index - 4] = piece;
        }
    }

    pub fn move(coup: Coup, joueurs: Joueurs) bool {
        const couleur = f.couleur(coup.piece.Type) == enums.case.BLEU;
        const joueur = if (couleur == enums.case.BLEU) joueurs.bleu else joueurs.rouge;
        if (!coup.coupValide()) {
            return false;
        }
        if (coup.posIni == -1) {
            joueur -= 1;
        } else {
            if (f.estFleurOcc(coup.Piece.Type)) {
                const temp: Piece = enums.case.FLEUR;
                setCase(coup.posIni, temp, couleur);
            } else {
                const temp: Piece = enums.case.VIDE;
                setCase(coup.posIni, temp, couleur);
            }
        }
        if (coup.posFin != 15) {
            if (getCase(coup.posFin).Type == enums.case.FLEUR) {
                const temp: Piece = if (couleur) enums.case.BLEU_FLEUR else enums.case.ROUGE_FLEUR;
                setCase(coup.posFin, temp, couleur);
            } else {
                const temp: Piece = if (couleur) enums.case.BLEU else enums.case.ROUGE;
                setCase(coup.posFin, temp, couleur);
            }
        }
        return true;
    }
};

const Joueurs = struct {
    var bleu = 7;
    var rouge = 7;
};
