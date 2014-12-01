with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;


package body Listes.File is

   	-- Procedure de liberation d'une Cellule (accedee par Liste)
	procedure Liberer is new Ada.Unchecked_Deallocation (Cellule, Liste);

	function Cree_File return File is
	begin
		return Cree_liste;
	end Cree_File;

	-- liberation: vider et c'est tout...
	procedure Libere_File (L : in out File) is
	begin
		Libere_Liste(L);
		--Vide(L);
	end Libere_File;


------------------------------------------------------------------------------
-- BLOC 1:

	-- true si liste vide, false sinon
	function Est_Vide (L: in File) return Boolean is
	begin
        return L = NULL;
	end Est_Vide;

	-- insertion d'un element V en tete de liste
	procedure Enfiler(V: Element; L: in out File) is
	begin
        L := new Cellule'(Val => V, Suiv => L);
	end Enfiler;

	procedure Defiler (L: in out File; V: out Element) is
        Browse : Liste := L;
        Browse2 : Liste := L;
	begin
        if Est_Vide(L) then
            raise Erreur_Liste_Vide;
        else
            while not Est_Vide(Browse.all.Suiv)loop
                Browse2 := Browse;
                Browse := Browse.all.Suiv;
            end loop;
            V := Browse.all.Val;
            if not (Browse2.all.Suiv = null) then
                Browse2.all.Suiv := null;
            end if;
            Liberer(Browse);
        end if;
	end Defiler;
	

	procedure Insere_Queue (V: Element; L: in out File) is
    begin
        Listes.Insere_Queue(V, L);
    end Insere_Queue;
end Listes.File;
