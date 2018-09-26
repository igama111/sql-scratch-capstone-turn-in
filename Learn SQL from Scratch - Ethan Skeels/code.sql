 --1.1
 SELECT * 
 FROM survey
 LIMIT 10;
 -------------------------------------------
 --1.2
SELECT question AS "Question", COUNT(DISTINCT user_id) AS "Number of Responses"
FROM survey
GROUP BY question;
-------------------------------------------
--2.1
SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;
-------------------------------------------
--2.2
SELECT number_of_pairs AS "Unique Pairs", COUNT(number_of_pairs) AS "Number of pairs", COUNT(DISTINCT purchase.user_id) AS "# purchases per number of pairs", ROUND(100 *  COUNT(DISTINCT purchase.user_id) / COUNT(number_of_pairs),0) AS "% people who buy glasses" 
FROM home_try_on
LEFT JOIN purchase ON home_try_on.user_id = purchase.user_id
GROUP BY number_of_pairs;
-------------------------------------------
--2.3
SELECT quiz.user_id,
	CASE WHEN home_try_on.user_id IS NOT NULL = 1 THEN "Yes" ELSE "No" END AS "User try at home?",home_try_on.number_of_pairs AS "Number of pairs",
  CASE WHEN purchase.user_id IS NOT NULL = 1 THEN "Yes" ELSE "No" END AS "User purchase?"
FROM quiz
LEFT JOIN home_try_on ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase ON purchase.user_id = quiz.user_id
LIMIT 10;
-------------------------------------------
--2.4
WITH funnels AS(
SELECT quiz.user_id,home_try_on.user_id IS NOT NULL AS "User try at home?",home_try_on.number_of_pairs AS "Number of pairs", purchase.user_id IS NOT NULL AS "User purchase?"
FROM quiz
LEFT JOIN home_try_on ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase ON purchase.user_id = quiz.user_id)

SELECT COUNT(*) AS "Total Users", SUM("User try at home?") AS "Total at home", SUM("User Purchase?") AS "Total purchases", 100 * SUM("User try at home?") / COUNT(user_id) AS "% of users Quiz -> Home_Try_On", 100 * SUM("User Purchase?") / SUM("User try at home?") AS "% of users Home_Try_On -> Purchase"
FROM funnels;
-------------------------------------------
--2.5
SELECT style, COUNT(style)
FROM quiz
GROUP BY style
ORDER BY COUNT(style) DESC;

SELECT color, COUNT(color)
FROM quiz
GROUP BY color
ORDER BY COUNT(color) DESC;

SELECT fit, COUNT(fit)
FROM quiz
GROUP BY fit
ORDER BY COUNT(fit) DESC;

SELECT shape, COUNT(shape)
FROM quiz
GROUP BY shape
ORDER BY COUNT(shape) DESC;
-------------------------------------------
--2.6
SELECT product_id, COUNT(product_id)
FROM purchase
GROUP BY product_id
ORDER BY COUNT(product_id) DESC;

SELECT style, COUNT(style)
FROM purchase
GROUP BY style
ORDER BY COUNT(style) DESC;

SELECT color, COUNT(color)
FROM purchase
GROUP BY color
ORDER BY COUNT(color) DESC;