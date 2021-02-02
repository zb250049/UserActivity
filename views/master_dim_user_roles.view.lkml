view: dim_user_roles {
  sql_table_name: `master.Dim_User_Roles`
    ;;
  drill_fields: [id]
label: "Roles"
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.Id ;;
  }

  dimension: name {
   label: "Role Name"
    type: string
    sql: ${TABLE}.Name ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
