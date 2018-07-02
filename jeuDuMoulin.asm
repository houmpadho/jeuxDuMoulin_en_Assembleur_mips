	.data
messageDebutDeJeu: .asciiz "~~~~~~BIENVENUE~~~~~~\n C'ESTPARTIE POUR UNE PARTIE DE moulin\n Celui qui commence à jouer est le joueur n°1\n"
victoirJ1: .asciiz "FELICITATION Joueur2: Vous avez gagné la partie!!!!!! :) \n"
victoirJ2: .asciiz "FELICITATION Joueur2: Vous avez gagné la partie!!!!!! :) \n"
tableau: .space 48  #le tableau qui modelise le jeu: Chaque case a 2 entier( half sur 2octets): 2*24=48
elementModel1: .asciiz "-------------"
elementModel1Espace: .asciiz "             "
elementModel2: .asciiz "---------"
elementModel2Espace: .asciiz "         "
elementModel3: .asciiz "-----"
elementModel3Espace: .asciiz "     "
elementModel4: .asciiz "--"
elementModel4Espace: .asciiz "  "
elementModel4Espace1: .asciiz "            "
elementModelBarre1: .asciiz "||             ||             ||"
elementModelBarre2: .asciiz "||  ||         ||         ||  ||"
elementModelBarre3: .asciiz "||  ||  ||            ||  ||  ||"
elmentModelAvant2: .asciiz "||  "
elementModelApres2: .asciiz "  ||"
elementModelAvant3: .asciiz "||  ||  "
elementModelApres3: .asciiz "  ||  ||"
a_laligne: .asciiz "\n"
pion1: .asciiz " *"
pion2: .asciiz " +"
pasDePion: .asciiz "  "
messageRetirerPion1: .asciiz "Bravo, joueur n°"
messageRetirerPion2: .asciiz "\nVous venez de frapper un coup gagnant\n Vous allez maintenant capturer un pion adverse.\n Lequel voulez-vous capturer?\n"
messageErreurRetirerPion: .asciiz "\n Erreur! Vous devez choisir un pion de votre adversaire.Reessayer...\n"
erreurChoix: .asciiz "Erreur! votre choix ne correspond à aucun noeud. Réessayez...\n"

invitationJ1: .asciiz "Joueur1: Veillez entrez votre choix \n"
invitationJ2: .asciiz "Joueur2: Veillez entrez votre choix  \n"
nbPionsRestantJ1: .word 9
nbPionsRestantJ2: .word 9
pionsCapturesJ1: .word 0
pionsCapturesJ2: .word 0
modeJ1: .word 0
modeJ2: .word 0
messageErreurNonVide: .asciiz "Desolé. Cette place est dejà occupée. Reessayer...\n"
message1PionsRestantJ1: .asciiz "Joueur n°1, il vous reste "
message1PionsRestantJ2: .asciiz "Joueur n°2, il vous reste " 
message2PionsRestantJ1: .asciiz " pions à placer \n"
message2PionsRestantJ2: .asciiz " pions à placer \n"
messagePourDeplacerJ1: .asciiz "Joueur1: à vous de deplacer un de vos pions \n" 
messagePourDeplacerJ2: .asciiz "Joueur2: à vous de deplacer un de vos pions \n"
messagePionAdeplacer: .asciiz "Quel pion voulez vous deplacer \n"
messagePionDestination: .asciiz "Où voulez-vous envoyer ce pion? \n"
messageErreurNoeudOrigine: .asciiz "Désolé.C'est seulement vos pions que vous pouvez deplacer.Reessayez...\n"
messageErreurDestination: .asciiz "Désolé! ce deplacement est impossible. Reprenez vos choix...\n"
joueurActuel: .word 1

t_sauts: .word cas00, cas01, cas02, cas03, cas04, cas05, cas06, cas07, cas08, cas09, cas10, cas11, cas12, cas13, cas14, cas15, cas16, cas17, cas18, cas19, cas20, cas21, cas22, cas23 
T_SAUTS: .word CAS00, CAS01, CAS02, CAS03, CAS04, CAS05, CAS06, CAS07, CAS08, CAS09, CAS10, CAS11, CAS12, CAS13, CAS14, CAS15, CAS16, CAS17, CAS18, CAS19, CAS20, CAS21, CAS22, CAS23
.text
main: 
	jal jouerPartieMoulin
	
	ori $v0, $zero, 10
	syscall

#////////////////////////////    Fonction afficher pion  ////////////////////////////////////////////////////////////////////
afficherPion:         #entrée $a0 =(de 0 à 23) qui est le  numero du noeud.Pas de sortie.on utilise les registres $t0, $t1, $t2, $t3 et $ra

		addiu $sp, $sp, -24		#PROLOGUE
		sw $fp, 20($sp)
		addiu $fp, $sp,  24	
		 #on sauvergarde les registres
		sw $ra, 0($sp)
		sw $t0, 4($sp)
		sw $t1, 8($sp)
	 	sw $t2, 12($sp)
	 	sw $t3, 16($sp)
	 	
		
		la $t0, tableau # $t0 <- @tableau
		sll $a0, $a0, 1  # $a0 <- $a0 * 2
		add $t0, $t0, $a0 # $t0 <- @tableau[i]
		lh $t1, 0($t0)      #$t1 <- tableau[i]
		ori $t2, $zero, 1
		ori $t3, $zero, 2
		beq $t1, $t2, PionJoueur1
		beq $t1, $t3, PionJoueur2
		la $a0, pasDePion
		j suite
	PionJoueur1: 
		la $a0, pion1
		j suite
	PionJoueur2:
		la $a0, pion2
		j suite
	suite:
		ori $v0, $zero, 4
		syscall 
		
		 #restitution des registres
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		lw $t1, 8($sp)
	 	lw $t2, 12($sp)
	 	lw $t3, 16($sp)
	 	
	 	#EPILOGUE
		lw $fp, 20($sp)
		addiu $sp, $sp, 24
		jr $ra


#///////////////////////////////////////////   Fonction  afficherModel ////////////////////////////////////////////////////////
afficherModel:
	addiu $sp, $sp, -8 		#PROLOGUE
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	sw $ra, 0($sp)

#!!!!!!!!!!!!!  1ère ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	#on affiche le neud numero 0
	ori $a0, $zero, 0
	jal afficherPion
	
        #on affiche elementModel1
        la $a0, elementModel1
	ori $v0, $zero, 4
	syscall
	
	#on affiche le noeud numero 1
	ori $a0, $zero, 1
	jal afficherPion
	
	#on affiche elementModel1
        la $a0, elementModel1
	ori $v0, $zero, 4
	syscall
	
	#on affiche le noeud numero 2
	ori $a0, $zero, 2
	jal afficherPion
