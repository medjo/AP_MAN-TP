with huffman; use huffman; 

package Compression is

    type Tab_Char is array (Integer range 0..255) of Integer;

    procedure Lecture_Fichier(Nom_Fichier_In : in String ; Tab_Occurrences : in out Tab_Char ; Nb_Prio : in out Integer);

    procedure Creation_Arbre_Huff(Tab_Occ : in Tab_Char ; Nb_Prio : in Integer ; Nb_Carac : out Natural ; A : in out Arbre);

--DANS PACKAGE HUFFMAN : 
--    --Fusionne les deux éléments les plus prioritaires et place la fusion dans la file de Priorité
--    function Fusionne_2_Premiers(F : File_Prio) return Arbre;

end Compression;
