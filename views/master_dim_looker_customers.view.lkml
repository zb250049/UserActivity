view: dim_looker_customers {
  sql_table_name: `master.Dim_Looker_Customers`
    ;;

  dimension: customer_source {
    type: string
    sql: ${TABLE}.CustomerSource ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
