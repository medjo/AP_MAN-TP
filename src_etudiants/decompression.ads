with Huffman; use Huffman;
with Compression; use Compression;
use Compression.FP;
with File_Priorite;
with Code; use Code;
with Ada.Streams.Stream_IO;
with Listes;
with Ada.Sequential_IO;

package decompression is

	
	type Octet is new Integer range 0 .. 255;
	for Octet'Size use 8;
	
	--Lit l'arbre de huffman codé dans le fichier compressé et le renvoie
	--L'arbre doit être codé ainsi :
	--	1er Octet : Nb_de_caracteres
	--	Ensuite, on lit Nb_de_caracteres groupes de 4 octets :
	--		1er contenant le caractere
	--		3 suivants contenant sa frequence
	--On reconstruit ainsi l'arbre ayant servi à coder le fichier
	function Lit_Huffman(Flux : Ada.Streams.Stream_IO.Stream_Access)
			return Arbre_Huffman;
	
	--Parcours un arbre en fonction du bit lu dans le fichier :
	-- Si bit 0 on continue dans l'arbre gauche
	-- Si bit 1 on continue dans l'arbre droit
	--Quand on tombe sur une feuille, Caractere_Trouve est mis à vrai
	--et on renvoie le caractere
	procedure Get_Caractere(B : in Integer; A : in out Arbre;
				Caractere_Trouve : out Boolean;
				Caractere : out Character);
	
	--Lit un fichier en entrée et le décompresse
	--Donne en sortie un fichier dont on a spécifié le nom
	procedure Decompresse (Nom_Fichier_In : in String; Nom_Fichier_Out : in String);
			
end decompression; 
