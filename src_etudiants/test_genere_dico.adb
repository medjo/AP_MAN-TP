with Ada.Text_Io; use Ada.Text_Io;
with Ada.Command_Line; use Ada.Command_Line;
with Huffman; use Huffman;
with Dico; use Dico;


procedure test_genere_dico is
    Fichier : String (1 .. Argument(1)'Length);
    Huff : Arbre_Huffman;
    D : Dico_Caracteres;
begin

    Fichier := Argument(1);
    Huff := Cree_Huffman(Fichier);
    Affiche_Arbre(Huff.A);
    D := Genere_Dictionnaire(Huff);
    Affiche_Dico(D); 

end test_genere_dico;
