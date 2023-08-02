WITH 

  sales AS (SELECT * FROM `original-frame-392409`.`gz_dev_1`.`stg_sales` )

  ,product AS (SELECT * FROM `gz_raw_data.raw_gz_product`)

SELECT
  s.date_date
  ### Key ###
  ,s.orders_id
  ,s.pdt_id AS products_id
  ###########
	-- qty --
	,s.quantity AS qty
  -- revenue --
  ,s.revenue AS turnover
  -- cost --
  ,CAST(p.purchSE_PRICE AS FLOAT64) AS purchase_price
,ROUND(s.quantity*CAST(p.purchSE_PRICE AS FLOAT64),2) AS purchase_cost
	-- margin --
    ,s.revenue - s.quantity*CAST(p.purchSE_PRICE AS FLOAT64) AS margin 
 ,ROUND( SAFE_DIVIDE( (s.revenue - s.quantity*CAST(p.purchSE_PRICE AS FLOAT64)) , s.revenue ) , 2) AS margin_percent
FROM sales s
INNER JOIN product p ON s.pdt_id = p.products_id 