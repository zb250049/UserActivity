view: dim_tenants {
  sql_table_name: `com-centralreports-cug01-dev.master.Dim_Tenants`
    ;;

  dimension: tenant_id {
    label: "Tenant"
    type: string
    sql: ${TABLE}.tenant_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
