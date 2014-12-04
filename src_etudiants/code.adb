-- Representation d'un code binaire, suite de bits 0 ou 1.
-- D'autres operations peuvent etre ajoutees si necessaire, et 
-- toutes ne vous seront pas forcement utiles...

package body Code is

    

    function Declare_Code return Code_Binaire is
    begin
        return null;
    end Declare_Code;

	function Cree_Code return Code_Binaire is
        C : Code_Binaire; 
    begin
        C := new File'(Cree_File);
        return C;
    end Cree_Code;

	function Cree_Code(C : in Code_Binaire) return Code_Binaire is
        C2 : Code_Binaire := Cree_Code;
        tmp : File := Cree_File;
    begin
        tmp := C.all;
        while not PFile.Est_Vide(tmp) loop
            PFile.Insere_Queue(tmp.val, C2.all);
            tmp := tmp.all.suiv;
        end loop;
        return C2;
    end Cree_Code;

	procedure Enfiler(V: Bit; C: in out Code_Binaire) is
    begin
        PFile.Enfiler(V, C.all);
    end Enfiler;

	procedure Affiche_Code(C : in Code_Binaire) is
        Browse : File := C.all;
	begin
        while not PFile.Est_Vide(Browse)loop
            Put(Browse.all.Val);
            Browse := Browse.all.Suiv;
        end loop;
	end Affiche_Code;

    function Est_Vide_Code(C : Code_Binaire) return Boolean is
    begin
        return PFile.Est_Vide(C.all);
    end Est_Vide_Code;

    function Est_Null(C : Code_Binaire) return Boolean is
    begin
        return C = null;
    end Est_Null;

	procedure Supprime_Tete_Code (C: in out Code_Binaire; V : out Bit) is
    begin
        PFile.Supprime_Tete(C.all, V);
    end Supprime_Tete_Code;
    
	procedure Insere_Queue_Code (C: in out Code_Binaire; V : in Bit) is
    begin
        PFile.Insere_Queue(V, C.all);
    end Insere_Queue_Code;

end Code;
