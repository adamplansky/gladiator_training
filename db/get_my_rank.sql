WITH global_rank as (
  with global_score as (
  select user_id, sum(points) as score from trainings group by user_id order by score desc
  )
  SELECT user_id, score, rank() OVER (ORDER BY score DESC) FROM global_score
) select * from global_rank;

