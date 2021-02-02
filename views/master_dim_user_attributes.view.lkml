view: dim_user_attributes {
  sql_table_name: `master.Dim_User_Attributes`
    ;;
label: "attributes"
  dimension: name {
    type: string
    sql: ${TABLE}.Name ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
