with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Listes.File;

procedure Test_Files is
    package PListes is new Listes(Character);
    use PListes;
    package PFile is new PListes.File;
    use PFile;

    F : File;
    Browse : File;
begin
    F := Cree_File; 
    Enfiler('B', F);
    Enfiler('o', F);
    Enfiler('n', F);
    Enfiler('j', F);
    Enfiler('o', F);
    Enfiler('u', F);
    Enfiler('r', F);

    Browse := F;

        while not PFile.Est_Vide(Browse)loop
            Put(Browse.all.Val);
            new_Line;
            Browse := Browse.all.Suiv;
        end loop;

end Test_Files;

