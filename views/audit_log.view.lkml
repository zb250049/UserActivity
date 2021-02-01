view: audit_log {
  sql_table_name: `com-centralreports-cug01-dev.master.AuditLog`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: action {
    label:"Action"
    type: string
    sql: ${TABLE}.Action ;;
  }

  dimension: email {
           label: "Email"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: ps_user_name {
    label: "Updated By"
    type: string
    sql: ${TABLE}.PS_userName ;;
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
    sql: ${TABLE}.time ;;
    html: {{ rendered_value | date: "%m/%d/%G %r" }} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, ps_user_name]
  }
}
