CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child
  FROM parents
  JOIN dogs ON parents.parent = dogs.name
  ORDER BY dogs.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT dogs.name, sizes.size
  FROM dogs
  JOIN sizes ON dogs.height > sizes.min AND dogs.height <= sizes.max;



-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child AS sibling1, b.child AS sibling2
  FROM parents a
  JOIN parents b ON a.parent = b.parent AND a.child <> b.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT DISTINCT 
    CASE 
      WHEN a.sibling1 < a.sibling2 
      THEN 'The two siblings, ' || a.sibling1 || ' and ' || a.sibling2 || ', have the same size: ' || b.size 
      ELSE 'The two siblings, ' || a.sibling2 || ' and ' || a.sibling1 || ', have the same size: ' || b.size 
    END AS sentence
  FROM siblings a
  JOIN size_of_dogs b ON a.sibling1 = b.name
  JOIN size_of_dogs c ON a.sibling2 = c.name AND b.size = c.size
  WHERE a.sibling1 < a.sibling2;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, 1 AS count  
  FROM dogs
  GROUP BY fur
  HAVING MAX(height) <= 1.3 * AVG(height) AND MIN(height) >= 0.7 * AVG(height);

