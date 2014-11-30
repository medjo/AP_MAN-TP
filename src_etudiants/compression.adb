with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_Io; use Ada.Text_Io;

package body Compression is 
    
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

        F : Huffman.FP.File_Prio;
        I : Integer := 0;
        A1 : P_Arbre;
    begin
    	Cree_P_Arbre(A1);
        F := Huffman.FP.Cree_File(Nb_Prio);
        for I in Tab_Occ'range loop
            if Tab_Occ(I) /= 0 then
            	A1.all := Cree_Arbre(Character'Val(I)); 
                Huffman.FP.Insere(F, A1, Tab_Occ(I));
            end if;
        end loop;
        while Huffman.FP.GetCapa(F) > 1 loop
            A1.all := Fusionne_2_Premiers(F);
        end loop;
        Nb_Carac := Huffman.FP.GetPrio(F, 1);
    end Creation_Arbre_Huff;


end Compression;
