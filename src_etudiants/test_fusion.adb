with Ada.Text_Io; use Ada.Text_Io;
with Huffman; use huffman;
with Compression; use Compression; use Huffman.FP;


procedure test_fusion is

    F : File_Prio;
    I : Integer := 1 ;
    P : Integer;
    A : Arbre;
begin
    F := Cree_File(5);
    Insere(F, Cree_Arbre('S'), 1);
    Insere(F, Cree_Arbre('l'), 3);
    Insere(F, Cree_Arbre('a'), 2);
    Insere(F, Cree_Arbre('!'), 5);
    Insere(F, Cree_Arbre('u'), 4);
    I := 0;
    Put(Integer'Image(GetCapa(F)));
    A := Fusionne_2_Premiers(F);
    Put(Integer'Image(GetCapa(F)));
    A := Fusionne_2_Premiers(F);
    Put(Integer'Image(GetCapa(F)));
    while not Est_Vide(F) loop

        Put("Priorité : "&Integer'Image(GetPrio(F, 1))&"    Donnée : ");
        Supprime(F, A, P);
        Put(GetData(A));
        new_Line;
        I := I + 1;
    end loop;

        new_Line;
    Put("A.FilsG : ");
    Put(GetData(GetFilsG(A)));
        new_Line;
    Put("A.FilsD : ");
    Put(GetData(GetFilsD(A)));
        new_Line;
    Put("A.FilsG.FilsG : ");
    Put(GetData(GetFilsG(GetFilsG(A))));
        new_Line;
    Put("A.FilsG.FilsD : ");
    Put(GetData(GetFilsD(GetFilsG(A))));
        new_Line;
end test_fusion;
