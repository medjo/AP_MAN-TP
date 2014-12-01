-- ***************************************************************************	
-- Package de liste chainee d'entiers.
-- Ici : representation de la liste vide par le POINTEUR NULL
-- INVARIANTS:
--   -> liste vide si L = null
--   -> si L non vide et Der la cellule contenant le dernier element,
--      alors Der.Suiv = null
-- ***************************************************************************
generic

	type Element is private;
	
	--with procedure Affiche_Element(El : Element);
	
package Listes is

    type Cellule;

	type Liste is access Cellule;

	--a partir de ce type on peut faire diverse hypotheses sur la facon
	-- dont la liste est representee, notamment en ce qui concerne la
	-- liste vide
	type Cellule is record
		Val: Element;
		Suiv: Liste;
	end record;
	

	-- exceptions levees par ce package
	Erreur_Liste_Vide : Exception;

------------------------------------------------------------------------------
-- PROCEDURES FOURNIES DANS LE .ADB

	-- cree une nouvelle liste, vide, et la retourne.	
	function Cree_Liste return Liste;

	-- libere une liste (memoire), apres l'avoir videe
	procedure Libere_Liste (L : in out Liste);
	
------------------------------------------------------------------------------
-- PROCEDURES A IMPLANTER DANS LE .ADB
-- ***** DANS CET ORDRE, EN TESTANT AU FUR ET A MESURE! *****
		
-- BLOC 1:
	-- true si liste vide, false sinon
	function Est_Vide (L: in Liste) return Boolean;

	-- insertion d'un element V en tete de liste
	procedure Insere_Tete (V: Element; L: in out Liste);

	-- affichage de la liste, dans l'ordre de parcours
	--procedure Affiche (L: in Liste);

	-- recherche sequentielle d'un element dans la liste
	function Est_Present (V: Element; L: Liste) return Boolean;


-- BLOC 2:
	-- Vide la liste
	procedure Vide (L: in out Liste);

	-- insertion d'un element V en queue de liste
	procedure Insere_Queue (V: Element; L: in out Liste);
	
-- BLOC 3:

	-- suppression de l'element en tete de liste
	procedure Supprime_Tete (L: in out Liste; V: out Element);
	
	-- suppression l'element en queue de liste
	procedure Supprime_Queue (L: in out Liste; V: out Element);
	
	-- suppression de la premiere occurence de V dans la liste
	procedure Supprime_Premiere_Occurence (V: Element; L: in out Liste);

	-- suppression de toutes les occurences de V de la liste
	procedure Supprime (V: Element; L: in out Liste);

-- BLOC 4: on ne reviendra pas dessus en cours, mais a finir pour vous!

	-- inversion de l'ordre des elements dans une liste
	-- (sans allocation et en temps lineaire)
	procedure Inverse (L: in out Liste);



end Listes;

