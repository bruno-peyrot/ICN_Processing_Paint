/*
      PROCESSING PAINT
      par B. PEYROT
      décembre 2016
      Lycée Elisée Reclus de Sainte Foy La Grande
      pour le cours d'I.C.N.
*/


// Déclaration des variables
int largeur;
color couleur;
PImage dessin;
PImage gomme;
PImage sauvegarde;
PImage chargement;
PImage sauvegardeok;
PImage effacement;
PImage fond;
PImage curseurcrayon;
PImage curseurgomme;
int crayon;
int choix;
int attente;

void setup() {
  // Initialisations
  size(800,660);
  background(250);
  strokeWeight(1);
  stroke(0);
  PImage menu=loadImage("Menu.png");
  image(menu,0,0);
  gomme=loadImage("gomme.png");
  sauvegarde=loadImage("sauvegarde.png");
  chargement=loadImage("chargement.png");
  sauvegardeok=loadImage("sauvegardeok.png");
  effacement=loadImage("effacement.png");
  curseurcrayon=loadImage("curseurcrayon.png");
  curseurgomme=loadImage("curseurgomme.png");
  largeur=1;
  couleur=0;
  crayon=1;
  attente=0;
  choix=0;
  trait();
}

void trait() {
  // Indique la largeur et la couleur du crayon en cours
  stroke(0);
  strokeWeight(1);
  fill(250);
  rect(680,587,40,40);
  stroke(couleur);
  strokeWeight(largeur);
  line(685,622,715,592);
}

