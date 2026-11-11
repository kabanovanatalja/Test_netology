WITH bounds AS (
    SELECT MAX(date::date) AS end_period,
    	(MAX(date::date) - INTERVAL '1 months') as begin_period
    FROM log
), --последний месяц
weeks AS (
    -- все недели окна с шагом 7 дней от начала периода
    SELECT gs::date AS week_start,
           (gs + INTERVAL '6 days')::date AS week_end
    FROM bounds b,
         generate_series(b.begin_period, b.end_period, '7 days'::interval) AS gs   
    WHERE gs + INTERVAL '6 days' <= b.end_period      
),
week_counts AS (
    -- визиты пользователей по периодам из weeks
    SELECT l.user_id,
           w.week_start,
           COUNT(*) AS visits
    FROM log l
    CROSS JOIN bounds b
    JOIN weeks w
      ON l.date::date BETWEEN w.week_start AND w.week_end
    WHERE l.date::date >= b.begin_period
    GROUP BY l.user_id, w.week_start
)
SELECT user_id
FROM weeks w
LEFT JOIN week_counts wc
       ON wc.week_start = w.week_start
GROUP BY user_id
HAVING MIN(visits) >= 2;