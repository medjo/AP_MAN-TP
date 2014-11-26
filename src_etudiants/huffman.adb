with huffman; use huffman;
with Compression; use Compression;
with File_Priorite;

package body Huffman is

    type Noeud is
		record
			Data : Character;
			Prio : Integer;
            FilsG : Arbre ; 
            FilsD : Arbre ;
		end record;
	-- Cree un arbre de Huffman a partir d'un fichier texte
	-- Cette function lit le fichier et compte le nb d'occurences des
	-- differents caracteres presents, puis genere l'arbre correspondant
	-- et le retourne.
    function Cree_Huffman(Nom_Fichier : in String) return Arbre_Huffman is

        function Est_Prioritaire(P1, P2 : Integer) return Boolean is
        begin
            return P1 <= P2;
        end;
        package FP is new File_Priorite(Character, Integer, Est_Prioritaire);
        use FP;
        F : File_Prio;
        Tab_Occ : Tab_Char;
        Nb_Prio : Integer := 0;
        A : Arbre_Huffman;
    begin 
            Lecture_Fichier(Nom_Fichier, Tab_Occ, Nb_Prio);
            F := Creation_File_Prio(Tab_Occ , Nb_Prio);
            return A;
    end Cree_Huffman;

    -- Libere l'arbre de racine A.
	-- garantit: en sortie toute la memoire a ete libere, et A = null.
--	procedure Libere(H : in out Arbre_Huffman) is
--    begin
        -- STUB, A REMPLACER PAR VOTRE CODE!VOTRE
--        null;
--    end Libere;

--	procedure Affiche(H : in Arbre_Huffman) is
--    begin
        -- STUB, A REMPLACER PAR VOTRE CODE!VOTRE
--        null;
 --   end Affiche;
	

    -- Stocke un arbre dans un flux ouvert en ecriture
	-- Le format de stockage est celui decrit dans le sujet
	-- Retourne le nb d'octets ecrits dans le flux (pour les stats)
--	function Ecrit_Huffman(H : in Arbre_Huffman;
--	                        Flux : Ada.Streams.Stream_IO.Stream_Access)
--		return Positive is
--    begin
        -- STUB, A REMPLACER PAR VOTRE CODE!VOTRE
 --       null;
--        return H;
--    end Ecrit_Huffman;

	-- Lit un arbre stocke dans un flux ouvert en lecture
	-- Le format de stockage est celui decrit dans le sujet
--	function Lit_Huffman(Flux : Ada.Streams.Stream_IO.Stream_Access)
--		return Arbre_Huffman is
 --   begin
        -- STUB, A REMPLACER PAR VOTRE CODE!VOTRE
--        null;
--    end Lit_Huffman;


	-- Retourne un dictionnaire contenant les caracteres presents
	-- dans l'arbre et leur code binaire (evite les parcours multiples)
	-- de l'arbre
--	function Genere_Dictionnaire(H : in Arbre_Huffman) return Dico_Caracteres is
  --  begin
        -- STUB, A REMPLACER PAR VOTRE CODE!VOTRE
    --    null;
   -- end Genere_Dictionnaire;



------ Parcours de l'arbre (decodage)

-- Parcours a l'aide d'un iterateur sur un code, en partant du noeud A
--  * Si un caractere a ete trouve il est retourne dans Caractere et
--    Caractere_Trouve vaut True. Le code n'a eventuellement pas ete
--    totalement parcouru. A est une feuille.
--  * Si l'iteration est terminee (plus de bits a parcourir ds le code)
--    mais que le parcours s'est arrete avant une feuille, alors
--    Caractere_Trouve vaut False, Caractere est indetermine
--    et A est le dernier noeud atteint.
--	procedure Get_Caractere(It_Code : in Iterateur_Code; A : in out Arbre;
--				Caractere_Trouve : out Boolean;
--				Caractere : out Character) is
--    begin
        -- STUB, A REMPLACER PAR VOTRE CODE!VOTRE
--        null;
--    end Get_Caractere;


end Huffman;
