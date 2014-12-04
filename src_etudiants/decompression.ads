with Huffman; use Huffman;
with Compression; use Compression;
use Compression.FP;
with File_Priorite;
with Code; use Code;
with Ada.Streams.Stream_IO;
with Listes;
with Ada.Sequential_IO;

package decompression is

	package Liste_Char is new Listes(Character);
	use Liste_Char;
	
	type Octet is new Integer range 0 .. 255;
	for Octet'Size use 8;
	
	function Lit_Huffman(Flux : Ada.Streams.Stream_IO.Stream_Access)
			return Arbre_Huffman;
			
--	function Genere_Dictionnaire(H : in Arbre_Huffman) return Dico_Caracteres;
	
	procedure Get_Caractere(B : in Integer; A : in out Arbre;
				Caractere_Trouve : out Boolean;
				Caractere : out Character);
				
	procedure Decompresse (Nom_Fichier_In : in String; Nom_Fichier_Out : in String);
			
end decompression; 
