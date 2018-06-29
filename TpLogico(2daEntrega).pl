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

%Cosas que mira Pedro
mira(pedro,got).

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
leDijo(nico,juan,futurama,muerte(seymourDiera)).
leDijo(pedro,aye,got,relacion(amistad,tyrion,dragon)).
leDijo(pedro,nico,got,relacion(parentesco,tyrion,dragon)).

%paso(got, 3, 2, plotTwist([suenio,sinPiernas]).
%paso(got, 3, 12, plotTwist([fuego,boda]).
%paso(supercampeones, 9, 9, plotTwist([suenio,coma,sinPiernas]).
%paso(drHouse, 8, 7, plotTwist([coma,pastillas]).

%Punto 3
%esSpoiler(Serie,Spoiler)
esSpoiler(Serie,Spoiler):-paso(Serie,_,_,Spoiler).

%Punto 4
%leSpoileo(Persona1,Persona2,Serie)
leSpoileo(Persona1,Persona2,Serie):-fanaticoSerie(Persona2,Serie),leDijo(Persona1,Persona2,Serie,Spoiler),esSpoiler(Serie,Spoiler).

%Punto 5
%televidenteResponsable(Persona)
televidenteResponsable(Persona):-fanaticoSerie(Persona,_),not(leSpoileo(Persona,_,_)).

%Definimos fanatico de una serie como a alguien que mira o planea ver una serie.
fanaticoSerie(Persona,Serie):-mira(Persona,Serie).
fanaticoSerie(Persona,Serie):-planeaVer(Persona,Serie).

%Punto 6
vieneZafando(Persona,Serie):- fanaticoSerie(Persona,Serie),not(leSpoileo(_,Persona,Serie)),esPopular(Serie).
vieneZafando(Persona,Serie):- fanaticoSerie(Persona,Serie),not(leSpoileo(_,Persona,Serie)),forall(paso(Serie,Temporada,_,_),pasoAlgoFuerte(Serie,Temporada)).

pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,muerte(_)).
pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(amorosa,_,_)).
pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(parentesco,_,_)).

 %Segunda Entrega
 
 %Punto 1
malaGente(Persona):- fanaticoSerie(Persona,_),forall(leDijo(Persona,OtraPersona,_,_),leSpoileo(Persona,OtraPersona,_)).
malaGente(Persona):-fanaticoSerie(Persona2,Serie),leDijo(Persona,Persona2,Serie,_),not(mira(Persona,Serie)).

%Punto 2
fuerte(Serie,AlgoQuePaso):-pasoAlgoFuerte(Serie,_),paso(Serie,_,_,AlgoQuePaso).
%fuerte(Serie,plotTwist):- not(cliche()),paso(Serie,_,_,AlgoQuePaso).
%cliche(Serie,Lista):- plotTwist(_,_,_,Lista),forall(plotTwist(Serie2,_,_,Lista2),(member(Elemento,Lista),member(Elemento,Lista2))).

%Punto 3
popular(hoc).
popular(Serie):-popularidad(Serie,Popularidad),popularidad(starWars,PopularidadStarwars),Popularidad >= PopularidadStarwars.

popularidad(Serie,Popularidad):- esPopular(Serie),findall(Persona,mira(Persona,Serie),PersonasQueMiran),length(PersonasQueMiran,CantidadQueMiran),
findall(Persona,leDijo(Persona,_,Serie,_),PersonasQueConversan),length(PersonasQueConversan,CantidadQueConversan),
Popularidad is CantidadQueMiran*CantidadQueConversan.

%Punto 4
amigo(nico, maiu).
amigo(maiu, gaston).
amigo(maiu, juan).
amigo(juan, aye).

fullSpoil(Persona1,Persona2):-leDijo(Persona1,Persona2,_,_).
fullSpoil(Persona1,Persona2):-leDijo(Persona1,OtraPersona,_,_),amigoDeAmigos(OtraPersona,Persona2),Persona1 \= Persona2.

amigoDeAmigos(Persona1,Persona2):-amigo(Persona1,Persona2).
amigoDeAmigos(Persona1,Persona2):-amigo(Persona1,OtraPersona),amigoDeAmigos(OtraPersona,Persona2),Persona1 \= Persona2.

%run_tests.
:- begin_tests(spoileres).
%Tests Primera Entrega
%Punto 3
test(es_spoiler_emperor,nondet) :-
	esSpoiler(starWars,muerte(emperor)).
  
test(no_es_spoiler_pedro,fail) :-
	esSpoiler(starWars,muerte(pedro)).

test(hay_algun_spoiler,nondet) :-
	esSpoiler(starWars,muerte(_)).
    
test(es_spoiler_relacion,nondet) :-	
	esSpoiler(starWars,relacion(parentesco,anakin,rey)).
	
test(no_es_spoiler_relacion,fail) :-	
	esSpoiler(starWars,relacion(padre,anakin,lavezzi)).
	
test(hay_algun_spoiler_relacion,nondet) :-	
	esSpoiler(starWars,relacion(parentesco,_,_)).
%Punto 4
test(le_spoileo,nondet) :-	
	leSpoileo(gaston,maiu,got).
	
test(le_spoileo2,nondet) :-	
	leSpoileo(nico,maiu,starWars).
%Punto 5
test(televidente_responsable,set(Personas == [juan,aye,maiu])) :-	
	televidenteResponsable(Personas).
	
test(no_televidente_responsable,set(Personas == [nico,gaston,pedro])) :-	
	fanaticoSerie(Personas,_),not(televidenteResponsable(Personas)).

test(hay_algun_televidente_responsable,nondet) :-	
	televidenteResponsable(_).
%Punto 6		
test(viene_zafando_maiu) :-	
	not(vieneZafando(maiu,_)).

test(viene_zafando_juan,set(Series == [himym,got,hoc])) :-
	vieneZafando(juan,Series).

test(viene_zafando_nico,[true(Persona == nico), nondet]) :-
	vieneZafando(Persona,starWars).
	
%Tests Segunda Entrega
%Punto 1
test(mala_gente_aye,nondet):-
	malaGente(aye).
	
test(mala_gente_gaston,nondet):-
	malaGente(gaston).
	
test(mala_gente_pedro):-
	not(malaGente(pedro)).
%Punto 2
test(muerte_seymouDiera_futurama,nondet):-
	fuerte(futurama,muerte(seymourDiera)).
	
test(muerte_emperor_starWars,nondet):-
	fuerte(starWars,muerte(emperor)).
	
test(parentesco_anakin_rey_starWars,nondet):-
	fuerte(starWars,relacion(parentesco, anakin, rey)).
	
test(parentesco_vader_luke_starWars,nondet):-
	fuerte(starWars,relacion(parentesco, vader, luke)).
	
test(amorosa_ted_robin_himym,nondet):-
	fuerte(himym,relacion(amorosa, ted, robin)).

test(amorosa_swarley_robin_himym,nondet):-
	fuerte(himym,relacion(amorosa, swarley, robin)).
	
%Faltan mas test de plot twist
%Punto 3
test(popular_got):-
	popular(got).

test(popular_starWars):-
	popular(starWars).

test(popular_hoc,nondet):-
	popular(hoc).
	
%Punto 4	
test(fullSpoil1,set(Personas == [aye,juan,maiu,gaston])):-
	fullSpoil(nico,Personas).

test(fullSpoil2,set(Personas == [maiu,juan,aye])):-
	fullSpoil(gaston,Personas).

test(fullSpoil3):-
	not(fullSpoil(maiu,_)).

:- end_tests(spoileres).