-- with men_and_women_sum_points as(
-- with men_and_women_points as (
--   select * from get_points_gyms_wars(1,4)
--   UNION ALL
--   select * from  get_points_gyms_wars(2,4)
-- ) select sum(points) as sum_points, gym_id from men_and_women_points group by gym_id)
-- select (rank() over (ORDER BY sum_points DESC)) as rrank, sum_points, gym_id from men_and_women_sum_points order by rrank;
--
--


CREATE OR REPLACE FUNCTION get_gym_points_gyms_wars(integer)
RETURNS TABLE(rank bigint, points numeric, gym_id integer)
AS $function$
with men_and_women_sum_points as(
with men_and_women_points as (
  select * from get_points_gyms_wars(1,$1)
  UNION ALL
  select * from  get_points_gyms_wars(2,$1)
) select sum(points) as sum_points, gym_id from men_and_women_points group by gym_id)
select (rank() over (ORDER BY sum_points DESC)) as rrank, sum_points, gym_id from men_and_women_sum_points order by rrank;
$function$
LANGUAGE sql;








  CREATE OR REPLACE FUNCTION get_points_gyms_wars(integer, integer)
  RETURNS TABLE(rank bigint, points bigint,challenge_time int, user_id integer, gym_id integer)
  AS $function$

  with rank_sorted_time_by_gender_and_challenge_id as (
    with sorted_time_by_gender_and_challenge_id as (
      select cs.id, cs.challenge_time, u.id as uid, u.gym_id
      from challenge_scores as cs
      inner join users as u on u.id = cs.user_id
      where u.gender = $1 and cs.challenge_id = $2
      order by cs.challenge_time DESC
    )
    select (rank() OVER (ORDER BY challenge_time DESC) - (select count(*) from sorted_time_by_gender_and_challenge_id ) + 10) AS POINTS, * from sorted_time_by_gender_and_challenge_id )
    select (rank() over (ORDER BY POINTS DESC)) as rrank, (ABS(POINTS)+POINTS)/2 as points, res.challenge_time AS REDUCED_POINTS, res.uid, res.gym_id  from rank_sorted_time_by_gender_and_challenge_id as res order by rrank;

    $function$
    LANGUAGE sql;
