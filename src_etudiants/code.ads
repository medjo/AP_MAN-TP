-- Representation d'un code binaire, suite de bits 0 ou 1.
-- D'autres operations peuvent etre ajoutees si necessaire, et 
-- toutes ne vous seront pas forcement utiles...

with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Listes.File;

package Code is

	Code_Vide, Code_Trop_Court : exception;


	-- Representation de bits
	subtype Bit is Natural range 0 .. 1;
	ZERO : constant Bit := 0;
	UN   : constant Bit := 1;

    package PListes is new Listes(Bit);
    use PListes;
    package PFile is new PListes.File;
    use PFile;

	type Code_Binaire is private;

	-- Cree un code initialement vide
	function Cree_Code return Code_Binaire;

	-- Copie un code existant
	function Cree_Code(C : in Code_Binaire) return Code_Binaire;


	-- insertion d'un element V en tete de liste
	procedure Enfiler(V: Bit; C: in out Code_Binaire);

	-- Libere un code
--	procedure Libere_Code(C : in out Code_Binaire);
	
	-- Retourne le nb de bits d'un code
--	function Longueur(C : in Code_Binaire) return Natural;

	-- Affiche un code
	procedure Affiche_Code(C : in Code_Binaire);

    --Retourne true si le code est vide
    function Est_Vide_Code(C : Code_Binaire) return Boolean;

	procedure Supprime_Tete_Code (C: in out Code_Binaire ; V : out Bit);
	
	procedure Insere_Queue_Code (C: in out Code_Binaire; V : in Bit);
	
    function Est_Null(C : Code_Binaire) return Boolean;

    function Declare_Code return Code_Binaire;

    function Get_File(C : Code_Binaire) return File;

	-- Ajoute le bit B en tete du code C
--	procedure Ajoute_Avant(B : in Bit; C : in out Code_Binaire);

	-- Ajoute le bit B en queue du code C
--	procedure Ajoute_Apres(B : in Bit; C : in out Code_Binaire);

	-- ajoute les bits de C1 apres ceux de C
--	procedure Ajoute_Apres(C1 : in Code_Binaire; C : in out Code_Binaire);


------------------------------------------------------------------------
--   PARCOURS D'UN CODE VIA UN "ITERATEUR"
--   Permet un parcours sequentiel du premier au dernier bit d'un code
--
--   Meme modele d'utilisation qu'en Java, C++, ... :
--	It : Iterateur_Code;
--	B : Bit;    
--	...
--	It := Cree_Iterateur(Code);
--	while Has_Next(It) loop
--		B := Next(It);
--		...	-- Traiter B
--	end loop;
------------------------------------------------------------------------

	Code_Entierement_Parcouru : exception;

--	type Iterateur_Code is private;

	-- Cree un iterateur initialise sur le premier bit du code
--	function Cree_Iterateur(C : Code_Binaire) return Iterateur_Code;

	-- Libere un iterateur (pas le code parcouru!)
--	procedure Libere_Iterateur(It : in out Iterateur_Code);

	-- Retourne True s'il reste des bits dans l'iteration
--	function Has_Next(It : Iterateur_Code) return Boolean;

	-- Retourne le prochain bit et avance dans l'iteration
	-- Leve l'exception Code_Entierement_Parcouru si Has_Next(It) = False
--	function Next(It : Iterateur_Code) return Bit;


private

	-- type prive: a definir dans le body du package, code.adb

	type Code_Binaire is access File;

	-- type prive: a definir dans le body du package, code.adb
--	type Iterateur_Code_Interne;

--	type Iterateur_Code is access Iterateur_Code_Interne;

end Code;
