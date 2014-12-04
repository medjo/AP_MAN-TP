with Ada.Unchecked_Deallocation;

package body Dico is

    type Dico_Caracteres_Interne is array (Natural range 0 .. 255) of Code_Binaire;

	procedure Liberer is new Ada.Unchecked_Deallocation (Dico_Caracteres_Interne, Dico_Caracteres);	

    function Cree_Dico return Dico_Caracteres is
        D : Dico_Caracteres;
    begin
        D := new Dico_Caracteres_Interne'(others => Cree_Code);
        return D;
    end Cree_Dico;

    function Get_Code_From_Dico(C : Character ; D : in Dico_Caracteres) return Code_Binaire is
    begin
        return D.all(Character'Pos(C));
    end Get_Code_From_Dico;

	procedure Set_Code(C : in Character; Code : in Code_Binaire; D : in out Dico_Caracteres) is
    begin
        D.all(Character'Pos(C)) := Code; 
    end Set_Code;

	-- Affiche pour chaque caractere: son nombre d'occurences et son code
	-- (s'il a ete genere)
	procedure Affiche_Dico(D : in Dico_Caracteres) is
    begin
        for I in D.all'range loop
            if not Est_Vide_Code(D.all(I)) then
                Put("Caractère : ");
                Put(Character'Val(I));
                Put("              Code : ");
                Affiche_Code(D.all(I));
                new_Line;
            end if;
        end loop;
    end Affiche_Dico;

	procedure Libere_Dico(D : in out Dico_Caracteres) is
    begin
        for I in Dico_Caracteres_Interne'range loop
            Libere_Code(D.all(I));
        end loop;
        Liberer(D);
    end Libere_Dico;

end Dico;
