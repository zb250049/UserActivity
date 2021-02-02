view: audit_log {
  sql_table_name: `master.Audit_Log`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.Id ;;
  }

  dimension: action {
    label:"Action"
    type: string
    sql: ${TABLE}.Action ;;
  }

  dimension: email {
           label: "Email"
    type: string
    sql: ${TABLE}.Email ;;
  }

  dimension: ps_user_name {
    label: "Updated By"
    type: string
    sql: ${TABLE}.PSUserName ;;
  }

  dimension_group: time {
    type: time
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
    html: {{ rendered_value | date: "%m/%d/%G %r" }} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, ps_user_name]
  }
}
