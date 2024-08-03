% Civilizaciones y tecnologías 

% 1. Modelo de jugadores, civilizaciones y tecnologías 
% Datos: 
% - Personas: Ana, Beto, Carola, Dimitri, Elsa
% - Civilizaciones: romanos, incas,
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
juegaConCivilizacion(Jugador, Civilizacion):- jugador(Jugador), juegaPartida(Jugador, Civilizacion). 

habilidadTecnologica(Jugador, Tecnologia):- jugador(Jugador), desarrollaTecnologia(Jugador, Tecnologia).

% 2. esExperto en metales: cuando? → desarollaTecnologia(herreria, forja, fundicion) o civilizacion(romanos) 
esExpertoEnMetales(Jugador):- jugador(Jugador), desarrollaTecnologia(Jugador, [herreria, forja, fundicion]).
esExpertoEnMetales(Jugador):- jugador(Jugador), juegaPartida(Jugador, romanos).

% 3. civilizacionPopular: cuando? → +1 jugador la eligen 
civilizacionPopular(Civilizacion):- (length(juegaPartida(Civilizacion, _), cantidadJugadores), cantidadJugadores > 1).
% En proceso ↑