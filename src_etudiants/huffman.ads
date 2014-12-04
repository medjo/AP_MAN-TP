with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Dico; use Dico;
with Code; use Code;

-- paquetage representant un arbre de Huffman de caracteres

package Huffman is

    
    type Tab_Char is array (Integer range 0..255) of Integer;

    type Arbre is private;
	type Arbre_Huffman is record
		-- l'arbre de Huffman proprement dit
		A : Arbre;           
		-- autres infos utiles: nb total de caracteres lus, ...
		Nb_Total_Caracteres : Natural;
        Tab_Occ : Tab_Char;
        Nb_Prio : Integer;
        D : Dico_Caracteres;
		-- A completer selon vos besoins!
	end record;

    type Tab8Char is array (Integer range 0 .. 7) of Character;
    type Tab8Bit is array (Integer range 0 .. 7) of Bit;
	-- Libere l'arbre de racine A.
	-- garantit: en sortie toute la memoire a ete libere, et A = null.
--	procedure Libere(H : in out Arbre_Huffman);

--	procedure Affiche(H : in Arbre_Huffman);
	

	-- Cree un arbre de Huffman a partir d'un fichier texte
	-- Cette function lit le fichier et compte le nb d'occurences des
	-- differents caracteres presents, puis genere l'arbre correspondant
	-- et le retourne.

	-- Stocke un arbre dans un flux ouvert en ecriture
	-- Le format de stockage est celui decrit dans le sujet
	-- Retourne le nb d'octets ecrits dans le flux (pour les stats)
    function Ecrit_Huffman(H : in Arbre_Huffman;
        Flux_Out : Ada.Streams.Stream_IO.Stream_Access ; Nom_Fichier_In : String)
        return Natural;

	-- Lit un arbre stocke dans un flux ouvert en lecture
	-- Le format de stockage est celui decrit dans le sujet
--	function Lit_Huffman(Flux : Ada.Streams.Stream_IO.Stream_Access)
--		return Arbre_Huffman;


	-- Retourne un dictionnaire contenant les caracteres presents
	-- dans l'arbre et leur code binaire (evite les parcours multiples)
	-- de l'arbre
	function Genere_Dictionnaire(H : in Arbre_Huffman) return Dico_Caracteres;


    procedure Genere_Codes(A : Arbre ; C : in out Code_Binaire ; D : in out Dico_Caracteres);

    function ConvertBin2Dec(SeqBits : Tab8Bit) return Integer;
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
--				Caractere : out Character);
--

-- #########################################################
     -- FONCTIONS LIEES A LA COMPRESSION
    

	function Cree_Huffman(Nom_Fichier : in String)
		return Arbre_Huffman;

    function GetFilsG(A : Arbre) return Arbre;

    procedure SetFilsG(A : in out Arbre ; Fils : in Arbre );

    function GetFilsD(A : Arbre) return Arbre;

    procedure SetFilsD(A : in out Arbre ; Fils : in Arbre );

    function Cree_Arbre(Char : Character) return Arbre;

    procedure Cree_Arbre(A : in out Arbre);

    function Cree_Arbre return Arbre;

    function GetData_Arbre(A : Arbre) return Character;
    procedure SetData_Arbre(A : in out Arbre ; D : Character );

    procedure Affiche_Arbre(A : Arbre);
-- #########################################################
	function Est_Vide (A : Arbre) return Boolean;
	
	function Get_Data (A : Arbre) return Character;

-- #########################################################
     -- FONCTIONS LIEES A LA DECOMPRESSION





private

    type Noeud;
    type Arbre is access Noeud;
end Huffman;

