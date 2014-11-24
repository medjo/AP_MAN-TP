with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_Io; use Ada.Text_Io;

package body  Compression is


	type Octet is new Integer range 0 .. 255;
	for Octet'Size use 8; -- permet d'utiliser Octet'Input et Octet'Output,

    --Lis le Fichier et compte le nombre d'occurences pour chaque charactère présent
    procedure Lecture_Fichier(Nom_Fichier_In : in String ; Tab_Occurrences : in out Tab_Char ; Taille_Tab : Integer ; Nb_Prio : in out Integer) is
		Fichier : Ada.Streams.Stream_IO.File_Type;
		Flux : Ada.Streams.Stream_IO.Stream_Access;
		C : Character;
    begin
		Open(Fichier, In_File, Nom_Fichier_In);
		Flux := Stream(Fichier);
        while not End_Of_File(Fichier) loop
			C := Character'Input(Flux); 
            Put(C);
            if Character'Pos(C) in Tab_Char'range then
                Tab_Occurrences(Character'Pos(C)) := Tab_Occurrences(Character'Pos(C)) + 1;
            else
                Put("Tentative d'écriture en dehors du tableau");
            end if;
        end loop;
        Nb_Prio := 0;
        for I in Tab_Occurrences'range loop
            if Tab_Occurrences(I) /= 0 then
                Nb_Prio := Nb_Prio + 1;
            end if;
        end 
        return;
    end Lecture_Fichier;
    
    procedure creation_arbre_Huff(Tab_Occurrences : in Tab_Char ; Nb_Prio : in Integer ) is
    File_P : File_Prio (1 .. Nb_Prio);
    begin
        
    end creation_arbre_Huff;

end Compression;
