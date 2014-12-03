with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Text_Io; use Ada.Text_Io;

package body decompression is
	
	-- Lit un arbre stocke dans un flux ouvert en lecture
	-- Le format de stockage est celui decrit dans le sujet
	function Lit_Huffman(Flux : Ada.Streams.Stream_IO.Stream_Access)
			return Arbre_Huffman is
		Prio : Integer := 0;
		D : Arbre;	
		H : Arbre_Huffman;
		F : Compression.FP.File_Prio;
		C : Integer := 0;
		Fin_Lecture_Huffman : Boolean := false;
		
		procedure Lire_Donnee (D : in out Arbre) is
			L : Character;
		begin
			L := Character'Input(Flux);
			D := Cree_Arbre(L) ;
		end Lire_Donnee;
		
		procedure Lire_Priorite (P: in out Integer) is
		begin
			P := Integer'Input(Flux);
		end Lire_Priorite;
		
		procedure Lire_Capacite (C : in out Integer) is
		begin
			C := Integer'Input(Flux);
		end Lire_Capacite;
		
	begin
		Lire_Capacite(C);
		F := Compression.FP.Cree_File(C);
		while (NOT(Fin_Lecture_Huffman)) loop
			Lire_Donnee(D);
			Lire_Priorite(Prio);
			Compression.FP.Insere(F, D, Prio); 
		end loop;
		
		while (Compression.FP.GetCapa(F) > 1) loop
			D := Compression.Fusionne_2_Premiers(F);
		end loop;
		H.A := D;
		H.Nb_Total_Caracteres := Compression.FP.GetPrio(F, 1);
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
	procedure Get_Caractere(B : in Integer; A : in out Arbre;
				Caractere_Trouve : out Boolean;
				Caractere : out Character) is		
	begin
		if (Est_Vide(A)) then
			Caractere := '*';
			Caractere_Trouve := true;
		elsif (Est_Vide(GetFilsG(A)) AND Est_Vide(GetFilsD(A))) then
			Caractere := Get_Data(A);
			Caractere_Trouve := true;
		elsif (B = 0) then
			A := GetFilsG(A);
			Caractere_Trouve := false;
		elsif (B = 1) then
			A := GetFilsD(A);
			Caractere_Trouve := false;
		end if;
	end Get_Caractere;
	
	procedure Decompresse (Nom_Fichier_In : in String; Nom_Fichier_Out : in String) is
		In_Fichier : Ada.Streams.Stream_IO.File_Type;
		Out_Fichier : Ada.Streams.Stream_IO.File_Type;
		In_Flux : Ada.Streams.Stream_IO.Stream_Access;
		Out_Flux : Ada.Streams.Stream_IO.Stream_Access;
		H : Arbre_Huffman;
		Tmp : Arbre;
		B : Integer;
		Caractere_Trouve : Boolean;
		C : Character;
	begin
		Open(In_Fichier, In_File, Nom_Fichier_In);
		In_Flux := Stream(In_Fichier);
		
		H := Lit_Huffman(In_Flux);
		Tmp := H.A;
		
		Create(Out_Fichier, Out_File, Nom_Fichier_Out);
		Out_Flux := Stream (Out_Fichier);
		
		while NOT(End_Of_File(In_Fichier)) loop
			B := Integer'Input(In_Flux);
			Get_Caractere(B, Tmp, Caractere_Trouve, C);
			if Caractere_Trouve then
				Tmp := H.A;
				Character'Output(Out_Flux, C);
			end if;
		end loop;
		
		Close(Out_Fichier);
		Close(In_Fichier);
	end Decompresse;
end decompression;
