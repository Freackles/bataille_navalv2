PROGRAM bataille_naval;
USES crt;

CONST
    nb_bateau=2;
    max_case= 5.
    min_c= 1;
    max_c= 50;
    min_c= 1;
    max_c= 50;

TYPE cellule: RECORD
    ligne: INTEGER;
    colone: INTEGER;
END;

TYPE bateau: RECORD
    n_case: ARRAY [1..max_case] of cellule;
END;

TYPE flotte: RECORD
    nbateau: ARRAY [1..nb_bateau] of bateau;
END;

TYPE bool= (vrai, faux);

TYPE positionbateau= (ligne, colone, diagonal);

TYPE etatbateau= (toucher, couler);

TYPE etatflotte= (aflot, asombrer);

TYPE etatjoueur= (victoire, defaite);

procedure creacell (l, c: INTEGER;var ncell: cellule)
begin
    ncell.ligne:= l;
    ncell.colone:= c;
end;

function cmpcellule(ncel, tcel:cellule): bool;
begin
    cmpcellule:= faux;

    if ncel.ligne=tcel.ligne AND ncel.colone=tcel.colone then
    begin
        cmpcellule:= vrai;
    end;
        
end;

function creabateau (ncel: cellule; taille: INTEGER): bateau;
VAR
    tmpbateau: bateau;
    pose: INTEGER;
    i: INTEGER;
    pbateau: positionbateau;

begin
    randomize;
    pose:= random(1..3);
    pbateau:= positionbateau(pose);

    for i := 1 to max_case do
    begin
        if i<= taille then
        begin
            tmpbateau.ncel[i].ligne:= ncel.ligne;
            tmpbateau.ncel[i].colone:= ncel.colone;
        end
        else
        begin
            tmpbateau.ncel[i].ligne:= 0;
            tmpbateau.ncel[i].colone:= 0;
        end;
        
        if pbateau= ligne then
            ncel.colone:= ncel.colone+1;
        else if pbateau= colone then
            ncel.ligne:= ncel.ligne+1;
        else if pbateau= diagonal then
        begin
            ncel.ligne:= ncel.ligne+1;
            ncel.colone:= ncel.colone+1;
        end;
    end;

    creabateau:= tmpbateau;
end
            
function verifcellule (nbat: bateau; ncel: cellule): bool;
VAR
    i: INTEGER;
    test: bool;
begin
    test:= faux
    for i:= 1 to max_case do
    begin
        if cmpcellule(nbat.ncel[i], ncel)= vrai then
            test:= vrai;
    end;
    verifcellule:= test;
end;

function verifflote (f: flotte; ncel: cellule): bool;
VAR
    i: INTEGER;
    test: bool;
begin
    test:= faux;
    for i:= 1 to nb_bateau do
    begin
        if verifcellule(Var f.nbateau[i]; ncel)= vrai then
            test:= vrai;
            f.nbateau[i].colone:= 0;
            f.nbateau[i].ligne:= 0;
    end;
    verifflote:= test;
end;

Procedure flottejoueur (VAR ncel: cellule; VAR f: flotte);
VAR
    i, valposeligne, valposecolone, valtaillebat: INTEGER;
begin
    for i:= 1 to nb_bateau do
    begin
        valposeligne:= aleatoire(min_l..max_l);
        valposecolone:= aleatoire(min_c..max_c);
        valtaillebat:= aleatoire(1..max_case);

        creacellule(valposeligne, valposecolone, ncel);

        f.nb_bateau[i]:= creabateau(ncel, valtaillebat);
    end;
end;

procedure gamestart (var f1: flotte; var ef: etatflotte);
var
    i, j, cpt, cpt2: INTEGER;
    ncel, nul: cellule;
    test: bool;
    eb: ARRAY [1..nb_bateau] of etatbateau;
    ef: etatflotte;

begin
    creacell(0, 0, nul);
    cpt:= 0;
    cpt+1:= 0;

    writeln('preparez votre tir');
    readln;
    repeat  
        writeln('saisissez la ligne puis la colonne de votre tir');
        readln(ncel.ligne, ncel.colone);
    until ncel.ligne>0 AND ncel.ligne<=max_l and ncel.colone>0 and ncel.colone<=max_c;

    for i:= 1 to nb_bateau do
    begin
        if verifflote(f1, ncel)= vrai then
        begin
            f1.nbateau[i].ncel.ligne:= 0;
            f1.nbateau[i].ncel.colone:= 0;
            eb[i]:= toucher;
        end;

        for j:= 1 to max_case do
        begin
            if verifcellule(f1.nbateau[i], nul)= vrai then
            cpt:= cpt+1;
        end

        if cpt= max_case then
        begin
            eb[i]:= couler;
            cpt2:= cpt2+1;
        end
        writeln(eb[1]);
    end

    writeln(eb[1]);

    if cpt2< nb_bateau then
        ef:= aflot;
    else
    begin
        ef:= asombrer;
    end;
end;

var
    fl1, fl2: flotte;
    j1, j2: etatflotte;
    i, cpt: INTEGER;
    ncell: cellule;

begin
    cpt:= 1;

    writeln('Bienvenue dans le jeu du bataille naval')
    writeln('La partie va se lancer')
    writeln('creation de vos flotte')
    for i:= 1 to 2 do
    begin
        writeln('Joureur ', i);
        writeln('Vos bateaux seront disposés aléatoirement sur le plateau');
        repeat
            writeln('saisissez un coordonée au hasard (ordre: ligne puis colone');
            readln(ncell.ligne, ncell.colone);
        until ncell.ligne>0 AND ncell.ligne<=max_l and ncell.colone>0 and ncell.colone<=max_c;
        if i=1 then
            flottejoueur(ncell, f1);
        else
            flottejoueur(ncell, f2);
    end

    writeln('debut de la partie');
    repeat
        if cpt MOD 2= 0 then
        begin
            writeln('tour du joeur 2')
            gamestart(f2, j2)
        end
        else
        begin
            writeln('tour du joeur 1')
            gamestart(f1, j1)
        end
    cpt:= cpt+1;
    until j1= asombrer or j2= asombrer;

    if j1= asombrer then
    begin
        writeln ('La flotte du joueur 1 est assombrer!');
        writeln ('Joueur 2 remporte la victoire!');
    end
    else
    begin
        writeln ('La flotte du joueur 2 est assombrer!');
        writeln ('Joueur 1 remporte la victoire!');
    end;

    readln;
end.
            


