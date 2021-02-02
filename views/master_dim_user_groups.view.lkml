view: dim_user_groups {
  sql_table_name: `master.Dim_User_Groups`
    ;;
  drill_fields: [id]
label: "Groups"
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.Id ;;
  }

  dimension: name {
    label: "Group Name"
    type: string
    sql: ${TABLE}.Name ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