#!!!!!!!!!!!!!  Ligne des numero de la 1ère ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!		
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall
	
	#on afichiche la ligne des numeros des noeud
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel1Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel1Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 2
	ori $v0, $zero,1
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	
#!!!!!!!!!!!!!  Barres verticales pour separer la 1ère ligne à la 2ème!!!!!!!!!!!!!!!!!!!!!!!!!!!!!		
	#on affiche les barres verticales pour separer les lignes
	la $a0, elementModelBarre1
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall
	
#!!!!!!!!!!!!!  2ème ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	#on afiche la 2ème ligne
	la $a0, elmentModelAvant2
	ori $v0, $zero, 4
	syscall
	#le noeud numero 03
	ori $a0, $zero, 3
	jal afficherPion
	#elementModel2  après le noeud 03
	la $a0, elementModel2
	ori $v0, $zero, 4
	syscall
	#noeud 04
	ori $a0, $zero, 4
	jal afficherPion
	#elementModel2 après le noeud 04
	la $a0, elementModel2
	ori $v0, $zero, 4
	syscall
	#noeud 05
	ori $a0, $zero, 5
	jal afficherPion
	#après le neud 05
	la $a0, elementModelApres2
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	

#!!!!!!!!!!!!!  la ligne des numeros des noeuds de la 2ème ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	#on afichiche la ligne des numeros des noeud de la 2ème ligne
	la $a0, elmentModelAvant2
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 3
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel2Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 4
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel2Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 5
	ori $v0, $zero,1
	syscall
	
	la $a0, elementModelApres2
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	
#!!!!!!!!!!!!! on affiche les barres verticales pour separer les lignes!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	la $a0, elementModelBarre2
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	

#!!!!!!!!!!!!! 3ème ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	la $a0, elementModelAvant3
	ori $v0, $zero, 4
	syscall
	
	#noeud 06
	ori $a0, $zero, 6
	jal afficherPion
	#elementModel2 après le noeud 06
	la $a0, elementModel3
	ori $v0, $zero, 4
	syscall
	#noeud 07
	ori $a0, $zero, 7
	jal afficherPion
	#elementModel2 après le noeud 07
	la $a0, elementModel3
	ori $v0, $zero, 4
	syscall
	#noeud 08
	ori $a0, $zero, 8
	jal afficherPion
	
	la $a0, elementModelApres3
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall

#!!!!!!!!!!!!! la ligne des numeros des noeuds de la 3ème ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	la $a0, elementModelAvant3
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 6
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel3Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 7
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel3Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 8
	ori $v0, $zero,1
	syscall
	
	la $a0, elementModelApres3
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	
#!!!!!!!!!!!!! on affiche les barres verticales pour separer les lignes!!!!!!!!!!!!!!!!!!!!!			
	#on affiche les barres verticales pour separer les lignes
	la $a0, elementModelBarre3
	ori $v0, $zero, 4
	syscall
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall
	
	la $a0, elementModelBarre3
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall		
	
#!!!!!!!!!!!!! 4ème ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	#noeud 09
	ori $a0, $zero, 9
	jal afficherPion
	
	la $a0, elementModel4
	ori $v0, $zero, 4
	syscall
	
	#noeud 10
	ori $a0, $zero, 10
	jal afficherPion
	
	la $a0, elementModel4
	ori $v0, $zero, 4
	syscall
	
	#noeud 11
	ori $a0, $zero, 11
	jal afficherPion
	
	la $a0, elementModel4Espace1
	ori $v0, $zero, 4
	syscall 
	
	#noeud 12
	ori $a0, $zero, 12
	jal afficherPion
	
	la $a0, elementModel4
	ori $v0, $zero, 4
	syscall
	
	#noeud 13
	ori $a0, $zero, 13
	jal afficherPion
	
	
	la $a0, elementModel4
	ori $v0, $zero, 4
	syscall
	
	#noeud 14
	ori $a0, $zero, 14
	jal afficherPion

	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall

	
#!!!!!!!!!!!!! la ligne des numeros des noeuds de la 4ème ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 9
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel4Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel4Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	
	la $a0, elementModel4Espace1
	ori $v0, $zero, 4
	syscall 
	
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 2
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel4Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 3
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel4Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 4
	ori $v0, $zero,1
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall		

#!!!!!!!!!!!!! on affiche les barres verticales pour separer les lignes!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	#on affiche les barres verticales pour separer les lignes	
	la $a0, elementModelBarre3
	ori $v0, $zero, 4
	syscall
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	
	
	la $a0, elementModelBarre3
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	


#!!!!!!!!!!!!! 5ème ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	la $a0, elementModelAvant3
	ori $v0, $zero, 4
	syscall
	
	#noeud 15
	ori $a0, $zero, 15
	jal afficherPion
	#elementModel2 après le noeud 15
	la $a0, elementModel3
	ori $v0, $zero, 4
	syscall
	#noeud 16
	ori $a0, $zero, 16
	jal afficherPion
	#elementModel2 après le noeud 16
	la $a0, elementModel3
	ori $v0, $zero, 4
	syscall
	#noeud 17
	ori $a0, $zero, 17
	jal afficherPion
	
	la $a0, elementModelApres3
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall

#!!!!!!!!!!!!! la ligne des numeros des noeuds de la 5ème ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	la $a0, elementModelAvant3
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 5
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel3Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 6
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel3Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 7
	ori $v0, $zero,1
	syscall
	
	la $a0, elementModelApres3
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	
	
#!!!!!!!!!!!!! on affiche les barres verticales pour separer les lignes!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	la $a0, elementModelBarre2
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	


#!!!!!!!!!!!!!  6ème ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	#on afiche la 2ème ligne
	la $a0, elmentModelAvant2
	ori $v0, $zero, 4
	syscall
	#le noeud numero 18
	ori $a0, $zero, 18
	jal afficherPion
	#elementModel2  après le noeud 18
	la $a0, elementModel2
	ori $v0, $zero, 4
	syscall
	#noeud 19
	ori $a0, $zero, 19
	jal afficherPion
	#elementModel2 après le noeud 19
	la $a0, elementModel2
	ori $v0, $zero, 4
	syscall
	#noeud 20
	ori $a0, $zero, 20
	jal afficherPion
	#après le neud 20
	la $a0, elementModelApres2
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	

#!!!!!!!!!!!!!  la ligne des numeros des noeuds de la 2ème ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	la $a0, elmentModelAvant2
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 8
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel2Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 9
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel2Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 2
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 0
	ori $v0, $zero,1
	syscall
	
	la $a0, elementModelApres2
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	
#!!!!!!!!!!!!! on affiche les barres verticales pour separer les lignes!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	la $a0, elementModelBarre2
	ori $v0, $zero, 4
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	

