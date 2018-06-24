%Tp Logico Primera Entrega
%Punto 1
%Cosas que mira Juan
mira(juan,himym).
mira(juan,futurama).
mira(juan,got).

%Cosas que mira Nico
mira(nico,starWars).
mira(nico,got).

%Cosas que mira Maiu
mira(maiu,starWars).
mira(maiu,onePiece).
mira(maiu,got).

%Cosas que mira Gaston
mira(gaston,hoc).

%Series populares
popular(got).
popular(hoc).
popular(starWars).

%Series que planean ver
planeaVer(juan,hoc).
planeaVer(aye,got).
planeaVer(gaston,himym).

%Registrar Series - serie(Serie,Temporada,Episodios)
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

%leDijo/4
leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)).
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).

%Punto 3
%esSpoiler(Serie,Spoiler)
esSpoiler(Serie,Spoiler):-paso(Serie,_,_,Spoiler).

%Punto 4
%leSpoileo(Persona1,Persona2,Serie)
leSpoileo(Persona1,Persona2,Serie):-vio(Persona2,Serie),leDijo(Persona1,Persona2,Serie,Spoiler),esSpoiler(Serie,Spoiler).

%Punto 5
%televidenteResponsable(Persona)
televidenteResponsable(Persona):-persona(Persona),not(leSpoileo(Persona,_,_)).

persona(Persona):-mira(Persona,_).
persona(Persona):-planeaVer(Persona,_).

%Punto 6
vieneZafando(Persona,Serie):- vio(Persona,Serie),not(leSpoileo(_,Persona,Serie)),popular(Serie).
vieneZafando(Persona,Serie):- vio(Persona,Serie),not(leSpoileo(_,Persona,Serie)),forall(vio(Persona,Serie),pasoAlgoFuerte(Serie,T)).

pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,muerte(_)).
pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(amorosa,_,_)).
pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(parentesco,_,_)).

vio(Persona,Serie):-mira(Persona,Serie).
vio(Persona,Serie):-planeaVer(Persona,Serie).

 %Segunda Entrega
 
 %Punto 1
 
 malaGente(Persona):- persona(Persona),forall(leDijo(Persona,OtraPersona,Serie,_),leSpoileo(Persona,OtraPersona,Serie)).
 