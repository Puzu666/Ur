const case = enum {
    VIDE,
    FLEUR,
    BLEU,
    ROUGE,
    BLEU_FLEUR,
    ROUGE_FLEUR,
    FIN,
};

const Ur_Errors = error{
    PIECE_SANS_TYPE,
    CASE_SANS_PIECE,
    TOUTES_LES_PIECES_SONT_JOUEES,
    DEPLACEMENT_IMPOSSIBLE,
};
