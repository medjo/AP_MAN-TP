with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;

package body Compression is

    function Est_Prioritaire(P1, P2 : Integer) return Boolean is
    begin
        return P1 < P2;
    end;
    

    --Lis le Fichier et compte le nombre d'occurences pour chaque charactère présent
    procedure Lecture_Fichier(Nom_Fichier_In : in String ; Tab_Occurrences : in out Tab_Char ; Nb_Prio : in out Integer) is
		Fichier : Ada.Streams.Stream_IO.File_Type;
		Flux : Ada.Streams.Stream_IO.Stream_Access;
		C : Character;
    begin
        Init_Tab(Tab_Occurrences);
		Open(Fichier, In_File, Nom_Fichier_In);
		Flux := Stream(Fichier);
        while not End_Of_File(Fichier) loop
			C := Character'Input(Flux); 
            if Character'pos(C) in Tab_Occurrences'range then
                Tab_Occurrences(Character'pos(C)) := Tab_Occurrences(Character'pos(C)) + 1;
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
        Close(Fichier);
        return;
    end Lecture_Fichier;
    

    procedure Creation_Arbre_Huff(Tab_Occ : in Tab_Char ; Nb_Prio : in Integer ; Nb_Carac : out Natural ; A : in out Arbre) is

        F : File_Prio;
        I : Integer := 0;
    begin
        F := Cree_File(Nb_Prio);
        Init_File(F);
        for I in Tab_Occ'range loop
            if Tab_Occ(I) /= 0 then
                Insere(F, Cree_Arbre(Character'Val(I)), Tab_Occ(I));
            end if;
        end loop;
        while GetCapa(F) > 1 loop
            A := Fusionne_2_Premiers(F);
        end loop;
        Nb_Carac := GetPrio(F, 1);
        I := GetFirst(F) + 1;
            
        Libere_File(F);
    end Creation_Arbre_Huff;


    function Fusionne_2_Premiers(F : File_Prio) return Arbre is
        A : Arbre;
        Fils : Arbre;
        Prio1 : Integer;
        Prio2 : Integer;
    begin
        Cree_Arbre(A);
        

        Supprime(F, Fils, Prio1);

        SetFilsG(A, Fils);
        Supprime(F, Fils, Prio2);
        SetFilsD(A, Fils);
        Insere(F, A, Prio1 + Prio2);
        return A;
    end Fusionne_2_Premiers;

    procedure Init_File(F : in out File_Prio) is
        I : Natural := GetFirst(F);
    begin
        while I <= GetLast(F) loop
            SetData(F, Cree_Arbre, I);
            I := I + 1;
        end loop;
    end Init_File;

    procedure Init_Tab(T : in out Tab_Char) is
    begin
        for I in T'range loop
            T(I) := 0;
        end loop;
    end Init_Tab;

end Compression;
