DROP VIEW IF EXISTS weeklypayroll;
CREATE VIEW weeklypayroll AS SELECT *
FROM hours NATURAL JOIN job NATURAL JOIN employee INNER JOIN wage USING(trade, city, state)
WHERE (trade, city, state, effective) IN (SELECT trade, city, state, MAX(effective) 
	FROM wage WHERE effective <= hours.date GROUP BY trade, city, state);
(SELECT eID, lastname, firstname, sum(stwages*sthours+otwages*othours) AS weekly_wages, 
	sum(stbenifits*sthours+otbenefits*othours) AS weekly_benefits, 'full time' AS status
FROM weeklypayroll
GROUP BY eID
HAVING sum(sthours+othours) >= 40)
	UNION
(SELECT eID, lastname, firstname, sum(stwages*sthours+otwages*othours) AS weekly_wages, 
	sum(stbenifits*sthours+otbenefits*othours) AS weekly_benefits, 'part time' AS status 
FROM weeklypayroll
GROUP BY eID
HAVING sum(sthours+othours) < 40)
ORDER BY eID;
