view: dim_tenants {
  sql_table_name: `master.Dim_Tenants`
    ;;

  dimension: tenant_id {
    label: "Tenant"
    type: string
    sql: ${TABLE}.TenantId ;;

  }

  measure: count {
    type: count
    drill_fields: []
  }
}
