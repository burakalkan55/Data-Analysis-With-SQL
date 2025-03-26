SELECT 
    skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary,  
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
GROUP BY 
    skills
HAVING 
    COUNT(skills_job_dim.job_id) > 1000  -- demand_count yerine COUNT(...) kullanıldı
ORDER BY demand_count DESC
LIMIT 10;
