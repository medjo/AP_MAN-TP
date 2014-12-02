
package body Dico is

    type Dico_Caracteres_Interne is array (Natural range 0 .. 255) of Code_Binaire;

    function Cree_Dico return Dico_Caracteres is
        D : Dico_Caracteres;
    begin
        D := new Dico_Caracteres_Interne'(others => Cree_Code);
        return D;
    end Cree_Dico;


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

end Dico;
