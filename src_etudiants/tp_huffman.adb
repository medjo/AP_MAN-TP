with Ada.Text_Io; use Ada.Text_Io;
with Ada.Command_Line; use Ada.Command_Line;
with Huffman; use Huffman;
with Dico; use Dico;
with Compression; use Compression;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;


procedure tp_huffman is

------------------------------------------------------------------------------
-- COMPRESSION
------------------------------------------------------------------------------

	procedure Compresse(Nom_Fichier_In, Nom_Fichier_Out : in String) is
    Huff : Arbre_Huffman;
    D : Dico_Caracteres;
    Nb_Octets_Ecrits : Natural;
    Fichier : Ada.Streams.Stream_IO.File_Type;
    Flux : Ada.Streams.Stream_IO.Stream_Access;
	begin
        Huff := Cree_Huffman(Nom_Fichier_In);
        D := Genere_Dictionnaire(Huff);

        Create(Fichier, Out_File, Nom_Fichier_Out);
        Flux := Stream(Fichier);
        Nb_Octets_Ecrits := Ecrit_Huffman(Huff, Flux, Nom_Fichier_In);
        Close(Fichier);

	end Compresse;


------------------------------------------------------------------------------
-- DECOMPRESSION
------------------------------------------------------------------------------

	procedure Decompresse(Nom_Fichier_In, Nom_Fichier_Out : in String) is
	begin
		-- A COMPLETER!
		return;
	end Decompresse;


------------------------------------------------------------------------------
-- PG PRINCIPAL
------------------------------------------------------------------------------

begin

	if (Argument_Count /= 3) then
		Put_Line("utilisation:");
		Put_Line("  compression : ./huffman -c fichier.txt fichier.comp");
		Put_Line("  decompression : ./huffman -d fichier.comp fichier.comp.txt");
		Set_Exit_Status(Failure);
		return;
	end if;

	if (Argument(1) = "-c") then
		Compresse(Argument(2), Argument(3));
	else
		Decompresse(Argument(2), Argument(3));
	end if;

	Set_Exit_Status(Success);

end tp_huffman;