#!!!!!!!!!!!!!  7ère ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	#on affiche le neud numero 21
	ori $a0, $zero, 21
	jal afficherPion
	
        #on affiche elementModel1
        la $a0, elementModel1
	ori $v0, $zero, 4
	syscall
	
	#on affiche le noeud numero 22
	ori $a0, $zero, 22
	jal afficherPion
	
	#on affiche elementModel1
        la $a0, elementModel1
	ori $v0, $zero, 4
	syscall
	
	#on affiche le noeud numero 23
	ori $a0, $zero, 23
	jal afficherPion
#!!!!!!!!!!!!!  Ligne des numeros de la 1ère ligne!!!!!!!!!!!!!!!!!!!!!!!!!!!!!		
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall
	
	#on afichiche la ligne des numeros des noeud
	ori $a0, $zero, 2
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 1
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel1Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 2
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 2
	ori $v0, $zero,1
	syscall
	
	la $a0 , elementModel1Espace
	ori $v0, $zero, 4
	syscall
	
	ori $a0, $zero, 2
	ori $v0, $zero,1
	syscall
	ori $a0, $zero, 3
	ori $v0, $zero,1
	syscall
	
	#on par à la ligne
	la $a0, a_laligne
	ori $v0, $zero, 4
	syscall	
	
	
	
	lw $ra, 0($sp) 			#EPILOGUE
	lw $fp, 4($sp)
	addiu $sp, $sp, 8
	jr $ra

#/////////////////////////////////////  Fonction joixJoueur //////////////////////////////////////////////////////////////////////

choixJoueur:                       #Pas d'etrée. Sortie: dans $v0.Registres Utilisés:$t0,$t1,$t2,$t3 , $a0, 
	 #on reserve de la memoire sur la pile
	 addiu $sp, $sp, -20
	 sw $fp, 16($sp)
	 addiu $fp, $sp, 20
	 #on sauvergarde les registre
	 sw $ra, 0($sp)
	 sw $a0, 4($sp)
	 sh $t0, 8($sp)
	 sh $t1, 10($sp)
	 sh $t2, 12($sp)
	 sh $t3, 14($sp)
	 
	jal afficherModel
	#message invitation à saisir son choix
	la $t0, joueurActuel
	lw $t0, 0($t0)
	ori $t1, $zero, 1
	beq $t0,$t1 joueur1_ChoixJoueur
	la $a0, invitationJ2
	j suite1_choixJoueur
	joueur1_ChoixJoueur: 
		la $a0, invitationJ1
	suite1_choixJoueur:
		ori $v0, $zero, 4
		syscall
	#on recupère le choix du joueur
	ori $v0, $zero, 5
	syscall
	# on s'assure que le choix est bien compris entre 0 et 23
	boucle1_choixJoueur:
		bgez $v0 suite2_choixJoueur
		la $a0, erreurChoix
		ori $v0, $zero,4
		syscall
		j suite3_choixJoueur
		
		suite2_choixJoueur:
			ori $t2, $zero, 24  # $t2 <- 24
			slt $t3, $v0, $t2
			beq $t3, $zero suite4_choixJoueur
			j finBoucle0
		suite4_choixJoueur:
			la $a0, erreurChoix
			ori $v0, $zero,4
			syscall
			j suite3_choixJoueur
		suite3_choixJoueur:
			#message invitation à saisir son choix
			la $t0, joueurActuel
			lw $t0, 0($t0)
			ori $t1, $zero, 1
			beq $t0,$t1 joueur1_ChoixJoueur
			la $a0, invitationJ2
			j suite1_choixJoueur
			joueur1_ChoixJoueur1: 
				la $a0, invitationJ1
				suite1_choixJoueur1:
				ori $v0, $zero, 4
				syscall
			#on recupère le choix du joueur
			ori $v0, $zero, 5
			syscall
			j boucle1_choixJoueur
	
		finBoucle0:
		
		#EPILOGUE
		#on restitue les registre
	 	lw $ra, 0($sp)
	 	lw $a0, 4($sp)
	 	lh $t0, 8($sp)
	 	lh $t1, 10($sp)
	 	lh $t2, 12($sp)
	 	lh $t3, 14($sp)
	 	#on libère la memoire de la pile
	 	lw $fp, 16($sp)
	 	addiu $sp, $sp, 20
	 	
	 	jr $ra
	
			
