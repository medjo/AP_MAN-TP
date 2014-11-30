with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_Io; use Ada.Text_Io;

package body decompression is
	
	-- Lit un arbre stocke dans un flux ouvert en lecture
	-- Le format de stockage est celui decrit dans le sujet
	function Lit_Huffman(Flux : Ada.Streams.Stream_IO.Stream_Access)
			return Arbre_Huffman is
		Prio : Integer;
		D : P_Arbre;	
		H : Arbre_Huffman;
		F : File_Prio;
		C : Integer;
		Fin_Lecture_Huffman : Boolean := false;
		
		procedure Lire_Donnee (D : in out Arbre) is
			L : Character;
		begin
			Character'Read(Flux, L);
			D := Cree_Arbre(L) ;
		end Lire_Donnee;
		
		procedure Lire_Priorite (P: in out Integer) is
		begin
			Integer'Read(Flux, P);
		end Lire_Priorite;
		
		procedure Lire_Capacite (C : in out Integer) is
		begin
			Integer'Read(Flux, C);
		end Lire_Capacite;
		
	begin
		Lire_Capacite(C);
		F := Huffman.FP.Cree_File(C);
		while (NOT(Fin_Lecture_Huffman)) loop
			Lire_Donnee(D.all);
			Lire_Priorite(Prio);
			Huffman.FP.Insere(F, D, Prio); 
		end loop;
		
		while (Huffman.FP.GetCapa(F) > 1) loop
			D.All := Fusionne_2_Premiers(F);
		end loop;
		H.A := D.all;
		H.Nb_Total_Caracteres := Huffman.FP.GetPrio(F, 1);
		return (H);
	end Lit_Huffman;
	
	-- Retourne un dictionnaire contenant les caracteres presents
	-- dans l'arbre et leur code binaire (evite les parcours multiples)
	-- de l'arbre
--	function Genere_Dictionnaire(H : in Arbre_Huffman) return Dico_Caracteres is
--		D : Dico_Caracteres := Cree_Dico;
--	begin
		
--	end Genere_Dictionnaire;
	
------ Parcours de l'arbre (decodage)

-- Parcours a l'aide d'un iterateur sur un code, en partant du noeud A
--  * Si un caractere a ete trouve il est retourne dans Caractere et
--    Caractere_Trouve vaut True. Le code n'a eventuellement pas ete
--    totalement parcouru. A est une feuille.
--  * Si l'iteration est terminee (plus de bits a parcourir ds le code)
--    mais que le parcours s'est arrete avant une feuille, alors
--    Caractere_Trouve vaut False, Caractere est indetermine
--    et A est le dernier noeud atteint.
	procedure Get_Caractere(It_Code : in Iterateur_Code; A : in out Arbre;
				Caractere_Trouve : out Boolean;
				Caractere : out Character) is		
		B : Bit := Next(It_Code);
	begin
		if (Est_Vide(A)) then
			Caractere := '*';
			Caractere_Trouve := true;
		elsif (Est_Vide(GetFilsG(A)) AND Est_Vide(GetFilsD(A))) then
			Caractere := GetData(A);
			Caractere_Trouve := true;
		elsif (B = ZERO) then
			A := GetFilsG(A);
			Caractere_Trouve := false;
		elsif (B = UN) then
			A := GetFilsD(A);
			Caractere_Trouve := false;
		end if;
	end Get_Caractere;
	
end decompression;
