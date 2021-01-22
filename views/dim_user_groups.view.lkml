view: dim_user_groups {
  sql_table_name: `SCO_Poc.Dim_UserGroups`
    ;;
  drill_fields: [id]
label: "Groups"
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    label: "Group Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
