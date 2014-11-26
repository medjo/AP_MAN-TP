with File_Priorite;
package Compression is

	--type Octet;
    --type Tab_Char;
    type Tab_Char is array (Integer range 0..255) of Integer;

    procedure Lecture_Fichier(Nom_Fichier_In : in String ; Tab_Occurrences : in out Tab_Char ; Nb_Prio : in out Integer);

    function Creation_File_Prio(Tab_Occ : in Tab_Char ; Nb_Prio : in Integer) return File_Prio;

end Compression;
