-- Остановки
INSERT INTO "public"."stops" ("name") VALUES 
('ул. Пушкина'),
('ул. Ленина'),
('ост. Попова');

-- Маршруты
INSERT INTO "public"."routes" ("name", "begin_stop_id", "end_stop_id") VALUES
('Автобус №21', (SELECT id FROM stops WHERE name = 'ул. Пушкина'), (SELECT id FROM stops WHERE name = 'ост. Попова')),
('Автобус №11', (SELECT id FROM stops WHERE name = 'ул. Пушкина'), (SELECT id FROM stops WHERE name = 'ул. Ленина'));


-- Остановки для маршрута "Автобус №11"
INSERT INTO "public"."route_stops" ("route_id", "stop_id", "position", "direction", "arrival") VALUES
((SELECT id FROM routes WHERE name = 'Автобус №11'), (SELECT id FROM stops WHERE name = 'ул. Пушкина'), 0, 0, '20:00:00'),
((SELECT id FROM routes WHERE name = 'Автобус №11'), (SELECT id FROM stops WHERE name = 'ул. Ленина'), 1, 0, '20:15:00'),
((SELECT id FROM routes WHERE name = 'Автобус №11'), (SELECT id FROM stops WHERE name = 'ул. Ленина'), 0, 1, '20:30:00'),
((SELECT id FROM routes WHERE name = 'Автобус №11'), (SELECT id FROM stops WHERE name = 'ул. Пушкина'), 1, 1, '20:45:00');


INSERT INTO "public"."route_stops" ("route_id", "stop_id", "position", "direction", "arrival") VALUES
((SELECT id FROM routes WHERE name = 'Автобус №21'), (SELECT id FROM stops WHERE name = 'ул. Пушкина'), 0, 0, '20:05:00'),
((SELECT id FROM routes WHERE name = 'Автобус №21'), (SELECT id FROM stops WHERE name = 'ул. Ленина'), 1, 0, '20:20:00'),
((SELECT id FROM routes WHERE name = 'Автобус №21'), (SELECT id FROM stops WHERE name = 'ост. Попова'), 2, 0, '20:35:00'),
((SELECT id FROM routes WHERE name = 'Автобус №21'), (SELECT id FROM stops WHERE name = 'ост. Попова'), 0, 1, '20:45:00'),
((SELECT id FROM routes WHERE name = 'Автобус №21'), (SELECT id FROM stops WHERE name = 'ул. Пушкина'), 1, 1, '21:10:00');