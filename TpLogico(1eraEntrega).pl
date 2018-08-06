%TpLogico Primera Entrega.
%Punto1.
%Cosas que mira Juan.
mira(juan,himym).
mira(juan,futurama).
mira(juan,got).

%Cosas que mira Nico
mira(nico,starWars).
mira(nico,got).

%Cosas que mira Maiu.
mira(maiu,starWars).
mira(maiu,onePiece).
mira(maiu,got).

%Cosas que mira Pedro
mira(pedro,got).

%Cosas que mira Gaston.
mira(gaston,hoc).

%Series que planeanVer
planeaVer(juan,hoc).
planeaVer(aye,got).
planeaVer(gaston,himym).

%Registrar Series - serie(Serie,Temporada,Episodios).
serie(got,3,12).
serie(got,2,10).
serie(himym,1,23).
serie(drHouse,8,16).

%Temporada de una serie.
temporada(Serie,T):- serie(Serie,T,_).

%Punto 2
%paso(Serie, Temporada, Episodio, Lo que paso)
paso(futurama, 2, 3, muerte(seymourDiera)).
paso(starWars, 10, 9, muerte(emperor)).
paso(starWars, 1, 2, relacion(parentesco, anakin, rey)).
paso(starWars, 3, 2, relacion(parentesco, vader, luke)).
paso(himym, 1, 1, relacion(amorosa, ted, robin)).
paso(himym, 4, 3, relacion(amorosa, swarley, robin)).
paso(got, 4, 5, relacion(amistad, tyrion, dragon)).
paso(got, 3, 2, plotTwist([suenio,sinPiernas])).
paso(got, 3, 12, plotTwist([fuego,boda])).
paso(supercampeones, 9, 9, plotTwist([suenio,coma,sinPiernas])).
paso(drHouse, 8, 7, plotTwist([coma,pastillas])).

%leDijo/4
leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)).
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).
leDijo(nico,juan,futurama,muerte(seymourDiera)).
leDijo(pedro,aye,got,relacion(amistad,tyrion,dragon)).
leDijo(pedro,nico,got,relacion(parentesco,tyrion,dragon)).

%Punto 3
%esSpoiler(Serie,Spoiler)
esSpoiler(Serie,Spoiler):-paso(Serie,_,_,Spoiler).

%Punto 4
%leSpoileo(Persona1,Persona2,Serie)
leSpoileo(Persona1,Persona2,Serie):- fanaticoSerie(Persona2,Serie),leDijo(Persona1,Persona2,Serie,Spoiler),esSpoiler(Serie,Spoiler).

%Punto 5
%televidenteResponsable(Persona)
televidenteResponsable(Persona):- fanaticoSerie(Persona,_),not(leSpoileo(Persona,_,_)).

%Punto 6
vieneZafando(Persona,Serie):- fanaticoSerie(Persona,Serie),not(leSpoileo(_,Persona,Serie)),popular(Serie).
vieneZafando(Persona,Serie):- fanaticoSerie(Persona,Serie),not(leSpoileo(_,Persona,Serie)),paso(Serie,_,_,_),
forall(paso(Serie,Temporada,_,_), pasoAlgoFuerte(Serie,Temporada,_)).
%La variable que entraria sin ligar seria la Temporada, asi verifica que en todas sus temporadas hayan pasado cosas fuertes.

pasoAlgoFuerte(Serie,Temporada,muerte(Persona)):- paso(Serie,Temporada,_,muerte(Persona)).
pasoAlgoFuerte(Serie,Temporada,relacion(amorosa,P1,P2)):- paso(Serie,Temporada,_,relacion(amorosa,P1,P2)).
pasoAlgoFuerte(Serie,Temporada,relacion(parentesco,P1,P2)):- paso(Serie,Temporada,_,relacion(parentesco,P1,P2)).

%Definimos fanatico de una serie como a alguien que mira o planea ver una serie
fanaticoSerie(Persona,Serie):-mira(Persona,Serie).
fanaticoSerie(Persona,Serie):-planeaVer(Persona,Serie).
