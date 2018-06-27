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

%Cosas que mira Gaston.
mira(gaston,hoc).

%Series populares.
popular(got).
popular(hoc).
popular(starWars).

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
leSpoileo(Persona1,Persona2,Serie):- fanaticoSerie(Persona2,Serie), paso(Serie,_,_,Spoiler), leDijo(Persona1,Persona2,Serie,Spoiler).

%Punto 5
%televidenteResponsable(Persona)
televidenteResponsable(Persona):- fanaticoSerie(Persona,_),not(leSpoileo(Persona,_,_)).

%Punto 6
vieneZafando(Persona,Serie):- fanaticoSerie(Persona,Serie),not(leSpoileo(_,Persona,Serie)),popular(Serie).
vieneZafando(Persona,Serie):- fanaticoSerie(Persona,Serie),not(leSpoileo(_,Persona,Serie)),
forall(paso(Serie,Temporada,_,_), pasoAlgoFuerte(Serie,Temporada)).
%La variable que entraria sin ligar seria la Temporada, asi verifica que en todas sus temporadas hayan pasado cosas fuertes.

pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,muerte(_)).
pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(amorosa,_,_)).
pasoAlgoFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(parentesco,_,_)).


%Definimos fanatico de una serie como a alguien que mira o planea ver una serie
fanaticoSerie(Persona,Serie):-mira(Persona,Serie).
fanaticoSerie(Persona,Serie):-planeaVer(Persona,Serie).

%run_tests.
:- begin_tests(spoileres).

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
	
test(le_spoileo,nondet) :-	
	leSpoileo(gaston,maiu,got).
	
test(le_spoileo2,nondet) :-	
	leSpoileo(nico,maiu,starWars).
	
test(televidente_responsable,set(Personas == [juan,aye,maiu])) :-	
	televidenteResponsable(Personas).
	
test(no_televidente_responsable,set(Personas == [nico,gaston])) :-	
	fanaticoSerie(Personas,_),not(televidenteResponsable(Personas)).

test(hay_algun_televidente_responsable,nondet) :-	
	televidenteResponsable(_).
		
test(viene_zafando_maiu) :-	
	not(vieneZafando(maiu,_)).

test(viene_zafando_juan,set(Series == [himym,got,hoc])) :-
	vieneZafando(juan,Series).

test(viene_zafando_nico,[true(Persona == nico), nondet]) :-
	vieneZafando(Persona,starWars).
	
:- end_tests(spoileres).