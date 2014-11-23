with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Command_Line; use  Ada.Command_Line;
with Compression; use Compression;


procedure test_lecture_fichier is
    Fichier : String (1 .. Argument(1)'Length);
    Tab_Occ : Tab_Char;
    Sum : Integer := 0;
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
        Lecture_Fichier(Fichier, Tab_Occ, Tab_Occ'Length);
        for I in Tab_Occ'range loop
            Put(Integer'Image(I) & " : ");
            Put(Tab_Occ(I));
            new_Line;
            Sum := Sum + Tab_Occ(I);
        end loop;
        Put("Somme = " & Integer'Image(Sum));
            
    end if;

end test_lecture_fichier;
