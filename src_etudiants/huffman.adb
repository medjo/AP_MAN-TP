with huffman.ads; use huffman.ads;

	-- Cree un arbre de Huffman a partir d'un fichier texte
	-- Cette function lit le fichier et compte le nb d'occurences des
	-- differents caracteres presents, puis genere l'arbre correspondant
	-- et le retourne.
function Cree_Huffman(Nom_Fichier : in String)
    Tab_Occ : Tab_Char;
    Nb_Prio : Integer := 0;
begin 
        Lecture_Fichier(Nom_Fichier, Tab_Occ, Nb_Prio);
        return ;
end Cree_Huffman;
