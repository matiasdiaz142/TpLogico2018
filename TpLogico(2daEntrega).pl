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
esPopular(got).
esPopular(hoc).
esPopular(starWars).

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
vieneZafando(Persona,Serie):- vio(Persona,Serie),not(leSpoileo(_,Persona,Serie)),esPopular(Serie).
vieneZafando(Persona,Serie):- vio(Persona,Serie),not(leSpoileo(_,Persona,Serie)),forall(vio(Persona,Serie),pasoAlgoFuerte(Serie,_)).

pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,muerte(_)).
pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(amorosa,_,_)).
pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(parentesco,_,_)).

vio(Persona,Serie):-mira(Persona,Serie).
vio(Persona,Serie):-planeaVer(Persona,Serie).

 %Segunda Entrega
 
 %Punto 1
malaGente(Persona):- persona(Persona),forall(leDijo(Persona,OtraPersona,Serie,_),leSpoileo(Persona,OtraPersona,Serie)).
malaGente(Persona):-vio(Persona2,Serie),leDijo(Persona,Persona2,Serie,_),not(mira(Persona,Serie)).

%No uso el predicado leSpoileo porque al considerar esSpoiler(Serie,Spoiler) al final del predicado, aye nunca entraria
%ya que, las cosas que les dijo no son spoilers. Si las cosas que aye dijo son spoilers, se contradice con el punto de 
%televidenteResponsable que dice que aye no dijo ningun spoiler a nadie.

%malaGente(Persona):-leSpoileo(Persona,_,Serie),not(mira(Persona,Serie)).

%Punto 2
fuerte(Serie,AlgoQuePaso):-pasoAlgoFuerte(Serie,_),paso(Serie,_,_,AlgoQuePaso).

%Punto 3
popularidad(Serie,Popularidad):- esPopular(Serie),findall(Persona,mira(Persona,Serie),PersonasQueMiran),length(PersonasQueMiran,CantidadQueMiran),
findall(Persona,leDijo(Persona,_,Serie,_),PersonasQueConversan),length(PersonasQueConversan,CantidadQueConversan),
Popularidad is CantidadQueMiran*CantidadQueConversan.

popular(Serie):-popularidad(Serie,Popularidad),popularidad(starWars,PopularidadStarwars),Popularidad >= PopularidadStarwars.

%Punto 4
amigo(nico, maiu).
amigo(maiu, gaston).
amigo(maiu, juan).
amigo(juan, aye).

fullSpoil(Persona1,Persona2):-leDijo(Persona1,Persona2,_,_).
fullSpoil(Persona1,Persona2):-leDijo(Persona1,OtraPersona,_,_),amigo(OtraPersona,Persona2),Persona1 \= Persona2.
fullSpoil(Persona1,Persona2):-leDijo(Persona1,OtraPersona,_,_),amigo(OtraPersona,Persona3),amigo(Persona3,Persona2),Persona1 \= Persona2.