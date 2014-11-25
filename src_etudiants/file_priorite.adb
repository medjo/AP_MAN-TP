with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;
with Ada.Streams.Stream_IO;

package body File_Priorite is
	
	type Element is
		record
			Data : Donnee;
			Prio : Priorite;
		end record;
					
	type Table is array (Positive range <>) of Element;
	
	type File_Interne is 
		record
			Tab : Table;
			Capacite : Integer;
		end record;
	
	procedure Liberer is new Ada.Unchecked_Deallocation (File_Interne, File_Prio);	
	
	function Cree_File(Capacite: Positive) return File_Prio is
		Tab : Table(Positive'First .. Capacite);
		File : File_Prio := new File_Interne'(Tab, 0);
	begin
		return File;
	end Cree_File;
		
	procedure Libere_File(F : in out File_Prio) is
	begin
		Liberer(F);
	end Libere_File;
	
	function Est_Vide(F: in File_Prio) return Boolean is
	begin
		return (F = NULL);
	end Est_Vide;
	
	function Est_Pleine(F: in File_Prio) return Boolean is
	begin
		if (F.all.Capacite < (F.all.Tab)'Last) then
			return false;
		else
			return true;
		end if;
	end Est_Pleine;
	
	procedure Insere(F : in File_Prio; D : in Donnee; P : in Priorite) is
		E : Element := new Element(D, P);
		Indice : Integer;
		Tmp : Element;
	begin
		if (Est_Vide(F)) then
			raise File_Prio_Vide;
		elsif (NOT(Est_Pleine(F))) then
			F.all.Capacite := F.all.Capacite + 1;
			F.all.Tab[Capacite] := E;
			Indice := Capacite;
			while (Est_Prioritaire (F.all.Tab[Indice].Prio, F.all.Tab[Indice/2].Prio)) loop
				Tmp := F.all.Tab[Indice];
				F.all.Tab[Indice] := F.all.Tab[Indice/2];
				F.all.Tab[Indice/2] := Tmp;
				Indice := Indice/2;
			end loop;
		else
			raise File_Prio_Pleine;
		end if;
	end Insere;
	
	procedure Supprime(F: in File_Prio; D: out Donnee; P: out Priorite) is
		Indice : Integer;
		Tmp : Element;
		Fils_G_Prio : Boolean;
		Fils_D_Prio : Boolean;
		
		--Si l'element à l'indice Fils n'est pas dans le tas
		--		renvoie faux
		--Sinon
		--		renvoie Est_Prioritaire(elem fils, elem pere)
		function Existe_Et_Est_Prio(Fils : in Integer; Pere : in Integer) return Boolean is
		begin
			if (Fils <= F.all.Capacite) then
				return Est_Prioritaire (F.all.Tab[Fils].Prio, F.all.Tab[Pere].Prio);
			else
				return false;
			end if;
		end Existe_Et_Est_Prio;
		
	begin
		if (Est_Vide(F)) then
			raise File_Prio_Vide;
		else 
			D := F.all.Tab[(F.all.Tab)'First].Data;
			P := F.all.Tab[(F.all.Tab)'First].Prio;
			F.all.Tab[(F.all.Tab)'First] := F.all.Tab[F.all.Capacite];
			F.all.Capacite := F.all.Capactite - 1;
			Indice := F.all.Tab'First;
			Fils_G_Prio := Existe_Et_Est_Prio (2 * Indice, Indice);
			Fils_D_Prio := Existe_Et_Est_Prio (2 * Indice + 1, Indice);
			while (Indice <= F.all.Capacite / 2
					AND	(Fils_G_Prio OR Fils_D_Prio))
			loop
				if ((2 * Indice + 1) > F.all.Capacite 
						OR Est_Prioritaire (F.all.Tab[2 * Indice].Prio, 
								F.all.Tab[2 * Indice + 1].Prio));
				then
					Tmp := F.all.Tab[Indice];
					F.all.Tab[Indice] := F.all.Tab[Indice * 2];
					F.all.Tab[Indice * 2] := Tmp;
					Indice := Indice * 2;
					Fils_G_Prio := Existe_Et_Est_Prio (2 * Indice, Indice);
					Fils_D_Prio := Existe_Et_Est_Prio (2 * Indice + 1, Indice);
				else 
					Tmp := F.all.Tab[Indice];
					F.all.Tab[Indice] := F.all.Tab[Indice * 2 + 1];
					F.all.Tab[Indice * 2 + 1] := Tmp;
					Indice := Indice * 2 + 1;
					Fils_G_Prio := Existe_Et_Est_Prio (2 * Indice, Indice);
					Fils_D_Prio := Existe_Et_Est_Prio (2 * Indice + 1, Indice);
				end if;
			end loop;
		end if;
	end Supprime;
	
	procedure Prochain(F: in File_Prio; D: out Donnee; P: out Priorite) is 
	begin
		if (Est_Vide(F)) then
			raise File_Prio_Vide;
		else 
			D := F.all.Tab[(F.all.Tab)'First].Data;
			P := F.all.Tab[(F.all.Tab)'First].Prio;
		end if;
	end Prochain;
	
end File_Priorite;
