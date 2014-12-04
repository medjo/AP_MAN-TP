with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
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
		C : Octet := 0;
		Fin_Lecture_Huffman : Boolean := false;
		
		--Calcule le nombre d'occurences d'une lettre d'après l'encodage de l'arbre de huffman
		--convenu
		--Val = Oct3 * 2¹⁶ + Oct2 * 2⁸ + Oct1
		--OctI entre 0 et 255
		--les valeurs de type integer sont typiquement codées sur 32 bits -> no pb
		procedure Calcul_Nb_Occurence (Oct3 : in Octet; Oct2 : in Octet;
				Oct1 : in Octet; Val : out Integer) is			
		begin
			Val := Integer(Oct3) * 2**16 + Integer(Oct2) * 2**8 + Integer(Oct1);
		end Calcul_Nb_Occurence;
		
		procedure Lire_Donnee (D : in out Arbre) is
			L : Character;
		begin
			L := Character'Input(Flux);
			Put(L);
			D := Cree_Arbre(L) ;
		end Lire_Donnee;
		
		--Traduit les 3 octets de la priorité en une valeur numérique.
		procedure Lire_Priorite (P: in out Integer) is
			Oct3, Oct2, Oct1 : Octet;
		begin
			Oct3 := Octet'Input(Flux);
			Oct2 := Octet'Input(Flux);
			Oct1 := Octet'Input(Flux);
			Calcul_Nb_Occurence (Oct3, Oct2, Oct1, P);
		end Lire_Priorite;
		
		procedure Lire_Capacite (C : in out Octet) is
		begin
			C := Octet'Input(Flux);
		end Lire_Capacite;
		

	begin
		Lire_Capacite(C);
		F := Compression.FP.Cree_File(Integer(C));
		while (C > 0) loop
			Lire_Donnee(D);
			Lire_Priorite(Prio);
			Put(Prio);
			New_Line;
			Compression.FP.Insere(F, D, Prio);
			C := C - 1; 
		end loop;
		
		while (Compression.FP.GetCapa(F) > 1) loop
			D := Compression.Fusionne_2_Premiers(F);
		end loop;
		H.A := D;
		H.Nb_Total_Caracteres := Compression.FP.GetPrio(F, 1);
		return (H);
	--Liberer des choses ?
	end Lit_Huffman;
	

------ Parcours de l'arbre (decodage)


--  * Si un caractere a ete trouve il est retourne dans Caractere et
--    Caractere_Trouve vaut True. Le code n'a eventuellement pas ete
--    totalement parcouru. A est une feuille.
	procedure Get_Caractere(B : in Integer; A : in out Arbre;
				Caractere_Trouve : out Boolean;
				Caractere : out Character) is		
	begin
		if (Est_Vide(A)) then
			Caractere := '*';
			Caractere_Trouve := true;
		elsif (B = 0) then
			A := GetFilsG(A);
		elsif (B = 1) then
			A := GetFilsD(A);
		end if;
		if (NOT Est_Vide(A) AND Est_Vide(GetFilsG(A)) AND Est_Vide(GetFilsD(A))) then
			Caractere := Get_Data(A);
			Caractere_Trouve := true;
		else	
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
		Val_Oct : Octet;
		Caractere_Trouve : Boolean;
		Car : Character;
		C : Code_Binaire := Cree_Code;
		B : Bit := 0;	
		Compteur_Car : Integer := 0;
		--Convertit une valeur decimale sur un octet en binaire et l'enfile dans C 
		procedure Conversion_Dec_Bin (Dec : in Octet; C : in out Code_Binaire) is
			Tmp : Octet := Dec;
			I : Integer := 7;
		begin
			while I >= 0 loop
				if Tmp/(2**I) = 1 then
					Enfiler(1, C);
					Tmp := Tmp - 2**I;
--					Put(1);
				else
					Enfiler(0, C);
--					Put(0);
				end if;
				I := I - 1;
			end loop;
		end Conversion_Dec_Bin;
		
	begin
		New_Line;
		Put_Line("Ouverture du fichier à décompresser...");
		Open(In_Fichier, In_File, Nom_Fichier_In);
		In_Flux := Stream(In_Fichier);
		
		Put_Line("Lecture de l'arbre...");
		H := Lit_Huffman(In_Flux);
--		Affiche_Arbre(H.A);
		Tmp := H.A;

		Put_Line("Creation du fichier décompressé...");		
		Create(Out_Fichier, Out_File, Nom_Fichier_Out);
		Out_Flux := Stream (Out_Fichier);
		
		Put_Line("Décompression...");				
		while (Compteur_Car < H.Nb_Total_Caracteres) loop
			if (Est_Null(C) or Est_Vide_Code(C)) then
				Val_Oct := Octet'Input(In_Flux);
--				Put(Integer(Val_Oct));New_Line;
				Conversion_Dec_Bin (Val_Oct, C);
--				New_Line;
--				Put("Affichage C :");
--				Affiche_Code(C);
--				New_Line;
			end if;
			Supprime_Tete_Code(C, B);
--				New_Line;
--				Put("Affichage C :");
--				Affiche_Code(C);
--				New_Line;
			Get_Caractere(B, Tmp, Caractere_Trouve, Car);
			if Caractere_Trouve then
				Tmp := H.A;
				Character'Output(Out_Flux, Car);
				Compteur_Car := Compteur_Car + 1;
				Put(Car);
			end if;
		end loop;
		
		Close(Out_Fichier);
		Close(In_Fichier);
		New_Line;
		Put_Line("Fini");		
	end Decompresse;
	
end decompression;
