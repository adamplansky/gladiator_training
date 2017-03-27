
select (rank() OVER (ORDER BY challenge_time DESC))-1 AS SCORE, challenge_scores.challenge_time, user_id, challenge_id
from statistics
inner join users on challenge_scores.user_id = users.id
where challenge_id = 2 AND users.gender = 1
ORDER BY challenge_time;


select (rank() OVER (ORDER BY challenge_time DESC))-1 AS SCORE, challenge_scores.challenge_time, user_id, challenge_id
from challenge_scores
inner join users on challenge_scores.user_id = users.id
where challenge_id = 2 AND users.gender = 1
ORDER BY challenge_time;

with g_test_2 as (
with g_test1 as (
  with g_test as (
    select sum(points) AS SUMX , user_id
    from trainings
    inner join users as u on u.id = trainings.user_id
    group by user_id
    order by SUMX DESC
  ) select (rank() OVER (ORDER BY SUMX ) ) AS rrank, g_test.SUMX, u.first_name, u.surname from g_test
  inner join users as u ON g_test.user_id = u.id order by SUMX DESC)
  select (rrank - (select count(*) from g_test1 ) + 10) AS POINTS, *  from g_test1)
  select (ABS(POINTS)+POINTS)/2, * from g_test_2;


  -- (ABS(@test)+@test)/2 as result
