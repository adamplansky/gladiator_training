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
    UNION ALL
    select * from  get_points_mixes_gyms_wars($1)

  ) select sum(points) as sum_points, gym_id from men_and_women_points group by gym_id)
select (rank() over (ORDER BY sum_points DESC)) as rrank, sum_points, gym_id from men_and_women_sum_points order by rrank;
$function$
LANGUAGE sql;



--SELECT * FROM challenge_scores where user_id IN ( select id from users limit 10);

CREATE OR REPLACE FUNCTION get_points_mixes_gyms_wars(integer)
RETURNS TABLE(rank bigint, points bigint,challenge_time int, team_id integer, gym_id integer)
AS $function$

with rank_sorted_time_by_gender_and_challenge_id as (
  with sorted_time_by_gender_and_challenge_id as (
    select cs.id, cs.challenge_time, team_id as team_id, u.gym_id
    from challenge_scores as cs
    inner join users as u on u.id = cs.user_id
    where cs.challenge_id = $1 and team_id IS NOT NULL
    order by cs.challenge_time DESC
  )
  select (rank() OVER (ORDER BY challenge_time DESC) - (select count(*) from sorted_time_by_gender_and_challenge_id ) + 10) AS POINTS, * from sorted_time_by_gender_and_challenge_id )
  select (rank() over (ORDER BY POINTS DESC)) as rrank, (ABS(POINTS)+POINTS)/2+1 as points, res.challenge_time AS REDUCED_POINTS, res.team_id, res.gym_id  from rank_sorted_time_by_gender_and_challenge_id as res order by rrank;

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
      where u.gender = $1 and cs.challenge_id = $2 and team_id IS NULL
      order by cs.challenge_time DESC
    )
    select (rank() OVER (ORDER BY challenge_time DESC) - (select count(*) from sorted_time_by_gender_and_challenge_id ) + 10) AS POINTS, * from sorted_time_by_gender_and_challenge_id )
    select (rank() over (ORDER BY POINTS DESC)) as rrank, (ABS(POINTS)+POINTS)/2+1 as points, res.challenge_time AS REDUCED_POINTS, res.uid, res.gym_id  from rank_sorted_time_by_gender_and_challenge_id as res order by rrank;

    $function$
    LANGUAGE sql;


------------

CREATE OR REPLACE FUNCTION get_all_points_gyms_wars(integer)
RETURNS TABLE(rank bigint, points bigint,challenge_time int, user_id integer, gym_id integer)
AS $function$

with x as (
with mega_super_query as(
    with count_challenge_scores_by_gender as (
      select count(*) as cnt, challenge_id
      from challenge_scores
      inner join users ON users.id = challenge_scores.user_id
      where gender = $1
      group by challenge_id
    )
    SELECT
        Rank() over (Partition by cs.challenge_id Order by cs.challenge_time, user_id, cs.challenge_id) as ranks,
        cs.challenge_time, cs.challenge_id, user_id, ccs.cnt
    FROM
        challenge_scores as cs
    inner join users ON users.id = cs.user_id
    inner join count_challenge_scores_by_gender as ccs ON ccs.challenge_id = cs.challenge_id
    where gender = $1
    Group By
        cs.challenge_time, user_id, cs.challenge_id, challenge_time, ccs.cnt
    Order by
        ranks asc)
select (ranks - (cnt ) + 10) AS POINTS, * from mega_super_query )
select (rank() over (ORDER BY POINTS DESC)) as rrank, (ABS(POINTS)+POINTS)/2+1 as points, res.challenge_time AS REDUCED_POINTS, res.user_id, u.gym_id from x as res
inner join users as u
on u.id = res.user_id
order by rrank

  $function$
  LANGUAGE sql;