void draw() {
  
/*
  Affiche les coordonnées du curseur de la souris
  fill(250);
  rect(0,0,100,100);
  fill(0);
  textSize(20);
  text(mouseX,0,20);
  text(mouseY,0,40);
  fill(250);
*/
  
  // Sélection du curseur de la souris
  if (attente==0) {
    if (mouseY>=500) {
      cursor(HAND);
    } else {
      if (crayon==1) {
        cursor(curseurcrayon,1,28);
      } else {
        cursor(curseurgomme,16,16);
      }
    }
  } else {
    cursor(HAND);
  }
    
  // Si aucune boite de dialogue en attente :
  if (attente==0) {
    // Si la souris est cliquée
    if (mousePressed) {
      if (mouseButton == LEFT) {
        if ((pmouseY<495)&&(mouseY<495)) {
          // si on est dans la fenêtre de dessin, on trace
          line(pmouseX, pmouseY, mouseX, mouseY);
        }
        if ((mouseY>576)&&(mouseY<635)&&(mouseX>18)&&(mouseX<237)) {
          // Choix d'une couleur dans la palette
          couleur=get(mouseX,mouseY);
          stroke(couleur);
          strokeWeight(largeur);
          crayon=1;
          trait();
        }
        if ((mouseY>588)&&(mouseY<625)&&(mouseX>269)&&(mouseX<307)) {
          // Choix du pinceau fin
          largeur=1;
          strokeWeight(largeur);
          stroke(couleur);
          crayon=1;
          trait();
        }
        if ((mouseY>588)&&(mouseY<625)&&(mouseX>309)&&(mouseX<347)) {
          // Choix du pinceau moyen
          largeur=3;
          strokeWeight(largeur);
          stroke(couleur);
         crayon=1;
          trait();
        }
        if ((mouseY>588)&&(mouseY<625)&&(mouseX>349)&&(mouseX<387)) {
          // Choix du pinceau large
          largeur=5;
          strokeWeight(largeur);
          stroke(couleur);
          crayon=1;
          trait();
        }
        if ((mouseY>588)&&(mouseY<625)&&(mouseX>389)&&(mouseX<427)) {
          // Choix de la gomme
          strokeWeight(10);
          stroke(255);
          crayon=0;
          image(gomme,680,587);
        }
        if ((mouseY>588)&&(mouseY<625)&&(mouseX>429)&&(mouseX<467)) {
          // Sauvegarde fichier
          fond=get(200,400,393,171);
          image(sauvegarde,200,400);
          attente=2;        
        }
        if ((mouseY>588)&&(mouseY<625)&&(mouseX>469)&&(mouseX<507)) {
          // Lecture fichier
          fond=get(200,400,393,171);
          image(chargement,200,400);
          attente=1;        
        }
        if ((mouseY>588)&&(mouseY<625)&&(mouseX>509)&&(mouseX<547)) {
          // Effacement de l'écran
          fond=get(200,400,393,171);
          image(effacement,200,400);
          attente=4;
        }
      }
    }
  }
  // Si la boite d'attente "Chargement" est affichée :
  if (attente==1) {
    if (attente==1) {
      // gère la boîte de dialogue "Chargement"
      if (mousePressed) {
        if (mouseButton == LEFT) {
          // Bouton "Oui" cliqué ?
          if ((mouseY>498)&&(mouseY<535)&&(mouseX>329)&&(mouseX<414)) {
            choix=1;
          }
          // Bouton "Non" cliqué ?
          if ((mouseY>498)&&(mouseY<535)&&(mouseX>472)&&(mouseX<557)) {
            choix=2;
          }
        }
      }
      // Si "Oui" cliqué, on charge l'image
      if (choix==1) {
        dessin=loadImage("dessin.png");
        image(dessin,0,0);
        trait();
        choix=0;
        attente=0;
      } else {
        // Si "Non" cliqué", on efface la boite de dialogue
        if (choix==2) {
          image(fond,200,400);
          choix=0;
          attente=0;
        }
      }
    }
  }
  // Si la boite d'attente "Sauvegarde" est affichée :
  if (attente==2) {
      // gère la boîte de dialogue "Sauvegarde"
      if (mousePressed) {
        if (mouseButton == LEFT) {
          // Bouton "Oui" cliqué ?
          if ((mouseY>498)&&(mouseY<535)&&(mouseX>329)&&(mouseX<414)) {
            choix=1;
          }
          // Bouton "Non" cliqué ?
          if ((mouseY>498)&&(mouseY<535)&&(mouseX>472)&&(mouseX<557)) {
            choix=2;
          }
        }
      }
      // Si "Oui" cliqué, on sauvegarde l'image
      if (choix==1) {
        image(fond,200,400);
        save("data/dessin.png");
        choix=0;
        fond=get(200,400,393,171);
        image(sauvegardeok,200,400);
        attente=3;
      } else {
        // Si "Non" cliqué", on efface la boite de dialogue
        if (choix==2) {
          image(fond,200,400);
          choix=0;
          attente=0;
        }
      }
  }
  // Si la boite d'attente "Sauvegarde confirmée" est affichée :
  if (attente==3) {
    // gère la boîte de dialogue "Sauvegarde confirmée"
    if (mousePressed) {
      if (mouseButton == LEFT) {
        // Bouton "OK" cliqué ?
        if ((mouseY>498)&&(mouseY<535)&&(mouseX>405)&&(mouseX<489)) {
          image(fond,200,400);
          attente=0;
        }
      }
    }
  }
    // Si la boite d'attente "Effacement" est affichée :
  if (attente==4) {
      // gère la boîte de dialogue "Effacement"
      if (mousePressed) {
        if (mouseButton == LEFT) {
          // Bouton "Oui" cliqué ?
          if ((mouseY>498)&&(mouseY<535)&&(mouseX>329)&&(mouseX<414)) {
            choix=1;
          }
          // Bouton "Non" cliqué ?
          if ((mouseY>498)&&(mouseY<535)&&(mouseX>472)&&(mouseX<557)) {
            choix=2;
          }
        }
      }
      // Si "Oui" cliqué, on efface l'image
      if (choix==1) {
        image(fond,200,400);
        noStroke();
        fill(250);
        rect(0,0,800,500);
        stroke(couleur);
        crayon=1;
        trait();
        choix=0;
        attente=0;
      } else {
        // Si "Non" cliqué", on efface la boite de dialogue
        if (choix==2) {
          image(fond,200,400);
          choix=0;
          attente=0;
        }
      }
  }
}