view: etl_audit_log {
  sql_table_name: master.ETL_Audit_Log
    ;;

  dimension: message {
    type: string
    sql: ${TABLE}.Message ;;
  }

  dimension: phase {
    type: string
    sql: ${TABLE}.Phase ;;
  }

  dimension_group: time {
    type: time
    label: "Updated date"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Time ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
