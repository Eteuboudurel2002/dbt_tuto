{% snapshot orders_snapshot %}

{% set schema = target.schema + "_snapshot"%}
{{config(
    target_database = target.database,
    target_schema = schema,
    unique_key = 'id',

    strategy = 'timestamp',
    updated_at = 'ORDER_DATE',

    invalidate_hard_deletes= true
)}}

select * from {{source("jaffle_shop","orders")}}

{% endsnapshot %}