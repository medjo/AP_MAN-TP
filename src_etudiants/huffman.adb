with Compression; use Compression;
package body Huffman is

     type Noeud is
		record
			Data : Character;
            FilsG : Arbre ; 
            FilsD : Arbre ;
		end record;
   
    function Cree_Arbre return Arbre is
        A : Arbre;
    begin
        A := new Noeud'(Data => Character'Val(0), others => null);
        return A;
    end Cree_Arbre;

    procedure Cree_Arbre( A : in out Arbre ) is
    begin
        A := new Noeud'(Data => Character'Val(0), others => null);
    end Cree_Arbre;

    function Cree_Arbre(Char : Character) return Arbre is
        A : Arbre;
    begin
        A := new Noeud'(Data => Char, others => null);
        return A;
    end Cree_Arbre;

    function GetData_Arbre(A : Arbre) return Character is
    begin
        return A.Data;
    end GetData_Arbre;

    procedure SetData_Arbre(A : in out Arbre ; D : Character ) is
    begin
        A.Data := D;
    end SetData_Arbre;

    function GetFilsG(A : Arbre) return Arbre is
    begin
        return A.FilsG;
    end GetFilsG;
    function GetFilsD(A : Arbre) return Arbre is
    begin
        return A.FilsD;
    end GetFilsD;

    --Affiche les élements d'un arbres
    procedure Affiche_Arbre(A : Arbre) is
    begin
        if A /= null then
            Put("A.Data : ");
            Put(A.Data);
            new_Line;
            Affiche_Arbre(A.FilsG);
            Affiche_Arbre(A.FilsD);
        else
            Put_Line("Vide !");
        end if;
    end Affiche_Arbre;

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

        Nb_Prio : Integer := 0;
        A : Arbre;
        AH : Arbre_Huffman;
        Nb_Total_Caracteres : Natural;
    begin 
        Lecture_Fichier(Nom_Fichier, AH.Tab_Occ, Nb_Prio);
        Creation_Arbre_Huff(AH.Tab_Occ , Nb_Prio, Nb_Total_Caracteres, A);
        AH.A := A;
        AH.Nb_Total_Caracteres := Nb_Total_Caracteres;
        AH.Nb_Prio := Nb_Prio;
        return AH;
    end Cree_Huffman;

	function Genere_Dictionnaire(H : in Arbre_Huffman) return Dico_Caracteres is
        D : Dico_Caracteres := Cree_Dico;
        C : Code_Binaire := Declare_Code;
    begin
        Genere_Codes(H.A, C, D);
        return D;
    end Genere_Dictionnaire;
    
    procedure Genere_Codes(A : Arbre; C : in out Code_Binaire ; D : in out Dico_Caracteres) is
        C2 : Code_Binaire;
    begin
        if A = null then
            new_Line;
            Put_Line("[huffman.adb] Tentative de lecture d'un Arbre Vide !");
        end if;
        if A.Data = Character'Val(0) then
            if not Est_Null(C) then
                C2 := Cree_Code(C);
            else
                C2 := Cree_Code;
                C := Cree_Code;
            end if;
            Enfiler(ZERO, C2);
            Genere_Codes(A.FilsG, C2, D);
            Enfiler(UN, C);
            Genere_Codes(A.FilsD, C, D);
        else
            Set_Code(A.Data, C, D);
        end if;
    end Genere_Codes;
    
	function Est_Vide (A : Arbre) return Boolean is
	begin
		if (A = NULL) then
			return true;
		end if;
		return false;
	end Est_Vide;
	
	function Get_Data (A: Arbre) return Character is
	begin
		return A.Data;
	end Get_Data;
	
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
    function Ecrit_Huffman(H : in Arbre_Huffman;
        Flux_Out : Ada.Streams.Stream_IO.Stream_Access ; Nom_Fichier_In : String)
        return Natural is
        Nb_Octets_Ecrits : Natural := 0;
	    Fichier : Ada.Streams.Stream_IO.File_Type;
		Flux_In : Ada.Streams.Stream_IO.Stream_Access;
		C : Character;
        O : Octet;
    begin
        Open(Fichier, In_File, Nom_Fichier_In);
        Flux_In := Stream(Fichier);

        --1er Octet du Fichier : le nombre de caractère différents présents dans le texte.
        O := Octet(H.Nb_Prio);
        Octet'Output(Flux_Out, O);
        Nb_Octets_Ecrits := Nb_Octets_Ecrits + 1;

        --On écrit le tableau d'Occurrences de la manière suivante : 
        --Suite de 4 Octets :
        --  1 Octets : Le caractère en question
        --  3 Octest : Le nombre d'occurrences du caractère.
        for I in H.Tab_Occ'range loop
            if H.Tab_Occ(I) /= 0 then
                O := Octet(I);
                Octet'Output(Flux_Out, O);
                O := Octet(H.Tab_Occ(I) / (256 * 256));
                Octet'Output(Flux_Out, O);
                O := Octet(H.Tab_Occ(I) /  256);
                Octet'Output(Flux_Out, O);
                O := Octet(H.Tab_Occ(I) );
                Octet'Output(Flux_Out, O);
                Nb_Octets_Ecrits := Nb_Octets_Ecrits + 4;
            end if;
        end loop;


        while not End_Of_File(Fichier) loop
            --Lecture d'un caractère dans le fichier en entrée
            C := Character'Input(Flux_In);
            --Écriture du Code de ce Caractère dans le Fichier de sortie

        end loop;
        Close(Fichier);
        return Nb_Octets_Ecrits;
    end Ecrit_Huffman;

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
