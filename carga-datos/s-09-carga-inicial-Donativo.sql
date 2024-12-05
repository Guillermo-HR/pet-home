--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos donaciones
PROMPT ========================================================

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2020-11-07', 'YYYY-MM-DD'), 500, 3);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2021-02-15', 'YYYY-MM-DD'), 750, 5);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2021-07-20', 'YYYY-MM-DD'), 1200, 8);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2021-11-10', 'YYYY-MM-DD'), 300, 3);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2022-03-25', 'YYYY-MM-DD'), 950, 12);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2022-06-10', 'YYYY-MM-DD'), 1500, 8);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2022-09-18', 'YYYY-MM-DD'), 600, 15);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2023-01-01', 'YYYY-MM-DD'), 400, 20);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2023-04-10', 'YYYY-MM-DD'), 2000, 8);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2023-07-30', 'YYYY-MM-DD'), 700, 10);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2023-09-05', 'YYYY-MM-DD'), 1300, 5);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2024-01-20', 'YYYY-MM-DD'), 800, 12);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2024-04-15', 'YYYY-MM-DD'), 950, 25);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2024-05-22', 'YYYY-MM-DD'), 1000, 3);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2024-07-01', 'YYYY-MM-DD'), 650, 20);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2024-08-18', 'YYYY-MM-DD'), 1200, 5);

INSERT INTO donativo (fecha, monto, cliente_id)
VALUES (TO_DATE('2024-09-15', 'YYYY-MM-DD'), 500, 8);

COMMIT;