CREATE OR REPLACE VIEW leaderboard_men AS
  with x as (
  with mega_super_query as(
      with count_challenge_scores_by_gender as (
        select count(*) as cnt, challenge_id
        from challenge_scores
        inner join users ON users.id = challenge_scores.user_id
        where gender = 1 and team_id IS NULL
        group by challenge_id
      )
      SELECT
          Rank() over (Partition by cs.challenge_id Order by cs.challenge_time DESC, user_id, cs.challenge_id ) as ranks,
          cs.challenge_time, cs.challenge_id, user_id, ccs.cnt
      FROM
          challenge_scores as cs
      inner join users ON users.id = cs.user_id
      inner join count_challenge_scores_by_gender as ccs ON ccs.challenge_id = cs.challenge_id
      where gender = 1 and team_id IS NULL
      Group By
          cs.challenge_time, user_id, cs.challenge_id, challenge_time, ccs.cnt
      Order by
          ranks)
  select (ranks - (cnt ) + 10) AS POINTS, * from mega_super_query )
  select (rank() over (ORDER BY res.POINTS DESC)) as rrank, (ABS(res.POINTS)+res.POINTS)/2+1 as points, res.challenge_time AS REDUCED_POINTS, res.user_id, u.gym_id, res.challenge_id, challenges.season_id
  from x as res
  inner join users as u on u.id = res.user_id
  inner join challenges on res.challenge_id = challenges.id
  order by rrank;


  CREATE OR REPLACE VIEW leaderboard_women AS
    with x as (
    with mega_super_query as(
        with count_challenge_scores_by_gender as (
          select count(*) as cnt, challenge_id
          from challenge_scores
          inner join users ON users.id = challenge_scores.user_id
          where gender = 2 and team_id IS NULL
          group by challenge_id
        )
        SELECT
            Rank() over (Partition by cs.challenge_id Order by cs.challenge_time DESC, user_id, cs.challenge_id) as ranks,
            cs.challenge_time, cs.challenge_id, user_id, ccs.cnt
        FROM
            challenge_scores as cs
        inner join users ON users.id = cs.user_id
        inner join count_challenge_scores_by_gender as ccs ON ccs.challenge_id = cs.challenge_id
        where gender = 2 and team_id IS NULL
        Group By
            cs.challenge_time, user_id, cs.challenge_id, challenge_time, ccs.cnt
        Order by
            ranks)
    select (ranks - (cnt ) + 10) AS POINTS, * from mega_super_query )
    select (rank() over (ORDER BY res.POINTS DESC)) as rrank, (ABS(res.POINTS)+res.POINTS)/2+1 as points, res.challenge_time AS REDUCED_POINTS, res.user_id, u.gym_id, res.challenge_id, challenges.season_id
    from x as res
    inner join users as u on u.id = res.user_id
    inner join challenges on res.challenge_id = challenges.id
    order by rrank;


    CREATE OR REPLACE VIEW leaderboard_mixes AS
      with x as (
      with mega_super_query as(
          with count_challenge_scores_by_gender as (
            select count(*) as cnt, challenge_id
            from challenge_scores
            inner join users ON users.id = challenge_scores.user_id
            where team_id IS NOT NULL
            group by challenge_id
          )
          SELECT
              Rank() over (Partition by cs.challenge_id Order by cs.challenge_time DESC, team_id, cs.challenge_id) as ranks,
              cs.challenge_time, cs.challenge_id, team_id, ccs.cnt
          FROM
              challenge_scores as cs
          inner join users ON users.id = cs.user_id
          inner join count_challenge_scores_by_gender as ccs ON ccs.challenge_id = cs.challenge_id
          where team_id IS NOT NULL
          Group By
              cs.challenge_time, team_id, cs.challenge_id, challenge_time, ccs.cnt
          Order by
              ranks )
      select (ranks - (cnt ) + 10) AS POINTS, * from mega_super_query )
      select (rank() over (ORDER BY res.POINTS DESC)) as rrank, (ABS(res.POINTS)+res.POINTS)/2+1 as points, res.challenge_time AS REDUCED_POINTS, res.team_id, u.gym_id, res.challenge_id, challenges.season_id
      from x as res
      inner join teams as u on u.id = res.team_id
      inner join challenges on res.challenge_id = challenges.id
      order by rrank;









      CREATE OR REPLACE FUNCTION get_full_leaderboard_mixes_gyms_wars(integer)
      RETURNS TABLE(rank bigint, points numeric, team_id integer, gym_id integer)
      AS $function$
        select rank() over (ORDER BY sum(points) DESC) as rrank, sum(points), team_id, gym_id
        from leaderboard_mixes
        where season_id = $1
        group by team_id, gym_id
        order by sum desc;
      $function$
      LANGUAGE sql;




CREATE OR REPLACE FUNCTION get_full_leaderboard_men_gyms_wars(integer)
RETURNS TABLE(rank bigint, points numeric, user_id integer, gym_id integer)
AS $function$
  select rank() over (ORDER BY sum(points) DESC) as rrank, sum(points), user_id, gym_id
  from leaderboard_men
  where season_id = $1
  group by user_id, gym_id
  order by sum desc;
$function$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_full_leaderboard_women_gyms_wars(integer)
RETURNS TABLE(rank bigint, points numeric, user_id integer, gym_id integer)
AS $function$
  select rank() over (ORDER BY sum(points) DESC) as rrank, sum(points), user_id, gym_id
  from leaderboard_women
  where season_id = $1
  group by user_id, gym_id
  order by sum desc;
$function$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION get_full_leaderboard_gyms_wars(integer)
RETURNS TABLE(rank bigint, points numeric, gym_id integer)
AS $function$
with full_men_and_women_points as (
  select * from get_full_leaderboard_women_gyms_wars($1)
  UNION ALL
  select * from get_full_leaderboard_men_gyms_wars($1)
  UNION ALL
  select * from get_full_leaderboard_mixes_gyms_wars($1)

) select rank() over (ORDER BY sum(points) DESC) as rrank, sum(points) as sum_points, gym_id from full_men_and_women_points group by gym_id;
$function$
LANGUAGE sql;
