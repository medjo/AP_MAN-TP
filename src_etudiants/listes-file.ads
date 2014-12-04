with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;
with Listes;

generic
    
	--type Element is private;

package Listes.File is

    

	subtype File is Liste;
	
	function Cree_File return File;


	-- liberation: vider et c'est tout...
	procedure Libere_File (L : in out File);



------------------------------------------------------------------------------
-- BLOC 1:

	-- true si liste vide, false sinon
	function Est_Vide(L: in File) return Boolean;


	-- insertion d'un element V en tete de liste
	procedure Enfiler(V: Element; L: in out File);


	-- suppression l'element en queue de listes 
	procedure Defiler (L: in out File; V: out Element);
       
	
	-- insertion d'un element V en queue de liste
	procedure Insere_Queue (V: Element; L: in out File);


	procedure Supprime_Tete (L: in out File; V : out Element);

end Listes.File;
