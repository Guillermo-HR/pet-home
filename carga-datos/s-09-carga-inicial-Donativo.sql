--@Autor(es): Aburto López Roberto, Hernández Ruiz de Esparza Guillermo
--@Fecha creación: 14/11/2024
--@Descripción: Carga inicial de datos tabla 

PROMPT ========================================================
PROMPT Carga datos donaciones
PROMPT ========================================================

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2020-11-07', 'YYYY-MM-DD'), 500.00, 3);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2021-02-15', 'YYYY-MM-DD'), 750.00, 5);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2021-07-20', 'YYYY-MM-DD'), 1200.00, 8);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2021-11-10', 'YYYY-MM-DD'), 300.00, 3);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2022-03-25', 'YYYY-MM-DD'), 950.00, 12);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2022-06-10', 'YYYY-MM-DD'), 1500.00, 8);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2022-09-18', 'YYYY-MM-DD'), 600.00, 15);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 400.00, 20);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2023-04-10', 'YYYY-MM-DD'), 2000.00, 8);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2023-07-30', 'YYYY-MM-DD'), 700.00, 10);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 1300.00, 5);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 800.00, 12);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2024-04-15', 'YYYY-MM-DD'), 950.00, 25);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2024-05-22', 'YYYY-MM-DD'), 1000.00, 3);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 650.00, 20);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2024-08-18', 'YYYY-MM-DD'), 1200.00, 5);

INSERT INTO donativo (donativo_id, fecha, monto, cliente_id)
VALUES (donativo_seq.NEXTVAL, TO_DATE('2024-09-15', 'YYYY-MM-DD'), 500.00, 8);

COMMIT;