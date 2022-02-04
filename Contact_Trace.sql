WITH RECURSIVE exposed (eID, date, project) AS
	(SELECT '102' AS eID, '2020-06-30' , CAST(NULL AS char(4))
		UNION
	SELECT infected.eID, infected.date, infected.pID
		FROM hours carrier INNER JOIN hours infected USING(pID, date) 
			INNER JOIN exposed ON carrier.eID = exposed.eID
        WHERE infected.date > exposed.date)
SELECT eID, 'exposed' AS status, date, project
FROM exposed
GROUP BY eID
HAVING min(date)
	UNION
SELECT eID, 'not exposed' AS status, CAST(NULL AS date), CAST(NULL AS char(4))
FROM employee
WHERE eID NOT IN (SELECT eID FROM exposed)
ORDER BY eID;