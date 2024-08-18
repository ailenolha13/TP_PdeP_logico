% Civilizaciones y tecnologías 

% 1. Modelo de jugadores, civilizaciones y tecnologías 
% Datos: 
% - Personas: Ana, Beto, Carola, Dimitri, Elsa
% - Civilizaciones: romanos, incas
% - Tecnologias: herrería, forja, emplumado, láminas, fundición.

% Modelando jugadores: 
jugador(ana).
jugador(beto).
jugador(carola).
jugador(dimitri).
% jugador(elsa). elsa queda excluida de la partida, pues no juega

% Modelando civilizaciones:
civilizacion(romanos).
civilizacion(incas).

% Modelando tecnologías:
tecnologia(herreria).
tecnologia(forja).
tecnologia(emplumado).
tecnologia(laminas).
tecnologia(fundicion).

% Asociando jugadores a civilizacion:
juegaPartida(ana, romanos).
juegaPartida(beto, incas).
juegaPartida(carola, romanos).
juegaPartida(dimitri, romanos).
% juegaPartida(elsa, -). elsa queda excluida de la partida, pues no juega

% Asociando jugadores con tecnologia desarrollada:
desarrollaTecnologia(ana, herreria).
desarrollaTecnologia(ana, forja).
desarrollaTecnologia(ana, emplumado).
desarrollaTecnologia(ana, laminas).

desarrollaTecnologia(beto, herreria).
desarrollaTecnologia(beto, forja).
desarrollaTecnologia(beto, fundicion).

desarrollaTecnologia(carola, herreria).

desarrollaTecnologia(dimitri, herreria).
desarrollaTecnologia(dimitri, fundicion).

% 2. Es experto en metales cuando desarrollaTecnologia(herreria, forja, fundicion) o desarrollaTecnologia(herreria, forja) y civilizacion(romanos) 
esExpertoEnMetales(Jugador):-
    desarrollaTecnologia(Jugador, herreria),
    desarrollaTecnologia(Jugador, forja),
    desarrollaTecnologia(Jugador, fundicion).
esExpertoEnMetales(Jugador):-
    desarrollaTecnologia(Jugador, herreria),
    desarrollaTecnologia(Jugador, forja),
    juegaPartida(Jugador, romanos).

% 3. civilizacionPopular: cuando? → +1 jugador la eligen 
cantidadJugadores(Civilizacion, Cantidad):-
    juegaPartida(Jugador, Civilizacion),
    findall(Jugador, juegaPartida(Jugadores, Civilizacion), Jugadores), 
    length(Jugadores, Cantidad).
civilizacionPopular(Civilizacion):- 
    cantidadJugadores(Civilizacion, Cantidad), 
    Cantidad > 1.

% 4. Una tecnologia tiene alcance global si a nadie le falta desarrollarla
tieneAlcanceGlobal(Tecnologia):- 
    desarrollaTecnologia(_, Tecnologia),
    forall(jugador(Jugador), desarrollaTecnologia(Jugador, Tecnologia)).

% 5. civilizacionLider: cuando? → la civilizacion alcanzo TODAS (5) las tecnologias; esto es, para una misma civilizacion, sumo las tecnologias de cada jugador y si completan todas las tecnologias => es lider. 
% listaTotalTecnologias:
listaTotalTecnologias(ListaTotalTecno):- 
    findall(Tecnologia, desarrollaTecnologia(_, Tecnologia), Tecnologias), 
    list_to_set(Tecnologias, ListaTotalTecno).
% lista de Tecnologias por civilizacion: 
listaTecnologias(Civilizacion, ListaTecno):- 
    civilizacion(Civilizacion),
    findall(Tecnologia, (juegaPartida(Jugador, Civilizacion), desarrollaTecnologia(Jugador, Tecnologia)), Tecnologias), 
    list_to_set(Tecnologias, ListaTecno).
% Modelando si una civilizacion es lider:
civilizacionLider(Civilizacion):- 
    civilizacion(Civilizacion),
    forall(listaTecnologias(Civilizacion, Tecnologias), listaTotalTecnologias(Tecnologias)).

% 6. Modelar lo necesario para representar las distintas unidades de cada jugador

% Las unidades que existen son:
% los campeones (con vida de 1 a 100)
% los jinetes (que los puede haber a caballo o a camello)
% los piqueros que tienen un nivel de 1 a 3, y pueden o no tener escudo

% Modelamos las unidades
unidad(campeon).
unidad(jinete).
unidad(piquero).

campeon(Vida) :- between(1, 100, Vida).

jinete(caballo).
jinete(camallo).

piquero(1, conEscudo).
piquero(2, conEscudo).
piquero(3, conEscudo).
piquero(1, sinEscudo).
piquero(2, sinEscudo).
piquero(3, sinEscudo).

% Modelamos las unidades que tiene cada jugador
unidadQueTieneJugador(ana, jinete(caballo)).
unidadQueTieneJugador(ana, piquero(1, conEscudo)).
unidadQueTieneJugador(ana, piquero(2, sinEscudo)).

