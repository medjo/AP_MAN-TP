with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_Io; use Ada.Text_Io;

package body Compression is

    function Est_Prioritaire(P1, P2 : Integer) return Boolean is
    begin
        return P1 <= P2;
    end;
    
	type Octet is new Integer range 0 .. 255;
	for Octet'Size use 8; -- permet d'utiliser Octet'Input et Octet'Output,

    --Lis le Fichier et compte le nombre d'occurences pour chaque charactère présent
    procedure Lecture_Fichier(Nom_Fichier_In : in String ; Tab_Occurrences : in out Tab_Char ; Nb_Prio : in out Integer) is
		Fichier : Ada.Streams.Stream_IO.File_Type;
		Flux : Ada.Streams.Stream_IO.Stream_Access;
		C : Character;
    begin
		Open(Fichier, In_File, Nom_Fichier_In);
		Flux := Stream(Fichier);
        while not End_Of_File(Fichier) loop
			C := Character'Input(Flux); 
            --Put(C);
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
        end loop;
        return;
    end Lecture_Fichier;
    

    procedure Creation_Arbre_Huff(Tab_Occ : in Tab_Char ; Nb_Prio : in Integer ; Nb_Carac : out Natural ; A : in out Arbre) is

        F : File_Prio;
        I : Integer := 0;
        A1 : Arbre;
        A2 : Arbre;
    begin
        F := Cree_File(Nb_Prio);
        for I in Tab_Occ'range loop
            if Tab_Occ(I) /= 0 then
                Insere(F, Cree_Arbre(Character'Val(I)), Tab_Occ(I));
            end if;
        end loop;
        while GetCapa(F) > 1 loop
            A1 := Fusionne_2_Premiers(F);
        end loop;
        Nb_Carac := GetPrio(F, 1);
    end Creation_Arbre_Huff;


end Compression;
