with Ada.Text_Io; use Ada.Text_Io;
with File_Priorite;
--with Huffman; use Huffman;


procedure test_file_priorite is

    function Est_Prioritaire(P1, P2 : Integer) return Boolean is
    begin
        return P1 <= P2;
    end;
    package FP is new File_Priorite(Character, Integer, Est_Prioritaire);
    use FP;
    F : File_Prio;
    I : Integer := 1 ;
    P : Integer;
    D : Character;
begin
    F := Cree_File(5);
    Insere(F, 'S', I);
    I := I + 1;
    Insere(F, 'a', I);
    I := I + 1;
    Insere(F, 'l', I);
    I := I + 1;
    Insere(F, 'u', I);
    I := I + 1;
    Insere(F, 't', I);

    while not Est_Vide(F) loop

        Supprime(F, D, P);
        Put("Priorité : "&Integer'Image(P)&"    Donnée : ");
        Put(D);
        new_Line;
    end loop;
end test_file_priorite;