#//////////////////////////////////  Fonction estCoupGagnant  /////////////////////////////////////////////////////////////////////////////
#verifie si le joueur à marqué un coup: Entree: $a0. Sortie: $v0. Utilise:$t0, $t1 $t2, $t3, $t4, $t5, $ra				
estCoupGagnant:	

	 #on reserve de la memoire sur la pile
	 addiu $sp, $sp, -32
	 sw $fp, 28($sp)
	 addiu $fp, $sp, 32
	 #on sauvergarde les registres
	 sw $ra, 0($sp)
	 sw $t0, 4($sp)
	 sw $t1, 8($sp)
	 sw $t2, 12($sp)
	 sw $t3, 16($sp)
	 sw $t4, 20($sp)
	 sw $t5, 24($sp)
		
	SWITCH: sll $a0, $a0, 2
		la $t0 t_sauts
		addu $t1, $a0, $t0   		#$t1 <= &T_SAUT[K]
		lw $t1, 0($t1)      
		la $t2, joueurActuel
		lh $t2, 0($t2)                  # $t2 <- joueurActuel
		la $t3, tableau			#$t3 <- @tableau
		jr $t1
		cas00:
			lh $t4, 2($t3)          #$t4 <-tableau[1]
			lh $t5, 4($t3)          #$t5 <-tableau[2]
			bne $t2, $t4 l_autrePossibilite00
			bne $t2, $t5 l_autrePossibilite00
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite00:
				lh $t4, 18($t3)          #$t4 <-tableau[9]
				lh $t5, 42($t3)          #$t5 <-tableau[21]
				bne $t2, $t4 pasCoupGagnant00
				bne $t2, $t5 pasCoupGagnant00
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant00:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas01:
			lh $t4, 0($t3)          #$t4 <-tableau[0]
			lh $t5, 2($t3)          #$t5 <-tableau[2]
			bne $t2, $t4 l_autrePossibilite01
			bne $t2, $t5 l_autrePossibilite01
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite01:
				lh $t4, 8($t3)          #$t4 <-tableau[4]
				lh $t5, 14($t3)          #$t5 <-tableau[7]
				bne $t2, $t4 pasCoupGagnant01
				bne $t2, $t5 pasCoupGagnant01
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant01:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas02:
			lh $t4, 0($t3)          #$t4 <-tableau[0]
			lh $t5, 2($t3)          #$t5 <-tableau[1]
			bne $t2, $t4 l_autrePossibilite02
			bne $t2, $t5 l_autrePossibilite02
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite02:
				lh $t4, 28($t3)          #$t4 <-tableau[14]
				lh $t5, 46($t3)          #$t5 <-tableau[23]
				bne $t2, $t4 pasCoupGagnant02
				bne $t2, $t5 pasCoupGagnant02
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant02:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas03:
			lh $t4, 8($t3)          #$t4 <-tableau[4]
			lh $t5, 10($t3)          #$t5 <-tableau[5]
			bne $t2, $t4 l_autrePossibilite03
			bne $t2, $t5 l_autrePossibilite03
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite03:
				lh $t4, 10($t3)          #$t4 <-tableau[10]
				lh $t5, 18($t3)          #$t5 <-tableau[18]
				bne $t2, $t4 pasCoupGagnant03
				bne $t2, $t5 pasCoupGagnant03
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant03:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas04:
			lh $t4, 2($t3)          #$t4 <-tableau[1]
			lh $t5, 14($t3)          #$t5 <-tableau[7]
			bne $t2, $t4 l_autrePossibilite04
			bne $t2, $t5 l_autrePossibilite04
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite04:
				lh $t4, 6($t3)          #$t4 <-tableau[3]
				lh $t5, 10($t3)          #$t5 <-tableau[5]
				bne $t2, $t4 pasCoupGagnant04
				bne $t2, $t5 pasCoupGagnant04
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant04:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas05:
			lh $t4, 6($t3)          #$t4 <-tableau[3]
			lh $t5, 8($t3)          #$t5 <-tableau[4]
			bne $t2, $t4 l_autrePossibilite05
			bne $t2, $t5 l_autrePossibilite05
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite05:
				lh $t4, 26($t3)          #$t4 <-tableau[13]
				lh $t5, 40($t3)          #$t5 <-tableau[20]
				bne $t2, $t4 pasCoupGagnant05
				bne $t2, $t5 pasCoupGagnant05
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant05:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas06:
			lh $t4, 14($t3)          #$t4 <-tableau[7]
			lh $t5, 16($t3)          #$t5 <-tableau[8]
			bne $t2, $t4 l_autrePossibilite06
			bne $t2, $t5 l_autrePossibilite06
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite06:
				lh $t4, 22($t3)          #$t4 <-tableau[11]
				lh $t5, 30($t3)          #$t5 <-tableau[15]
				bne $t2, $t4 pasCoupGagnant06
				bne $t2, $t5 pasCoupGagnant06
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant06:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas07:
			lh $t4, 2($t3)          #$t4 <-tableau[1]
			lh $t5, 8($t3)          #$t5 <-tableau[4]
			bne $t2, $t4 l_autrePossibilite07
			bne $t2, $t5 l_autrePossibilite07
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite07:
				lh $t4, 12($t3)          #$t4 <-tableau[6]
				lh $t5, 16($t3)          #$t5 <-tableau[8]
				bne $t2, $t4 pasCoupGagnant07
				bne $t2, $t5 pasCoupGagnant07
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant07:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas08:
			lh $t4, 12($t3)          #$t4 <-tableau[6]
			lh $t5, 14($t3)          #$t5 <-tableau[7]
			bne $t2, $t4 l_autrePossibilite08
			bne $t2, $t5 l_autrePossibilite08
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite08:
				lh $t4, 24($t3)          #$t4 <-tableau[12]
				lh $t5, 34($t3)          #$t5 <-tableau[17]
				bne $t2, $t4 pasCoupGagnant08
				bne $t2, $t5 pasCoupGagnant08
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant08:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas09:
			lh $t4, 0($t3)          #$t4 <-tableau[0]
			lh $t5, 42($t3)          #$t5 <-tableau[21]
			bne $t2, $t4 l_autrePossibilite09
			bne $t2, $t5 l_autrePossibilite09
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite09:
				lh $t4, 20($t3)          #$t4 <-tableau[10]
				lh $t5, 22($t3)          #$t5 <-tableau[11]
				bne $t2, $t4 pasCoupGagnant09
				bne $t2, $t5 pasCoupGagnant09
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant09:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas10:
			lh $t4, 18($t3)          #$t4 <-tableau[9]
			lh $t5, 22($t3)          #$t5 <-tableau[11]
			bne $t2, $t4 l_autrePossibilite10
			bne $t2, $t5 l_autrePossibilite10
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite10:
				lh $t4, 6($t3)          #$t4 <-tableau[3]
				lh $t5, 36($t3)          #$t5 <-tableau[18]
				bne $t2, $t4 pasCoupGagnant10
				bne $t2, $t5 pasCoupGagnant10
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant10:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas11:
			lh $t4, 18($t3)          #$t4 <-tableau[9]
			lh $t5, 20($t3)          #$t5 <-tableau[10]
			bne $t2, $t4 l_autrePossibilite11
			bne $t2, $t5 l_autrePossibilite11
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite11:
				lh $t4, 12($t3)          #$t4 <-tableau[6]
				lh $t5, 30($t3)          #$t5 <-tableau[15]
				bne $t2, $t4 pasCoupGagnant11
				bne $t2, $t5 pasCoupGagnant11
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant11:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas12:
			lh $t4, 16($t3)          #$t4 <-tableau[8]
			lh $t5, 34($t3)          #$t5 <-tableau[17]
			bne $t2, $t4 l_autrePossibilite12
			bne $t2, $t5 l_autrePossibilite12
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite12:
				lh $t4, 26($t3)          #$t4 <-tableau[13]
				lh $t5, 28($t3)          #$t5 <-tableau[14]
				bne $t2, $t4 pasCoupGagnant12
				bne $t2, $t5 pasCoupGagnant12
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant12:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas13:
			lh $t4, 24($t3)          #$t4 <-tableau[12]
			lh $t5, 28($t3)          #$t5 <-tableau[14]
			bne $t2, $t4 l_autrePossibilite13
			bne $t2, $t5 l_autrePossibilite13
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite13:
				lh $t4, 10($t3)          #$t4 <-tableau[5]
				lh $t5, 40($t3)          #$t5 <-tableau[20]
				bne $t2, $t4 pasCoupGagnant13
				bne $t2, $t5 pasCoupGagnant13
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant13:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas14:
			lh $t4, 14($t3)          #$t4 <-tableau[12]
			lh $t5, 26($t3)          #$t5 <-tableau[13]
			bne $t2, $t4 l_autrePossibilite14
			bne $t2, $t5 l_autrePossibilite14
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite14:
				lh $t4, 4($t3)          #$t4 <-tableau[2]
				lh $t5, 46($t3)          #$t5 <-tableau[23]
				bne $t2, $t4 pasCoupGagnant14
				bne $t2, $t5 pasCoupGagnant14
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant14:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas15:
			lh $t4, 12($t3)          #$t4 <-tableau[6]
			lh $t5, 22($t3)          #$t5 <-tableau[11]
			bne $t2, $t4 l_autrePossibilite15
			bne $t2, $t5 l_autrePossibilite15
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite15:
				lh $t4, 32($t3)          #$t4 <-tableau[16]
				lh $t5, 34($t3)          #$t5 <-tableau[17]
				bne $t2, $t4 pasCoupGagnant15
				bne $t2, $t5 pasCoupGagnant15
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant15:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas16:
			lh $t4, 30($t3)          #$t4 <-tableau[15]
			lh $t5, 34($t3)          #$t5 <-tableau[17]
			bne $t2, $t4 l_autrePossibilite16
			bne $t2, $t5 l_autrePossibilite16
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite16:
				lh $t4, 38($t3)          #$t4 <-tableau[19]
				lh $t5, 44($t3)          #$t5 <-tableau[22]
				bne $t2, $t4 pasCoupGagnant16
				bne $t2, $t5 pasCoupGagnant16
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant16:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas17:
			lh $t4, 30($t3)          #$t4 <-tableau[15]
			lh $t5, 32($t3)          #$t5 <-tableau[16]
			bne $t2, $t4 l_autrePossibilite17
			bne $t2, $t5 l_autrePossibilite17
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite17:
				lh $t4, 16($t3)          #$t4 <-tableau[8]
				lh $t5, 24($t3)          #$t5 <-tableau[12]
				bne $t2, $t4 pasCoupGagnant17
				bne $t2, $t5 pasCoupGagnant17
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant17:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas18:
			lh $t4, 2($t3)          #$t4 <-tableau[3]
			lh $t5, 4($t3)          #$t5 <-tableau[10]
			bne $t2, $t4 l_autrePossibilite18
			bne $t2, $t5 l_autrePossibilite18
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite18:
				lh $t4, 18($t3)          #$t4 <-tableau[19]
				lh $t5, 42($t3)          #$t5 <-tableau[20]
				bne $t2, $t4 pasCoupGagnant18
				bne $t2, $t5 pasCoupGagnant18
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant18:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas19:
			lh $t4, 36($t3)          #$t4 <-tableau[18]
			lh $t5, 40($t3)          #$t5 <-tableau[20]
			bne $t2, $t4 l_autrePossibilite19
			bne $t2, $t5 l_autrePossibilite19
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite19:
				lh $t4, 32($t3)          #$t4 <-tableau[16]
				lh $t5, 44($t3)          #$t5 <-tableau[22]
				bne $t2, $t4 pasCoupGagnant19
				bne $t2, $t5 pasCoupGagnant19
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant19:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas20:
			lh $t4, 10($t3)          #$t4 <-tableau[5]
			lh $t5, 26($t3)          #$t5 <-tableau[13]
			bne $t2, $t4 l_autrePossibilite20
			bne $t2, $t5 l_autrePossibilite20
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite20:
				lh $t4, 36($t3)          #$t4 <-tableau[18]
				lh $t5, 38($t3)          #$t5 <-tableau[19]
				bne $t2, $t4 pasCoupGagnant20
				bne $t2, $t5 pasCoupGagnant20
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant20:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas21:
			lh $t4, 0($t3)          #$t4 <-tableau[0]
			lh $t5, 18($t3)          #$t5 <-tableau[9]
			bne $t2, $t4 l_autrePossibilite21
			bne $t2, $t5 l_autrePossibilite21
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite21:
				lh $t4, 44($t3)          #$t4 <-tableau[22]
				lh $t5, 46($t3)          #$t5 <-tableau[23]
				bne $t2, $t4 pasCoupGagnant21
				bne $t2, $t5 pasCoupGagnant21
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant21:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas22:
			lh $t4, 32($t3)          #$t4 <-tableau[16]
			lh $t5, 38($t3)          #$t5 <-tableau[19]
			bne $t2, $t4 l_autrePossibilite22
			bne $t2, $t5 l_autrePossibilite22
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite22:
				lh $t4, 18($t3)          #$t4 <-tableau[21]
				lh $t5, 42($t3)          #$t5 <-tableau[23]
				bne $t2, $t4 pasCoupGagnant22
				bne $t2, $t5 pasCoupGagnant22
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant22:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH
		cas23:
			lh $t4, 2($t3)          #$t4 <-tableau[2]
			lh $t5, 4($t3)          #$t5 <-tableau[14]
			bne $t2, $t4 l_autrePossibilite23
			bne $t2, $t5 l_autrePossibilite23
			ori $v0, $zero, 1        # Coup gagnant !
			j finSWITCH
			l_autrePossibilite23:
				lh $t4, 18($t3)          #$t4 <-tableau[21]
				lh $t5, 42($t3)          #$t5 <-tableau[22]
				bne $t2, $t4 pasCoupGagnant23
				bne $t2, $t5 pasCoupGagnant23
				ori $v0, $zero, 1        # Coup gagnant !
				j finSWITCH
			pasCoupGagnant23:
				addi $v0, $zero, 0       # Coup non Gagnant
				j finSWITCH

		finSWITCH:
		# Restitution des registres
	 	lw $ra, 0($sp)
	 	lw $t0, 4($sp)
		lw $t1, 8($sp)
	 	lw $t2, 12($sp)
	 	lw $t3, 16($sp)
	 	lw $t4, 20($sp)
	 	lw $t5, 24($sp)
		
		# Liberation de la memoire pile
		lw $fp, 28($sp)
		
		addiu $sp, $sp, 32
		
		jr $ra
			
