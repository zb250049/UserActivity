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

  dimension: time {
    type: date_time
    label: "Updated date"
    html: {{ rendered_value | date: "%m/%d/%G %r" }} ;;
    sql: ${TABLE}.Time ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