unidadQueTieneJugador(beto, campeon(100)).
unidadQueTieneJugador(beto, campeon(80)).
unidadQueTieneJugador(beto, piquero(1, conEscudo)).
unidadQueTieneJugador(beto, jinete(camello)).

unidadQueTieneJugador(carola, piquero(3, sinEscudo)).
unidadQueTieneJugador(carola, piquero(2, conEscudo)).

% 7. Conocer la unidad con mas vida que tiene un jugador

% Modelamos las vidas de las unidades
vidaUnidad(jinete(camello), 80).
vidaUnidad(jinete(caballo), 90).

vidaUnidad(campeon(Vida), Vida).

vidaUnidad(piquero(1, sinEscudo), 50).
vidaUnidad(piquero(2, sinEscudo), 65).
vidaUnidad(piquero(3, sinEscudo), 70).
% piqueros con escudo tienen un 10% mas de vida que los sin escudos
vidaUnidad(piquero(1, conEscudo), 55).
vidaUnidad(piquero(2, conEscudo), 71.5).
vidaUnidad(piquero(3, conEscudo), 77).

% Encontramos la mayorr vida de una unidad que tiene un jugador
vidaUnidadJugador(Jugador, VidaMax) :-
    jugador(Jugador),
    findall(Vida, (unidadQueTieneJugador(Jugador, Unidad), vidaUnidad(Unidad, Vida)), Vidas),
    max_member(VidaMax, Vidas).

% Encontramos la unidad con mas vida que tiene un jugador
unidadConMasVida(Jugador, Unidad) :-
    unidadQueTieneJugador(Jugador, Unidad),
    forall(vidaUnidadJugador(Jugador, Vida), vidaUnidad(Unidad, Vida)).
    
% 8. Queremos saber si una unidad le gana a otra. Las unidades tienen una ventaja por tipo sobre otras.

% Cualquier jinete le gana a cualquier campeon
leGanaA(jinete(_), campeon(_)).

% Cualquier campeon le gana a cualquier piquero
leGanaA(campeon(_), piquero(_, _)).

% Cualquier piquero le gana a cualquier jinete
leGanaA(piquero(_, _), jinete(_)).

% jinetes a camello le ganan a los a caballo
leGanaA(jinete(camello), jinete(caballo)).

% En caso de que no exista ventaja entre las unidades, se compara la vida (el de mayor vida gana)
unidadLeGanaAOtra(Unidad1, Unidad2) :- leGanaA(Unidad1, Unidad2).
unidadLeGanaAOtra(Unidad1, Unidad2) :- 
    vidaUnidad(Unidad1, Vida1),
    vidaUnidad(Unidad2, Vida2),
    Vida1 > Vida2.

% 9. Saber si un jugador puede sobrevivir a un asedio

cantidadPiquerosConSinEscudo(Jugador, ConSinEscudo, Cantidad):- 
    jugador(Jugador),
    findall(piquero(_, ConSinEscudo), unidadQueTieneJugador(Jugador, piquero(_, ConSinEscudo)), Piqueros),
    length(Piqueros, Cantidad).

% Obtenemos la cantidad de piqueros con escudo que tiene un jugador
piquerosConEscudo(Jugador, Cantidad) :-
    cantidadPiquerosConSinEscudo(Jugador, conEscudo, Cantidad).

% Obtenemos la cantidad de piqueros sin escudo que tiene un jugador
piquerosSinEscudo(Jugador, Cantidad) :-
    cantidadPiquerosConSinEscudo(Jugador, sinEscudo, Cantidad).

% Un jugador puede sobrevivir a un asedio si tiene mas piqueros con escudo que sin escudo
puedeSobrevivirAsedio(Jugador) :-
    jugador(Jugador),
    piquerosConEscudo(Jugador, CantidadConEscudo),
    piquerosSinEscudo(Jugador, CantidadSinEscudo),
    CantidadConEscudo > CantidadSinEscudo.

% 10. Arbol de tecnologias
% a. Modelando arbol de tecnologias utilizando hechos
% Notacion: dependeDe(tecnologiaDependiente, tecnologiaSinDependencia).
% Arbol A:
% nivel 1 del arbol
dependeDe(emplumado, herreria). 
dependeDe(forja, herreria).
dependeDe(laminas, herreria).
% nivel 2 del arbol:
dependeDe(pun, emplumado).
dependeDe(fundicion, forja).
dependeDe(mall, laminas).
% nivel 3 del arbol:
dependeDe(horno, fundicion).
dependeDe(plac, mall).

% Arbol B:
% nivel 1 del arbol: 
dependeDe(colle, molino).
% nivel 2 del arbol:
dependeDe(arad, colle).

% b. puedeDesarrollarTecnologia → se da cuando cumplen con las dependencias directas e indirectas
puedeDesarrollarTecnologia(Jugador, Tecnologia):-
    jugador(Jugador),
    not(desarrollaTecnologia(Jugador, Tecnologia)),
    forall(dependeDe(Tecnologia, TecnoDependiente), desarrollaTecnologia(Jugador, TecnoDependiente)).
