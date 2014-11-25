with File_Priorite; use File_Priorite;

procedure test_file_priorite is
    F : File_Prio;
    I : Integer := 0 ;
    P : Priorite;
    D : Donnee;
begin
    F := Cree_File(16);
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
        Put("Priorité : "&)
end test_file_priorite;