#//////////////////////////fonction mvtPossible/////////////////////////////////////////////////////////////////////////////////
# Verifie si un deplacement est autorisé ou non: Entree: $a0: Origine et $a1: destination. Sortie: $v0. Utilise:$t0, $t1, $t2, $t3, $t4, $t5 et $t6
mvtPossible: 
	#on reserve de la memoire sur la pile
	 addiu $sp, $sp, -36
	 sw $fp, 32($sp)
	 addiu $fp, $sp, 36
	 #on sauvergarde les registres
	 sw $ra, 0($sp)
	 sw $t0, 4($sp)
	 sw $t1, 8($sp)
	 sw $t2, 12($sp)
	 sw $t3, 16($sp)
	 sw $t4, 20($sp)
	 sw $t5, 24($sp)
	 sw $t6, 28($sp)
	
	 
	 SWITCH1:
	 	sll $a0, $a0, 2
		la $t0 T_SAUTS
		addu $t1, $a0, $t0   		#$t1 <= &T_SAUT[K]
		lw $t1, 0($t1)      
		la $t2, tableau                 # $t2 <- &tableau
		jr $t1
		
		CAS00:
			ori $t3, $zero, 1
			ori $t4, $zero, 9
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
			
		CAS01: 
			ori $t3, $zero, 0
			ori $t4, $zero, 2
			ori $t5, $zero, 4 
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			j   impossible
	 
	 	CAS02:
			ori $t3, $zero, 1
			ori $t4, $zero, 14
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
			
		CAS03:
			ori $t3, $zero, 4
			ori $t4, $zero, 10
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
			
		CAS04: 
			ori $t3, $zero, 1
			ori $t4, $zero, 3
			ori $t5, $zero, 5 
			ori $t6, $zero, 7
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			beq $a1, $t6   possible
			j   impossible
	 
	 	CAS05:
			ori $t3, $zero, 4
			ori $t4, $zero, 13
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
			
		CAS06:
			ori $t3, $zero, 7
			ori $t4, $zero, 11
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
	  
	  	CAS07: 
			ori $t3, $zero, 4
			ori $t4, $zero, 6
			ori $t5, $zero, 8 
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			j   impossible
			
		CAS08:
			ori $t3, $zero, 7
			ori $t4, $zero, 12
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
			
		CAS09: 
			ori $t3, $zero, 0
			ori $t4, $zero, 10
			ori $t5, $zero, 21
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			j   impossible
			
		CAS10: 
			ori $t3, $zero, 3
			ori $t4, $zero, 9
			ori $t5, $zero, 11 
			ori $t6, $zero, 18
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			beq $a1, $t6   possible
			j   impossible
			
		CAS11: 
			ori $t3, $zero, 6
			ori $t4, $zero, 10
			ori $t5, $zero, 15
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			j   impossible
			
		CAS12: 
			ori $t3, $zero, 8
			ori $t4, $zero, 13
			ori $t5, $zero, 17
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			j   impossible
			
		CAS13: 
			ori $t3, $zero, 5
			ori $t4, $zero, 12
			ori $t5, $zero, 14 
			ori $t6, $zero, 20
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			beq $a1, $t6   possible
			j   impossible
			
		CAS14: 
			ori $t3, $zero, 2
			ori $t4, $zero, 13
			ori $t5, $zero, 23
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			j   impossible
			
		CAS15:
			ori $t3, $zero, 11
			ori $t4, $zero, 16
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
			
		CAS16: 
			ori $t3, $zero, 15
			ori $t4, $zero, 17
			ori $t5, $zero, 19
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			j   impossible
			
		CAS17:
			ori $t3, $zero, 12
			ori $t4, $zero, 16
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
		
		CAS18:
			ori $t3, $zero, 10
			ori $t4, $zero, 19
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
		
		CAS19: 
			ori $t3, $zero, 16
			ori $t4, $zero, 18
			ori $t5, $zero, 20
			ori $t6, $zero, 22
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			beq $a1, $t6   possible
			j   impossible
			
		CAS20:
			ori $t3, $zero, 13
			ori $t4, $zero, 19
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
			
		CAS21:
			ori $t3, $zero, 09
			ori $t4, $zero, 22
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
			
		CAS22: 
			ori $t3, $zero, 19
			ori $t4, $zero, 21
			ori $t5, $zero, 23
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			beq $a1, $t5   possible
			j   impossible
			
		CAS23:
			ori $t3, $zero, 14
			ori $t4, $zero, 22
			beq $a1, $t3   possible
			beq $a1, $t4   possible
			j   impossible
		
		possible:
			ori $v0, $zero, 1
			j finMvtPossible
		impossible:
			ori $v0, $zero, 0
			j finMvtPossible
			
		finMvtPossible: 
		
	 # Restitution des registres
	 lw $ra, 0($sp)
	 lw $t0, 4($sp)
	 lw $t1, 8($sp)
	 lw $t2, 12($sp)
	 lw $t3, 16($sp)
	 lw $t4, 20($sp)
	 lw $t5, 24($sp)
	 lw $t6, 28($sp)
		
	# Liberation de la memoire pile
	 lw $fp, 32($sp)
		
	 addiu $sp, $sp, 36
		
	 jr $ra

