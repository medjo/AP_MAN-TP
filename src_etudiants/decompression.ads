with huffman; use huffman;
use Huffman.FP;
with File_Priorite;
with Code; use Code;
with Ada.Streams.Stream_IO;

package decompression is


	function Lit_Huffman(Flux : Ada.Streams.Stream_IO.Stream_Access)
			return Arbre_Huffman;
			
--	function Genere_Dictionnaire(H : in Arbre_Huffman) return Dico_Caracteres;
	
	procedure Get_Caractere(It_Code : in Iterateur_Code; A : in out Arbre;
				Caractere_Trouve : out Boolean;
				Caractere : out Character);
				
end decompression; 
