view: dim_looker_customers {
  sql_table_name: `SCO_Poc.Dim_LookerCustomers`
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
