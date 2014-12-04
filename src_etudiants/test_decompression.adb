with decompression; use decompression;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Float_Text_Io; use Ada.Float_Text_Io;
with Huffman; use Huffman;

procedure test_decompression is

	Nom_In : String := "VVV.txt";
	Nom_Out : String := "DecompVVV.txt";
	
	In_Fichier : Ada.Streams.Stream_IO.File_Type;
	Flux : Ada.Streams.Stream_IO.Stream_Access;
	
	O : Octet := 7;
	Nb_Caracteres : Octet := 7;
--	I : Integer;
--	H : Arbre_Huffman;	
begin
	
	Open(In_Fichier, Out_File, Nom_In);
	Flux := Stream(In_Fichier);
	
	Octet'Output(Flux, Nb_Caracteres); 	--Convention : 1er octet lu correspond au
										--nombre de caractères dans le texte
										 
	Character'Output(Flux, ' ');		--Un caractere est ecrit sur 1 octet
	Octet'Output(Flux, 0);				--Les 3 octets suivants indiquent sa fréquence
	Octet'Output(Flux, 0);				
	Octet'Output(Flux, 2);
	Character'Output(Flux, 'c');
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 1);
	Character'Output(Flux, 'd');
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 1);
	Character'Output(Flux, 'e');
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 1);
	Character'Output(Flux, 'i');
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 5);
	Character'Output(Flux, 'n');
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 1);
	Character'Output(Flux, 'v');
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 0);
	Octet'Output(Flux, 3);
	
--veni vidi vici en binaire avec arbre ci_dessus:
-- i : 0; v : 111; c : 1000; e : 1011; n : 1010; d : 1001; 'espace' : 110;	
	Octet'Output(Flux, 247);	--on peut lire "ve"
	Octet'Output(Flux, 77);		--on peut completer : "veni "	
	Octet'Output(Flux, 210);	--"veni vidi"
	Octet'Output(Flux, 221);	--"veni vidi vi"
	Octet'Output(Flux, 13); 	--"veni vidi vici " Completion du dernier octet par un espace
	Octet'Output(Flux, 182);	-- Ajout de code d'esapce jusqu'a terminer sur un octet rempli d'espaces
								-- Le dernier octet du texte n'est pas traduit
	close(In_Fichier);
	
--	H := Lit_Huffman(Flux);
--	Affiche_Arbre(H.A);
	Put_Line("On veut décoder :");
	Put_Line("veni vidi vici");
	Decompresse (Nom_In, Nom_Out);


end test_decompression;	
	