#////////////   Fonction retirerPion   ////////////////////////////////////////////////

retirerPion:      #Entree vide. Sortie: Vide. Utilise: $t0,$t1,$t2,$t3, $t4, $t5, $t6, 
	#on reserve de la memoire sur la pile
	 addiu $sp, $sp, -36
	 sw $fp, 32($sp)
	 addiu $fp, $sp, 36
	 #on sauvergarde les registres
	 sw $ra, 0($sp)
	 sw $t0, 4($sp)
	 sw $t1, 8($sp)
	 sw $t2, 12($sp)
	 sw $t3, 16($sp)
	 sw $t4, 20($sp)
	 sw $t5, 24($sp)
	 sw $t6, 28($sp)

	
	la $t0, joueurActuel    
	lh $t0, 0($t0)         #$t0 <- joueurActuel
	ori $t1, $zero, 1       
	beq $t0, $t1 J2
	ori $t2, $zero, 1      # $t2= adversaire = joueur n°1
	j finAdversaire
	J2:ori $t2, $zero, 2   # $t2= adversaire = joueur n°2
	finAdversaire:
	#On affiche la grille
	jal afficherModel
	#message pour retirer un pion
	la $a0, messageRetirerPion1
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t0
	ori $v0, $zero, 1
	syscall
	la $a0, messageRetirerPion2
	ori $v0, $zero, 4
	syscall
	
	#on recupère le choix du joueur dans $t3 
	jal choixJoueur
	or $t3, $zero, $v0
	
	la $t4, tableau
	boucleRetirerPion:
		sll $t3, $t3, 1  #  $t3 <- $t3*2.  Pour calculer l'adresse du noeud choisi
		addu $t5, $t4, $t3  # $t5 <- &tableau[k]
		lh $t6, 0($t5)      # $t6 <- tableau[k]
		beq $t6, $t2 fin_boucleRetirerPion   # la choix correspond à un pion adverse
		#message d'erreur . on recommence le choix
		la $a0, messageErreurRetirerPion
		ori $v0, $zero, 4
		syscall
		jal choixJoueur
		or $t3, $zero, $v0
		j boucleRetirerPion
		
	fin_boucleRetirerPion:
	#on retir le pion en question
		ori $t6, $zero, 0    #t6 <- 0
		sh $t6, 0($t5)       #tableau[k] = 0   On vide ce noeud
	#on incremente le nombre de pions capturés
	la $t2, joueurActuel
	lw $t2, 0($t2)
	ori $t3, $zero, 2
	beq $t2, $t3 joueur2
	la $t0, pionsCapturesJ1
	lw $t4, 0($t0)             #$t0 <- pionsCapturesJ1
	ori $t1, $zero, -1
	add $t4, $t4, $t1
	sw $t4, 0($t0)
	j finRetirer
	joueur2:	
	la $t0, pionsCapturesJ2	
	lw $t4, 0($t0)             #$t1 <- pionsCapturesJ2
	ori $t1, $zero, -1
	add $t4, $t4, $t1
	sw $t4, 0($t0)
	finRetirer:
	
	
		
	# Restitution des registres
	 lw $ra, 0($sp)
	 lw $t0, 4($sp)
	 lw $t1, 8($sp)
	 lw $t2, 12($sp)
	 lw $t3, 16($sp)
	 lw $t4, 20($sp)
	 lw $t5, 24($sp)
	 lw $t6, 28($sp)
		
	# Liberation de la memoire pile
	 lw $fp, 32($sp)
		
	 addiu $sp, $sp, 36
		
	 jr $ra
	 
