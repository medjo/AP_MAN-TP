with huffman; use huffman;
with File_Priorite;

package Compression is

    function Est_Prioritaire(P1, P2 : Integer) return Boolean;

    package FP is new File_Priorite(Arbre, Natural, Est_Prioritaire);
    use FP;

    type Tab_Char is array (Integer range 0..255) of Integer;

    procedure Lecture_Fichier(Nom_Fichier_In : in String ; Tab_Occurrences : in out Tab_Char ; Nb_Prio : in out Integer);

    procedure Creation_Arbre_Huff(Tab_Occ : in Tab_Char ; Nb_Prio : in Integer ; Nb_Carac : out Natural ; A : in out Arbre);

    --Fusionne les deux éléments les plus prioritaires et place la fusion dans la file de Priorité
    function Fusionne_2_Premiers(F : File_Prio) return Arbre;

end Compression;
