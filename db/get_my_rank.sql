WITH global_rank as (
  with global_score as (
    select user_id, sum(points) as score from trainings
    WHERE training_category_id = 3 AND created_at > '2016-03-31 22:00:00' AND created_at <= '2016-04-30 21:59:59'
    group by user_id
    order by score desc
  )
  SELECT user_id, score, rank() OVER (ORDER BY score DESC) FROM global_score
) select first_name, surname, rank, score, ((select MAX(rank) from global_rank) - rank + 1) as bonus, (score + (select MAX(rank) from global_rank)- rank + 1) as sum_points   from global_rank
inner join users on global_rank.user_id = users.id
order by score desc;



CREATE OR REPLACE FUNCTION get_rank_score(integer, timestamp without time zone, timestamp without time zone)
 RETURNS TABLE(user_id integer, rank bigint, score double precision, bonus bigint, sum_points double precision)
 AS $function$
 WITH global_rank as (
   with global_score as (
     select user_id, sum(points) as score from trainings
     WHERE (training_category_id = $1 or $1 is null)  AND created_at > $2 AND created_at <= $3
     group by user_id
     order by score desc
   )
   SELECT user_id, score, rank() OVER (ORDER BY score DESC) FROM global_score
 ) select user_id, rank, score, ((select MAX(rank) from global_rank) - rank + 1) as bonus, (score + (select MAX(rank) from global_rank)- rank + 1) as sum_points   from global_rank
 inner join users on global_rank.user_id = users.id
 order by score desc;

$function$
 LANGUAGE sql;


select * from periods where time_from <= current_date AND time_to >= current_date LIMIT 1;
select * from get_rank_score(8, '2016-02-29 00:00:00', '2016-04-30 00:00:00');


DROP FUNCTION get_statistics(integer, integer);

CREATE OR REPLACE FUNCTION get_statistics(integer, integer)
 RETURNS TABLE(
   user_id integer, score double precision,rank bigint, bonus bigint, sum_points double precision,
   score1 double precision,rank1 bigint, bonus1 bigint, sum_points1 double precision,
   score2 double precision,rank2 bigint, bonus2 bigint, sum_points2 double precision,
   score3 double precision,rank3 bigint, bonus3 bigint, sum_points3 double precision
 )
 AS $function$
   select
   XSUM.user_id, XSUM.score, XSUM.rank, XSUM.bonus, XSUM.sum_points,
   X1.score, X1.rank, X1.bonus, X1.sum_points,
   X2.score, X2.rank, X2.bonus, X2.sum_points,
   X3.score, X3.rank, X3.bonus, X3.sum_points from
   (select * from get_rank_score($1, (select time_from from periods where id = $2), (select time_to from periods where id = $2))) AS XSUM
   LEFT OUTER JOIN
   (select * from get_rank_score($1, (select time_from_1 from periods where id = $2), (select time_to_1 from periods where id = $2))) AS X1
   ON XSUM.user_id = X1.user_id
   LEFT OUTER JOIN
   (select * from get_rank_score($1, (select time_from_2 from periods where id = $2), (select time_to_2 from periods where id = $2))) AS X2
   ON XSUM.user_id = X2.user_id
  LEFT OUTER JOIN
   (select * from get_rank_score($1, (select time_from_3 from periods where id = $2), (select time_to_3 from periods where id = $2))) AS X3
   ON XSUM.user_id = X3.user_id
   ORDER BY XSUM.score DESC;


$function$
 LANGUAGE sql;