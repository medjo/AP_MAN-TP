
package body Dico is

    type Dico_Caracteres_Interne is array (Natural range 0 .. 255) of Code_Binaire;

    function Cree_Dico return Dico_Caracteres is
        D : Dico_Caracteres;
    begin
        D := new Dico_Caracteres_Interne'(others => Cree_Code);
        return D;
    end Cree_Dico;


	procedure Set_Code(C : in Character; Code : in Code_Binaire; D : in out Dico_Caracteres)


end Dico;
