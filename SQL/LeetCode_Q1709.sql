/*1709. Biggest Window Between Visits
Description - 
Assume today's date is '2021-1-1'.

Write an SQL query that will, for each user_id, find out the largest window of days between each visit and the one right after it (or today if you are considering the last visit).

Return the result table ordered by user_id.

The query result format is in the following example:


UserVisits table:
+---------+------------+
| user_id | visit_date |
+---------+------------+
| 1       | 2020-11-28 |
| 1       | 2020-10-20 |
| 1       | 2020-12-3  |
| 2       | 2020-10-5  |
| 2       | 2020-12-9  |
| 3       | 2020-11-11 |
+---------+------------+
Result table:
+---------+---------------+
| user_id | biggest_window|
+---------+---------------+
| 1       | 39            |
| 2       | 65            |
| 3       | 51            |
+---------+---------------+
For the first user, the windows in question are between dates:
    - 2020-10-20 and 2020-11-28 with a total of 39 days.
    - 2020-11-28 and 2020-12-3 with a total of 5 days.
    - 2020-12-3 and 2021-1-1 with a total of 29 days.
Making the biggest window the one with 39 days.
For the second user, the windows in question are between dates:
    - 2020-10-5 and 2020-12-9 with a total of 65 days.
    - 2020-12-9 and 2021-1-1 with a total of 23 days.
Making the biggest window the one with 65 days.
For the third user, the only window in question is between dates 2020-11-11 and 2021-1-1 with a total of 51 days.
*/

CREATE TABLE UserVisits_1709 (			
    user_id INT,			
    visit_date DATE			
);			
			
INSERT INTO UserVisits_1709 (user_id, visit_date) VALUES			
(1, '2020-11-28'),			
(1, '2020-10-20'),			
(1, '2020-12-03'),			
(2, '2020-10-05'),			
(2, '2020-12-09'),			
(3, '2020-11-11');			
			
Select * from UserVisits_1709;			

SELECT user_id, MAX(duration)
FROM
(SELECT user_id, visit_date, ABS(DATEDIFF(coalesce(lead_date, '2021-01-01'), visit_date)) duration
FROM
(SELECT *
, LEAD(visit_date) over(partition by user_id) as lead_date
FROM UserVisits_1709) T1) tbl
GROUP BY user_id ;

(SELECT user_id, visit_date, ABS(DATEDIFF(coalesce(lead_date, '2021-01-01'), visit_date)) duration
FROM
(SELECT *
, LEAD(visit_date) over(partition by user_id) as lead_date
FROM UserVisits_1709) T1);