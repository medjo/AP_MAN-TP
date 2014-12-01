-- Representation d'un code binaire, suite de bits 0 ou 1.
-- D'autres operations peuvent etre ajoutees si necessaire, et 
-- toutes ne vous seront pas forcement utiles...

package body Code is

    


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

end Code;
