with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Command_Line; use  Ada.Command_Line;
with Compression; use Compression;

-- MEMO :   Character'Pos('a') = 97
--          Character'Val(97) = a

procedure test_lecture_fichier is
    Fichier : String (1 .. Argument(1)'Length);
    Tab_Occ : Tab_Char;
    Sum : Integer := 0;
    Nb_Prio : Integer := 0;
    --a, b : Character;
begin
    if Argument_Count /= 1 then
        Put_Line("Veuillez lancer le programme de la manière suivante :");
        new_Line;
        Put_Line("./test_lecture_fichier NOM_DU_FICHIER_TEXTE.txt");
    else
        Fichier := Argument(1);
        new_Line;
        Put("Nom du fichier : ");
        Put_Line(Fichier);
        new_Line;
        for I in Tab_Occ'range loop
            Tab_Occ(I) := 0;
        end loop;
        Lecture_Fichier(Fichier, Tab_Occ, Nb_Prio);
        for I in Tab_Occ'range loop
            if Tab_Occ(I) /= 0 then
                Put("Case n°");
                Put(I);
                Put("("&Character'Val(I)&")" & "     Occurrences : "&Integer'Image(Tab_Occ(I)));
                new_Line;
                Sum := Sum + Tab_Occ(I);
            end if;
        end loop;
        Put("Somme = " & Integer'Image(Sum));
        new_Line;
        Put("Nombre de priorités = " & Integer'Image(Nb_Prio));
    end if;

end test_lecture_fichier;
