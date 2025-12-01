--Pablo Iglesias Rodrigo
--Examen 24-11-2025. Tipo 2.
--Inserts.


--Partidos:
INSERT INTO Parcial_Partido VALUES ('Partido Aurora', 'PAU', 15200);
INSERT INTO Parcial_Partido VALUES ('Unidad Popular', 'UP', 9800);
INSERT INTO Parcial_Partido VALUES ('Voz Ciudadana', 'VC', 7200);
INSERT INTO Parcial_Partido VALUES ('Partido Aurora', 'PAU', 15200);
INSERT INTO Parcial_Partido VALUES ('Los Milagros', 'ML', 5100);
INSERT INTO Parcial_Partido VALUES ('Fuerza Social', 'FS', 4300);
INSERT INTO Parcial_Partido VALUES ('Renovación Nacional', 'RN', 6100);
INSERT INTO Parcial_Partido VALUES ('Democracia Verde', 'DV', 2800);
INSERT INTO Parcial_Partido VALUES ('Horizonte Ético', 'HE', 3500);
INSERT INTO Parcial_Partido VALUES ('Coalicion C', 'C', 1);

--Votantes:
INSERT INTO Parcial_Votante VALUES ('10000000Z', 'Alcanices', 'Si');
INSERT INTO Parcial_Votante VALUES ('10000000Y', 'Ceadea', 'No');
INSERT INTO Parcial_Votante VALUES ('10000000X', 'Pino', 'Si');
INSERT INTO Parcial_Votante VALUES ('10000003Z', 'Madrid', 'No');
INSERT INTO Parcial_Votante VALUES ('10000000A', 'Nuez', 'Si');
INSERT INTO Parcial_Votante VALUES ('10000000B', 'Villarino', 'No');
INSERT INTO Parcial_Votante VALUES ('10000000C', 'barcelona', 'Si');
INSERT INTO Parcial_Votante VALUES ('10000000D', 'Cerezal', 'Si');
INSERT INTO Parcial_Votante VALUES ('10000000E', 'Valdemoro', 'No');
INSERT INTO Parcial_Votante VALUES ('10000000F', 'Toledo', 'Si');

INSERT INTO Parcial_Votante VALUES ('10000000G', 'Alcanices', 'No');
INSERT INTO Parcial_Votante VALUES ('10000000H', 'Ferreruela', 'Si');
INSERT INTO Parcial_Votante VALUES ('10000000I', 'Alcanices', 'No');
INSERT INTO Parcial_Votante VALUES ('10000000J', 'Pobladura', 'Si');
INSERT INTO Parcial_Votante VALUES ('20000003Z', 'Alcanices', 'Si');
INSERT INTO Parcial_Votante VALUES ('10000000L', 'Rabanales', 'No');
INSERT INTO Parcial_Votante VALUES ('20000000A', 'Zamora', 'Si');
INSERT INTO Parcial_Votante VALUES ('10000000N', 'Grisuela', 'Si');
INSERT INTO Parcial_Votante VALUES ('30000000A', 'Pobladura', 'No');
INSERT INTO Parcial_Votante VALUES ('10000000P', 'Alcanices', 'Si');

INSERT INTO Parcial_Votante VALUES ('10000000Q', 'Alcanices', 'Si');
INSERT INTO Parcial_Votante VALUES ('20000000Q', 'Celex', 'Si');


--Politicos:
INSERT INTO Parcial_Politico VALUES ('10000000Z', 'Ale Alonso', 'PAU', 5200);
INSERT INTO Parcial_Politico VALUES ('10000000Y', 'Alvaro Macho', 'UP', 3100);
INSERT INTO Parcial_Politico VALUES ('10000000X', 'Andrea Dominguez', 'VC', 2200);
INSERT INTO Parcial_Politico VALUES ('10000003Z', 'Andrea Gonzalez', 'ML', 1800);
INSERT INTO Parcial_Politico VALUES ('10000000A', 'Andrea Trabazos', 'FS', 1500);
INSERT INTO Parcial_Politico VALUES ('10000000B', 'Andres Alvarez', 'RN', 2100);
INSERT INTO Parcial_Politico VALUES ('10000000C', 'Carla Calvo', 'DV', 900);
INSERT INTO Parcial_Politico VALUES ('10000000D', 'David Anton', 'HE', 1100);
INSERT INTO Parcial_Politico VALUES ('10000000E', 'Elena Paton', 'PAU', 4500);
INSERT INTO Parcial_Politico VALUES ('10000000F', 'Elia Hidalgo', 'UP', 2700);