#////////////// La fonction placer()  ///////////////////////////////////////////////////////////////////////////////:
#////////////// La fonction placer()  ///////////////////////////////////////////////////////////////////////////////:
placer:       # Entrée vide. Sortie: vide. Utilise: $t0 $t1 $t2 $t3 $t4 $t5 $t6 $t7 $a0 $v0 $ra
	
	#on reserve de la memoire sur la pile
	 addiu $sp, $sp, -48
	 sw $fp, 44($sp)
	 addiu $fp, $sp, 48
	 #on sauvergarde les registres
	 sw $ra, 0($sp)
	 sw $t0, 4($sp)
	 sw $t1, 8($sp)
	 sw $t2, 12($sp)
	 sw $t3, 16($sp)
	 sw $t4, 20($sp)
	 sw $t5, 24($sp)
	 sw $t6, 28($sp)
	 sw $t7, 32($sp)
	 sw $a0, 36($sp)
	 sw $v0, 40($sp)
	 
	jal choixJoueur
	ori $t6, $v0, 0    # $t6 <- choix du joueur
	la $t1, tableau    # $t1 <- @tableau
	
	bouclePlacer:
		sll $t0, $t6, 1  # $t0*2
		addu $t2, $t1, $t0 # $t2 <- @tableau[k]
		lh $t4, 0($t2)         #$t2 <- tableau[k]
		ori $t3, $zero, 0
		bne $t4, $t3 placeNonVide
		j fin_bouclePlacer
		placeNonVide:
			la $a0, messageErreurNonVide
			ori $v0, $zero, 4
			syscall
			jal choixJoueur
			ori $t6, $v0, 0    # $t6 <- choix du joueur
			j bouclePlacer
		fin_bouclePlacer:
		la $t0, joueurActuel  
		lh $t5, 0($t0)			# $t5 <- joueurActuel		
		sh $t5, 0($t2)                  # place le pion
		#message nb de pions restants
		
		ori $t1, $zero, 1
		bne $t5, $t1 c_estLeJoueur2
		la $a0, message1PionsRestantJ1
		ori $v0, $zero, 4
		syscall
		
		la $t3, nbPionsRestantJ1
		lw $a0, 0($t3)
		ori $t7, $zero, -1
		add $a0, $a0, $t7
		sw $a0, 0($t3)
		ori $v0, $zero, 1
		syscall
		
		la $a0, message2PionsRestantJ1
		ori $v0, $zero, 4
		syscall 
		j suite1Placer
		c_estLeJoueur2:
		la $a0, message1PionsRestantJ2
		ori $v0, $zero, 4
		syscall
		
		la $t3, nbPionsRestantJ2
		lw $a0, 0($t3)
		ori $t7, $zero, -1
		add $a0, $a0, $t7
		sw $a0, 0($t3)
		ori $v0, $zero, 1
		syscall 
		
		la $a0, message2PionsRestantJ2
		ori $v0, $zero, 4
		syscall
		
		suite1Placer:
		#on verifie si son coup est gagnant ou non
		ori $a0, $t6, 0
		jal estCoupGagnant
		beq $v0, $zero finPlacer #si c'est pas gagant
		#si coup gagnant
		jal retirerPion
		finPlacer:
		#assurer l'alternance des joueurs
		la $t0, joueurActuel
		lh $t5, 0($t0)
		ori $t1,$zero, 1
		beq $t5, $t1 c_etaitJ1
		ori $t5, $zero, 1
		sh $t5, 0($t0)
		j finiPlacer
		c_etaitJ1:
		ori $t5, $zero, 2
		sh $t5, 0($t0)
		finiPlacer:

		# Restitution des registres
		lw $ra, 0($sp)
	 	lw $t0, 4($sp)
	 	lw $t1, 8($sp)
	 	lw $t2, 12($sp)
	 	lw $t3, 16($sp)
	 	lw $t4, 20($sp)
	 	lw $t5, 24($sp)
	 	lw $t6, 28($sp)
		
		# Liberation de la memoire pile
	 	lw $fp, 44($sp)
		addiu $sp, $sp, 48
		jr $ra
		
		
#//////////////////// Fonction DEPLACER ////////////////////////////////////////////////////////////////////////////////////
#//////////////////// Fonction DEPLACER ////////////////////////////////////////////////////////////////////////////////////
deplacer:# ne prends rien en entrée, utilise les registre t0 t1 t2 t3 t4 t5 t6 t7 ra
	#on reserve de la memoire sur la pile
	 addiu $sp, $sp, -44
	 sw $fp, 40($sp)
	 addiu $fp, $sp, 44
	 #on sauvergarde les registre
	 sw $ra, 0($sp)
	 sw $a0, 4($sp)
	 sw $a1, 8($sp)
	 sw $t0, 12($sp)
	 sw $t1, 16($sp)
	 sw $t2, 20($sp)
	 sw $t3, 24($sp)
	 sw $t4, 28($sp)
	 sw $t5, 32($sp)
	 sw $t6, 36($sp)
	 
	 
	#message pour deplacer selon jour
	la $t0,joueurActuel
	lw $t0, 0($t0)        #$t0 <- joueurActuel
	ori $t2, $zero, 1
	beq $t0, $t2 c_estJ1
	la $a0, messagePourDeplacerJ2
	ori $v0, $zero, 4
	syscall
	c_estJ1:
	la $a0, messagePourDeplacerJ1
	ori $v0, $zero, 4
	syscall
	
	#choix pion à deplacer
