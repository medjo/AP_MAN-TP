package Compression is

	--type Octet;
    --type Tab_Char;
    type Tab_Char is array (Integer range 0..255) of Integer;

    procedure Lecture_Fichier(Nom_Fichier_In : in String ; Tab_Occurrences : in out Tab_Char ; Taille_Tab : Integer ; Nb_Prio : in out Integer);

    procedure creation_arbre_Huff();

end Compression;
