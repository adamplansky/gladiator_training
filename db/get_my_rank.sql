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
 ) select user_id, rank, score, ((select count(rank) from global_rank) - rank + 1) as bonus, (score + (select count(rank) from global_rank)- rank + 1) as sum_points   from global_rank
 inner join users on global_rank.user_id = users.id
 order by score desc;

$function$
 LANGUAGE sql;


select * from periods where time_from <= current_date AND time_to >= current_date LIMIT 1;
select * from get_rank_score(8, '2016-02-29 00:00:00', '2016-04-30 00:00:00');



CREATE OR REPLACE FUNCTION get_statistics(integer, integer)
 RETURNS TABLE(user_id integer, score double precision,rank bigint, bonus bigint, sum_points double precision, score1 double precision,rank1 bigint, bonus1 bigint, sum_points1 double precision, score2 double precision,rank2 bigint, bonus2 bigint, sum_points2 double precision, score3 double precision,rank3 bigint, bonus3 bigint, sum_points3 double precision)
 AS $function$
   select
   XSUM.user_id, coalesce( XSUM.score, 0), XSUM.rank, XSUM.bonus, coalesce( XSUM.sum_points, 0),
   coalesce( X1.score, 0), X1.rank, X1.bonus, coalesce( X1.sum_points, 0),
   coalesce( X2.score, 0), X2.rank, X2.bonus, coalesce( X2.sum_points, 0),
   coalesce( X3.score, 0), X3.rank, X3.bonus, coalesce( X3.sum_points, 0) from
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


select * from trainings where training_category_id IN (select id from training_categories where id = 3 OR id = 4);

CREATE OR REPLACE FUNCTION get_all_statistics(integer)
  RETURNS TABLE(
    user_id integer, score double precision,rank bigint, bonus bigint, sum_points double precision,
    score1 double precision,rank1 bigint, bonus1 bigint, sum_points1 double precision,
    score2 double precision,rank2 bigint, bonus2 bigint, sum_points2 double precision,
    score3 double precision,rank3 bigint, bonus3 bigint, sum_points3 double precision
  )
 AS
$BODY$
DECLARE
    r integer;
BEGIN
    FOR r IN
        SELECT id FROM training_categories
    LOOP
        --raise notice 'Value: %', r;
        RETURN QUERY select * from get_statistics(r,$1); -- return current row of SELECT
    END LOOP;
    RETURN;
END
$BODY$
LANGUAGE plpgsql;







CREATE OR REPLACE FUNCTION get_statistics_overall(integer)
 RETURNS TABLE(
   user_id integer,
    score double precision,rank bigint, bonus numeric, sum_points double precision,
    score1 double precision,rank1 bigint, bonus1 numeric, sum_points1 double precision,
    score2 double precision,rank2 bigint, bonus2 numeric, sum_points2 double precision,
    score3 double precision,rank3 bigint, bonus3 numeric, sum_points3 double precision

 )
 AS $function$
 select user_id,
 sum(score)  as score,  rank() OVER (ORDER BY sum(sum_points) DESC),  sum(bonus)  as bonus,  sum(sum_points)  as sum_points,
 sum(score1) as score1, rank() OVER (ORDER BY sum(sum_points1) DESC) as rank1, sum(bonus1) as bonus1, sum(sum_points1) as sum_points1,
 sum(score2) as score2, rank() OVER (ORDER BY sum(sum_points2) DESC) as rank2, sum(bonus2) as bonus2, sum(sum_points2) as sum_points2,
 sum(score3) as score3, rank() OVER (ORDER BY sum(sum_points3) DESC) as rank3, sum(bonus3) as bonus3, sum(sum_points3) as sum_points3

 from get_all_statistics($1) group by user_id order by sum(sum_points) DESC;
$function$
LANGUAGE sql;












