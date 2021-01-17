view: dim_user_roles {
  sql_table_name: `com-centralreports-cug01-dev.master.Dim_UserRoles`
    ;;
  drill_fields: [id]
label: "Roles"
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
   label: "Role Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