INSERT INTO Parcial_Politico VALUES ('10000000G', 'Lucia Hortigon', 'VC', 1900);
INSERT INTO Parcial_Politico VALUES ('10000000H', 'Lucia Villalon', 'FS', 1400);
INSERT INTO Parcial_Politico VALUES ('10000000I', 'Lydia Martin', 'PAU', 5200);
INSERT INTO Parcial_Politico VALUES ('10000000J', 'Marcos Vaquero', 'UP', 3100);
INSERT INTO Parcial_Politico VALUES ('20000003Z', 'Marina Vicente', 'VC', 2200);
INSERT INTO Parcial_Politico VALUES ('10000000L', 'Mario Rivas', 'ML', 1800);
INSERT INTO Parcial_Politico VALUES ('20000000A', 'Markel Alonso', 'ML', 1500);
INSERT INTO Parcial_Politico VALUES ('10000000N', 'Nerea Cisneros', 'RN', 2100);
INSERT INTO Parcial_Politico VALUES ('30000000A', 'Nieves Manjon', 'ML', 900);
INSERT INTO Parcial_Politico VALUES ('10000000P', 'Pablo Iglesias', 'HE', 1100);

INSERT INTO Parcial_Politico VALUES ('10000000Q', 'Sonia Bota', 'PAU', 4500);
INSERT INTO Parcial_Politico VALUES ('20000000Q', 'Kakro', 'C', 1);

--Sondeos:
--21-11-2025
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('21-11-2025 10:00:00','DD-MM-YYYY HH24:MI:SS'), 'SigmaData', 'PAU', 15500);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('21-11-2025 10:00:00','DD-MM-YYYY HH24:MI:SS'), 'SigmaData', 'UP', 10200);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('21-11-2025 10:00:00','DD-MM-YYYY HH24:MI:SS'), 'SigmaData', 'VC', 7600);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('21-11-2025 10:00:00','DD-MM-YYYY HH24:MI:SS'), 'SigmaData', 'ML', 5200);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('21-11-2025 10:00:00','DD-MM-YYYY HH24:MI:SS'), 'SigmaData', 'FS', 4500);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('21-11-2025 10:00:00','DD-MM-YYYY HH24:MI:SS'), 'SigmaData', 'RN', 6300);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('21-11-2025 10:00:00','DD-MM-YYYY HH24:MI:SS'), 'SigmaData', 'DV', 3000);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('21-11-2025 10:00:00','DD-MM-YYYY HH24:MI:SS'), 'SigmaData', 'HE', 3700);

--22-11-2025
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('22-11-2025 18:20:00','DD-MM-YYYY HH24:MI:SS'), 'Instituto Vox', 'PAU', 15000);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('22-11-2025 18:20:00','DD-MM-YYYY HH24:MI:SS'), 'Instituto Vox', 'UP', 9700);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('22-11-2025 18:20:00','DD-MM-YYYY HH24:MI:SS'), 'Instituto Vox', 'VC', 7300);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('22-11-2025 18:20:00','DD-MM-YYYY HH24:MI:SS'), 'Instituto Vox', 'ML', 4900);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('22-11-2025 18:20:00','DD-MM-YYYY HH24:MI:SS'), 'Instituto Vox', 'FS', 4200);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('22-11-2025 18:20:00','DD-MM-YYYY HH24:MI:SS'), 'Instituto Vox', 'RN', 6000);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('22-11-2025 18:20:00','DD-MM-YYYY HH24:MI:SS'), 'Instituto Vox', 'DV', 2700);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('22-11-2025 18:20:00','DD-MM-YYYY HH24:MI:SS'), 'Instituto Vox', 'HE', 3500);

--23-11-2025
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('23-11-2025 09:45:00','DD-MM-YYYY HH24:MI:SS'), 'EcoStats', 'PAU', 15800);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('23-11-2025 09:45:00','DD-MM-YYYY HH24:MI:SS'), 'EcoStats', 'UP', 10000);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('23-11-2025 09:45:00','DD-MM-YYYY HH24:MI:SS'), 'EcoStats', 'VC', 7400);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('23-11-2025 09:45:00','DD-MM-YYYY HH24:MI:SS'), 'EcoStats', 'ML', 5100);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('23-11-2025 09:45:00','DD-MM-YYYY HH24:MI:SS'), 'EcoStats', 'FS', 4400);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('23-11-2025 09:45:00','DD-MM-YYYY HH24:MI:SS'), 'EcoStats', 'RN', 6200);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('23-11-2025 09:45:00','DD-MM-YYYY HH24:MI:SS'), 'EcoStats', 'DV', 2900);
INSERT INTO Parcial_Sondeo VALUES (TO_TIMESTAMP('23-11-2025 09:45:00','DD-MM-YYYY HH24:MI:SS'), 'EcoStats', 'HE', 3600);