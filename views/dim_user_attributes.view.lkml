view: dim_user_attributes {
  sql_table_name: `com-centralreports-cug01-dev.master.Dim_UserAttributes`
    ;;
label: "attributes"
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
