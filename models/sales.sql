WITH 

  sales AS (SELECT * FROM `original-frame-392409`.`gz_dev_1`.`stg_sales` )

  ,product AS (SELECT * FROM 'stg_product')

SELECT
  s.date_date
  ### Key ###
  ,s.orders_id
  ,s.products_id
  ###########
	-- qty --
	,s.qty
  -- revenue --
  ,s.turnover
  -- cost --
  ,CAST(p.purchase_price AS FLOAT64) AS purchase_price
,ROUND(s.qty*CAST(purchase_price AS FLOAT64),2) AS purchase_cost
	-- margin --
    ,s.turnover - s.qty*CAST(p.purchase_price AS FLOAT64) AS margin 
 ,ROUND( SAFE_DIVIDE( (s.turnover - s.qty*CAST(p.purchSE_PRICE AS FLOAT64)) , s.turnover ) , 2) AS margin_percent
FROM sales s
INNER JOIN product p ON s.products_id = p.products_id 