debutDesBoucles:
	la $a0, messagePionAdeplacer
	ori $v0, $zero, 4
	syscall
	jal choixJoueur
	or $t3, $zero, $v0     # $t3 <- choix NoeudOrigine
	la $t5, tableau         # $t5 <- &tableau 
	
	boucleNoeudOrigine:
		sll $t6, $t3, 1
		add $t6, $t6, $t5  #$t6 <- &tableau[k]
		lh $t1, 0($t6)     #$t1 <- tableau[k]
		beq $t1, $t0 fin_boucleNoudOrigine
		la $a0, messageErreurNoeudOrigine
		ori $v0, $zero, 4
		syscall
		#choix pion à deplacer
		la $a0, messagePionAdeplacer
		ori $v0, $zero, 4
		syscall
		jal choixJoueur
		or $t3, $zero, $v0     # $t3 <- choix NoeudOrigine
		j boucleNoeudOrigine
		
	fin_boucleNoudOrigine:
		#message pour le choix de destination
		la $a0, messagePionDestination
		ori $v0, $zero, 4
		syscall
		#on recupère ce choix
		jal choixJoueur
		or $t4, $zero, $v0   # $t4 <- choix Destination
		
	boucleNoeudDestination:
		#arguments de la fonction mvtPossible
		or $a0, $zero, $t3
		or $a1, $zero, $t4
		jal mvtPossible
		or $t7, $zero, $v0      #$t7 <- retour de la fonction
		bne $t7, $zero mvtAutorise
		#message erreur de mouvement
		la $a0, messageErreurDestination
		ori $v0, $zero, 4
		syscall
		j debutDesBoucles
	mvtAutorise:
		#effacer le pion à deplacer
		sll $t6, $t3, 1
		add $t6, $t6, $t5  #$t6 <- &tableau[k]
		sh $zero, 0($t6)
		
		#ajouter un pion à la place indiquée
		sll $t6, $t4, 1
		add $t6, $t6, $t5  #$t6 <- &tableau[k]
		sh $t0, 0($t6)
		
		#on verifie si son deplacement est gagnant ou non
		ori $a0, $t4, 0
		jal estCoupGagnant
		beq $v0, $zero finDeplacer #si c'est pas gagant
		#si coup gagnant
		jal retirerPion
		finDeplacer:
		#assurer l'alternance des joueurs
		la $t0, joueurActuel
		lw $t5, 0($t0)
		ori $t1,$zero, 1
		beq $t5, $t1 c_etaitJ1deplacer
		ori $t5, $zero, 1
		sh $t5, 0($t0)
		j finiDeplacer
		c_etaitJ1deplacer:
		ori $t5, $zero, 2
		sh $t5, 0($t0)
		finiDeplacer:
		
		  #on sauvergarde les registre
	 	sw $ra, 0($sp)
	 	sw $a0, 4($sp)
	 	sw $a1, 8($sp)
	 	sw $t0, 12($sp)
	 	sw $t1, 16($sp)
	 	sw $t2, 20($sp)
	 	sw $t3, 24($sp)
	 	sw $t4, 28($sp)
	 	sw $t5, 32($sp)
	 	sw $t6, 36($sp)
	 	#EPILOGUE
	 	lw $fp, 40($sp)
		addiu $sp, $sp, 44
		jr $ra
		
#///////////// Fonction jouerUnePartie /////////////////////////////////////////////////////////////////////////////
jouerPartieMoulin:  # Pas d'entrée et pas sortie. Utilise: $t0, $t1, $t2, $t3, $t4 et $t5
	#on reserve de la memoire sur la pile
	 addiu $sp, $sp, -32
	 sw $fp, 28($sp)
	 addiu $fp, $sp, 32
	 #on sauvergarde les registres
	 sw $ra, 0($sp)
	 sw $t0, 4($sp)
	 sw $t1, 8($sp)
	 sw $t2, 12($sp)
	 sw $t3, 16($sp)
	 sw $t4, 20($sp)
	 sw $t5, 24($sp)


	la $a0, messageDebutDeJeu
	ori $v0, $zero, 4
	syscall
	
	
	bouclePartieMoulin:
	la $t0, pionsCapturesJ1
	lw $t0, 0($t0)             #$t0 <- pionsCapturesJ1	
	la $t1, pionsCapturesJ2	
	lw $t1, 0($t1)             #$t1 <- pionsCapturesJ2
	
	#on verifie si le jeu est fini ou non
	ori $t5, $zero, 7
	
	#pour le J1
	beq $t0, $t5 J1_A_GAGNE
	beq $t1, $t5 J2_A_GAGNE
	
	la $t2, joueurActuel
	lw $t2, 0($t2)             #$t2 <- joueurActuel
	ori $t3, $zero, 2          # $t3 <- 2
	
	beq $t2, $t3 tourJ2
	tourJ1:
	la $t4, modeJ1
	lw $t4, 0($t4)     #$t4 <- mode du joueur
	beq $t4, $zero pasFiniDePlacer1
	jal deplacer
	j bouclePartieMoulin
	pasFiniDePlacer1:
	jal placer
	j bouclePartieMoulin
	
	tourJ2:
	la $t4, modeJ2
	lw $t4, 0($t4)     #$t4 <- mode du joueur
	beq $t4, $zero pasFiniDePlacer2
	jal deplacer
	j bouclePartieMoulin
	pasFiniDePlacer2:
	jal placer
	j bouclePartieMoulin
	
	J1_A_GAGNE:
	la $a0, victoirJ1
	ori $v0, $zero, 4
	syscall
	j FIN
	J2_A_GAGNE:
	la $a0, victoirJ2
	ori $v0, $zero, 4
	syscall
	FIN:
	
	# Restitution des registres
	 lw $ra, 0($sp)
	 lw $t0, 4($sp)
	 lw $t1, 8($sp)
	 lw $t2, 12($sp)
	 lw $t3, 16($sp)
	 lw $t4, 20($sp)
	 lw $t5, 24($sp)
		
	# Liberation de la memoire pile
	 lw $fp, 28($sp)	
	 addiu $sp, $sp, 32
		
	 jr $ra