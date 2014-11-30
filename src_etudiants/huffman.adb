with huffman; use huffman;
with Compression; use Compression;

package body Huffman is

     type Noeud is
		record
			Data : Character;
            FilsG : Arbre ; 
            FilsD : Arbre ;
		end record;
   
    procedure Cree_Arbre( A : in out Arbre ) is
    begin
        A := new Noeud'(Data => Character'Val (0), others => null);
    end Cree_Arbre;

    function Cree_Arbre(Char : Character) return Arbre is
        A : Arbre;
    begin
        A := new Noeud'(Data => Char, others => null);
        return A;
    end Cree_Arbre;

    function GetData(A : Arbre) return Character is
    begin
        return A.Data;
    end GetData;

    function GetFilsG(A : Arbre) return Arbre is
    begin
        return A.FilsG;
    end GetFilsG;
    function GetFilsD(A : Arbre) return Arbre is
    begin
        return A.FilsD;
    end GetFilsD;


    procedure SetFilsG(A : in out Arbre ; Fils : in Arbre ) is
    begin
        A.FilsG := Fils;
    end SetFilsG;

    procedure SetFilsD(A : in out Arbre ; Fils : in Arbre ) is
    begin
        A.FilsD := Fils;
    end SetFilsD;
	-- Cree un arbre de Huffman a partir d'un fichier texte
	-- Cette function lit le fichier et compte le nb d'occurences des
	-- differents caracteres presents, puis genere l'arbre correspondant
	-- et le retourne.
    function Cree_Huffman(Nom_Fichier : in String) return Arbre_Huffman is

        Tab_Occ : Tab_Char;
        Nb_Prio : Integer := 0;
        A : Arbre;
        AH : Arbre_Huffman;
        Nb_Total_Caracteres : Natural;
    begin 
            Lecture_Fichier(Nom_Fichier, Tab_Occ, Nb_Prio);
            Creation_Arbre_Huff(Tab_Occ , Nb_Prio, Nb_Total_Caracteres, A);
            AH.A := A;
            AH.Nb_Total_Caracteres := Nb_Total_Caracteres;
            return AH;
    end Cree_Huffman;
    
    function Est_Vide (A : in Arbre) return Boolean is
    begin
    	if (A = NULL) then
    		return true;
    	end if;
    	return false;
    end Est_Vide;

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

    function Fusionne_2_Premiers(F : File_Prio) return Arbre is
        A : Arbre;
        Fils : Arbre;
        Prio1 : Integer;
        Prio2 : Integer;
    begin
        Cree_Arbre(A);
        Cree_Arbre(Fils);
        Supprime(F, Fils, Prio1);
        SetFilsG(A, Fils);
        Cree_Arbre(Fils);
        Supprime(F, Fils, Prio2);
        SetFilsD(A, Fils);
        Insere(F, A, Prio1 + Prio2);
        return A;
    end Fusionne_2_Premiers;
    
    
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
