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
jugador(elsa).

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

% Asociando jugador, civilizacion y tecnologias:
juegaConCivilizacion(Jugador, Civilizacion):- juegaPartida(Jugador, Civilizacion). 
habilidadTecnologica(Jugador, Tecnologia):- desarrollaTecnologia(Jugador, Tecnologia).

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
cantidadJugadores(Civilizacion, Cantidad):- findall(Jugador, juegaPartida(Jugadores, Civilizacion), Jugadores), length(Jugadores, Cantidad).
civilizacionPopular(Civilizacion):- cantidadJugadores(Civilizacion, Cantidad), Cantidad > 1.

% 5. civilizacionLider: cuando? → la civilizacion alcanzo TODAS (5) las tecnologias; esto es, para una misma civilizacion, sumo las tecnologias de cada jugador y si completan todas las tecnologias => es lider. 
% listaTotalTecnologias:
listaTotalTecnologias(ListaTotalTecno):- findall(Tecnologia, desarrollaTecnologia(_, Tecnologia), Tecnologias), list_to_set(Tecnologias, ListaTotalTecno).
% lista de Tecnologias por civilizacion: 
listaTecnologias(Civilizacion, ListaTecno):- findall(Tecnologia, (juegaPartida(Jugador, Civilizacion), desarrollaTecnologia(Jugador, Tecnologia)), Tecnologias), list_to_set(Tecnologias, ListaTecno).
% Modelando si una civilizacion es lider:
civilizacionLider(Civilizacion):- listaTecnologias(Civilizacion, TecnoCivilizacion), listaTotalTecnologias(TotalTecnos), subset(TecnoCivilizacion, TotalTecnos).


