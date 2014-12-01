with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;


package body Listes is


	-- Procedure de liberation d'une Cellule (accedee par Liste)
	procedure Liberer is new Ada.Unchecked_Deallocation (Cellule, Liste);


	-- creation: init a null
	function Cree_Liste return Liste is
	begin
		return null;
	end Cree_Liste;

	-- liberation: vider et c'est tout...
	procedure Libere_Liste (L : in out Liste) is
	begin
		Vide(L);
	end Libere_Liste;


------------------------------------------------------------------------------
-- BLOC 1:

	-- true si liste vide, false sinon
	function Est_Vide (L: in Liste) return Boolean is
	begin
        return L = NULL;
	end Est_Vide;

	-- insertion d'un element V en tete de liste
	procedure Insere_Tete (V: Element; L: in out Liste) is
	begin
        L := new Cellule'(Val => V, Suiv => L);
	end Insere_Tete;


	-- affichage de la liste, dans l'ordre de parcours
--	procedure Affiche (L: in Liste) is 
 --       Browse : Liste := L;
--	begin
--        New_Line;
--        New_Line;
--        Put("La liste vaut :");
--        New_Line;
--        while not Est_Vide(Browse)loop
--            Affiche_Element(Browse.all.Val);
--            New_Line;
--            Browse := Browse.all.Suiv;
--        end loop;
            --Put(Integer'Image(Browse.all.Val));
--            New_Line;
	--end Affiche;


	-- recherche sequentielle d'un element dans la liste
	function Est_Present (V: Element; L: Liste) return Boolean is
        Browse : Liste := L;
	begin
        while not Est_Vide(Browse)loop
            if Browse.all.Val = V then
                return True;
            end if;
            Browse := Browse.all.Suiv;
        end loop;
		return false;
	end Est_Present;


------------------------------------------------------------------------------
-- BLOC 2:

	-- Vide la liste
	procedure Vide (L: in out Liste) is
        Temp : Liste;
	begin
        while not Est_Vide(L)loop
            Temp := L;
            L := L.all.Suiv;
            Liberer(Temp);
        end loop;
	end Vide;


	-- insertion d'un element V en queue de liste
	procedure Insere_Queue (V: Element; L: in out Liste) is
        Browse : Liste := L;
	begin
        if Est_Vide(L) then
            L := new Cellule'(Val => V, Suiv => L);
        else
            while not Est_Vide(Browse.all.Suiv)loop
             Browse := Browse.all.Suiv;
            end loop;
            Browse.all.Suiv := new Cellule'(Val => V, Suiv => null);
        end if;
	end Insere_Queue;
	
------------------------------------------------------------------------------
-- BLOC 3:

	-- suppression de l'element en tete de liste
	procedure Supprime_Tete (L: in out Liste; V : out Element) is
        Temp : Liste;
	begin
        if Est_Vide(L) then
            raise Erreur_Liste_Vide;
        else
            Temp := L.all.Suiv;
            V := L.all.Val;
            Liberer(L);
            L := Temp;
        end if;
	end Supprime_Tete;
	
	-- suppression l'element en queue de listes 
	procedure Supprime_Queue (L: in out Liste; V: out Element) is
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
	end Supprime_Queue;
	
	
	-- suppression de la premiere occurence de V dans la liste
	procedure Supprime_Premiere_Occurence (V: Element; L: in out Liste) is
	begin
-- STUB, A REMPLACER PAR VOTRE CODE!		
		null;
	end Supprime_Premiere_Occurence;

	-- suppression de toutes les occurences de V de la liste
	procedure Supprime (V: Element; L: in out Liste) is
        Fict : Liste := new Cellule'( Val => V , Suiv => null);
        Browse : Liste;
        Temp : Liste;
	begin
        Fict.Suiv := L;
        Browse := Fict;
        Temp := Browse;
        while not Est_Vide(Browse.Suiv) loop
            if Browse.Suiv.Val = V then
                --Supprime_Tete(Browse, Browse.Val);
                Temp.Suiv := Browse.Suiv; 
                Liberer(Browse);
            else
                Temp := Browse;
                Browse := Browse.Suiv;
            end if;
        end loop;
        L := Fict.Suiv;
-- STUB, A REMPLACER PAR VOTRE CODE!		
	end Supprime;

------------------------------------------------------------------------------
-- BLOC 4:

    -- inversion l'ordre des elements dans une liste
    -- (sans allocation et en temps lineaire)
    procedure Inverse (L: in out Liste) is
    begin
        -- STUB, A REMPLACER PAR VOTRE CODE!		
        null;
    end Inverse;


------------------------------------------------------------------------------
end Listes;
