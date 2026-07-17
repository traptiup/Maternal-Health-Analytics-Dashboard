-- How many states are available in the dataset?

SELECT COUNT(*)
FROM maternal_health;

-- Display all available states.

SELECT state
FROM maternal_health
ORDER BY state;

-- Display all columns from the dataset.

SELECT *
FROM maternal_health;

-- Show maternal healthcare indicators for all states.

SELECT
    state,
    anc_first,
    anc_4,
    institutional_delivery,
    mmr
FROM maternal_health;

-- Find states where MMR data is available.

SELECT state, mmr FROM maternal_health
WHERE mmr IS NOT NULL;

-- Which states have Maternal Mortality Ratio greater than 100?

SELECT state, mmr
FROM maternal_health
WHERE mmr > 100;

-- Which states have Institutional Delivery below 80%?

SELECT state, institutional_delivery
FROM maternal_health

-- Which states have ANC 4 Visit coverage above 80%?

SELECT state, anc_4
FROM maternal_health
WHERE anc_4 > 80;

-- Which states have no doctor shortfall?

SELECT state
FROM maternal_health
WHERE doctors_shortfall = 0;

-- Which states have doctor shortfall greater than 1000?

SELECT
    state,
    doctors_shortfall
FROM maternal_health
WHERE doctors_shortfall > 1000;

-- Which states have C-Section rate above 30%?

SELECT
    state,
    csection_rate
FROM maternal_health
WHERE csection_rate > 30;

-- Which states have Delivery Cost greater than ₹5000?

SELECT
    state,
    delivery_cost
FROM maternal_health
WHERE delivery_cost > 5000;

-- Calculate average Institutional Delivery.

SELECT AVG(institutional_delivery)

-- Calculate average Maternal Mortality Ratio.

SELECT AVG(mmr)
FROM maternal_health;

-- Find highest Delivery Cost.

SELECT MAX(delivery_cost)
FROM maternal_health;

-- Find lowest Delivery Cost.

SELECT MIN(delivery_cost)
FROM maternal_health;

-- Total Doctor Shortfall across India.

SELECT SUM(doctors_shortfall)
FROM maternal_health;

-- Average ANC 4 Visit Coverage.

SELECT AVG(anc_4)
FROM maternal_health;

-- Categorize Institutional Delivery.

SELECT
    state,
    institutional_delivery,

    CASE

        WHEN institutional_delivery >=95
            THEN 'Excellent'

        WHEN institutional_delivery >=85
            THEN 'Good'

        ELSE 'Needs Improvement'

    END AS delivery_category

FROM maternal_health;

-- States fall into each Institutional Delivery category

SELECT

CASE

WHEN institutional_delivery>=95 THEN 'Excellent'

WHEN institutional_delivery>=85 THEN 'Good'

ELSE 'Needs Improvement'

END AS delivery_category,

COUNT(*) AS total_states

FROM maternal_health

GROUP BY delivery_category;

-- Categorize MMR.

SELECT

    state,
    mmr,

    CASE

        WHEN mmr<70
            THEN 'Low'

        WHEN mmr<100
            THEN 'Moderate'

        ELSE 'High'

    END AS mmr_category

FROM maternal_health;

-- Categorize ANC Coverage.

SELECT

    state,
    anc_4,

    CASE

        WHEN anc_4>=80
            THEN 'High'

        WHEN anc_4>=60
            THEN 'Moderate'

        ELSE 'Low'

    END

FROM maternal_health;

-- Categorize Doctor Availability.

SELECT

state,

doctors_shortfall,

CASE

WHEN doctors_shortfall=0
THEN 'Adequate'

ELSE 'Shortage'

END

FROM maternal_health;

-- Which states have Institutional Delivery above national average?

SELECT

state,
institutional_delivery

FROM maternal_health

WHERE institutional_delivery>

(

SELECT AVG(institutional_delivery)

FROM maternal_health

);

-- Which states have MMR above national average?

SELECT

state,
mmr

FROM maternal_health

WHERE mmr>

(

SELECT AVG(mmr)

FROM maternal_health

);

-- Rank states by MMR.

SELECT

state,
mmr,

RANK() OVER(ORDER BY mmr DESC) AS mmr_rank

FROM maternal_health;

-- Rank states by Institutional Delivery.

SELECT

state,
institutional_delivery,

DENSE_RANK()

OVER(ORDER BY institutional_delivery DESC)

AS delivery_rank

FROM maternal_health;

-- Row number based on ANC 4 Coverage.

SELECT

state,
anc_4,

ROW_NUMBER()

OVER(ORDER BY anc_4 DESC)

FROM maternal_health;

-- States having above-average ANC Coverage.

WITH avg_anc AS

(

SELECT AVG(anc_4) AS avg_value

FROM maternal_health

)

SELECT

state,
anc_4

FROM maternal_health

WHERE anc_4>

(

SELECT avg_value

FROM avg_anc

);

-- States having above-average Institutional Delivery.

WITH avg_delivery AS

(

SELECT AVG(institutional_delivery) avg_delivery

FROM maternal_health

)

SELECT

state,
institutional_delivery

FROM maternal_health

WHERE institutional_delivery>

(

SELECT avg_delivery

FROM avg_delivery

);

-- Identify states with High MMR and Low Institutional Delivery.

SELECT

state,
mmr,
institutional_delivery

FROM maternal_health

WHERE

mmr>100

AND

institutional_delivery<80;