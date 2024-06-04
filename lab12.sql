CREATE TABLE finals AS
  SELECT "RSF" AS hall, "61A" as course UNION
  SELECT "Wheeler"    , "61A"           UNION
  SELECT "Pimentel"   , "61A"           UNION
  SELECT "Li Ka Shing", "61A"           UNION
  SELECT "Stanley"    , "61A"           UNION
  SELECT "RSF"        , "61B"           UNION
  SELECT "Wheeler"    , "61B"           UNION
  SELECT "Morgan"     , "61B"           UNION
  SELECT "Wheeler"    , "61C"           UNION
  SELECT "Pimentel"   , "61C"           UNION
  SELECT "Soda 310"   , "61C"           UNION
  SELECT "Soda 306"   , "10"            UNION
  SELECT "RSF"        , "70";

CREATE TABLE sizes AS
  SELECT "RSF" AS room, 900 as seats    UNION
  SELECT "Wheeler"    , 700             UNION
  SELECT "Pimentel"   , 500             UNION
  SELECT "Li Ka Shing", 300             UNION
  SELECT "Stanley"    , 300             UNION
  SELECT "Morgan"     , 100             UNION
  SELECT "Soda 306"   , 80              UNION
  SELECT "Soda 310"   , 40              UNION
  SELECT "Soda 320"   , 30;

CREATE TABLE big AS
SELECT course
FROM (
    SELECT f.course, SUM(s.seats) AS total_seats
    FROM finals f
    JOIN sizes s ON f.hall = s.room
    GROUP BY f.course
) AS course_totals
WHERE course_totals.total_seats >= 1000;


CREATE TABLE remaining AS
  SELECT 
    course,

    (SUM(seats) - MAX(seats)) AS remaining

  FROM (
    SELECT f.course, s.seats
    FROM finals f
    JOIN sizes s ON f.hall = s.room
) 
AS combined
GROUP BY course;

CREATE TABLE sharing AS
  SELECT

    f.course,

    COUNT(DISTINCT f.hall) AS shared
  FROM

    finals f

INNER JOIN

    (SELECT hall
     FROM finals
     GROUP BY hall
     HAVING COUNT(DISTINCT course) > 1) AS shared_halls

ON f.hall = shared_halls.hall
GROUP BY f.course;

CREATE TABLE pairs AS
  SELECT 

    a.room || ' and ' || b.room || ' together have ' || (a.seats + b.seats) || ' seats' AS rooms

FROM 
    sizes a
    
JOIN 
    sizes b ON a.room < b.room  
    
    WHERE 
    (a.seats + b.seats) >= 1000
ORDER BY 
    (a.seats + b.seats) DESC;


