with Ada.Text_Io; use Ada.Text_Io;
with Huffman; use huffman;
with Compression; use Compression; use Huffman.FP;


procedure test_fusion is

    F : File_Prio;
    I : Integer := 1 ;
    P : Integer;
    A : P_Arbre;
begin
	Cree_P_Arbre(A);
    F := Cree_File(5);
    Insere(F, Cree_P_Arbre('S'), 1);
    Insere(F, Cree_P_Arbre('l'), 3);
    Insere(F, Cree_P_Arbre('a'), 2);
    Insere(F, Cree_P_Arbre('!'), 5);
    Insere(F, Cree_P_Arbre('u'), 4);
    I := 0;
    Put(Integer'Image(GetCapa(F)));
    A.all := Fusionne_2_Premiers(F);
    Put(Integer'Image(GetCapa(F)));
    A.all := Fusionne_2_Premiers(F);
    Put(Integer'Image(GetCapa(F)));
    while not Est_Vide(F) loop

        Put("Priorité : "&Integer'Image(GetPrio(F, 1))&"    Donnée : ");
        Supprime(F, A, P);
        Put(GetData(A.all));
        new_Line;
        I := I + 1;
    end loop;

        new_Line;
    Put("A.FilsG : ");
    Put(GetData(GetFilsG(A.all)));
        new_Line;
    Put("A.FilsD : ");
    Put(GetData(GetFilsD(A.all)));
        new_Line;
    Put("A.FilsG.FilsG : ");
    Put(GetData(GetFilsG(GetFilsG(A.all))));
        new_Line;
    Put("A.FilsG.FilsD : ");
    Put(GetData(GetFilsD(GetFilsG(A.all))));
        new_Line;
end test_fusion;
