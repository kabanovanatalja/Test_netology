WITH joined AS (
    SELECT o.*,
           v.datetime AS visit_date,
           ROW_NUMBER() OVER (
               PARTITION BY o.user_id, o.datetime
               ORDER BY ABS(EXTRACT(EPOCH FROM (v.datetime::timestamp - o.datetime::timestamp))),
                        v.datetime
           ) AS rn
    FROM orders o
    LEFT JOIN visits v ON v.user_id = o.user_id
)
SELECT user_id, datetime AS order_date, visit_date AS nearest_visit
FROM joined
WHERE rn = 1;