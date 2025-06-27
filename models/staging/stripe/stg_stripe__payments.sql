select
    id,
    orderid,
    paymentmethod,
    status,
    amount/100 as amount
from {{ source("stripe", "payment") }}