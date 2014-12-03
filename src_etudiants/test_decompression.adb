with decompression; use decompression;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Float_Text_Io; use Ada.Float_Text_Io;

procedure test_decompression is

	Nom_In : String := "VVV.txt";
	Nom_Out : String := "DecompVVV.txt";
	
	In_Fichier : Ada.Streams.Stream_IO.File_Type;
	Flux : Ada.Streams.Stream_IO.Stream_Access;
	
	I : Integer;
	
begin
	
	Open(In_Fichier, In_File, Nom_In);
	Flux := Stream(In_Fichier);

	I := Integer'Input(Flux);
	Put("Lecture Nb de caractères: ");
	Put(I);
	New_Line;
	
	While I > 0 loop
		Put(Character'Input(Flux));
		Put(Integer'Input(Flux));
		New_Line;
		I := I - 1;
	end loop;
--	Decompresse (Nom_In, Nom_Out);

end test_decompression;	
	
