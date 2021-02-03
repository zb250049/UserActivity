view: fact_user_attributes_view {
  sql_table_name: `master.Fact_User_Attributes_View`
    ;;
  drill_fields: [id]
label: "Activity & Attributes"
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.Id ;;
  }

  dimension: attributes {
    hidden: yes
    sql: ${TABLE}.Attributes ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CreatedDate ;;
    html: {{ rendered_value | date: "%m/%d/%G" }} ;;
  }

  dimension: customer_source {
    label: "Domain"
    type: string
    sql: ${TABLE}.CustomerSource ;;
  }

  dimension: days_since_last_log_in {
    label : "Days Since Last Login"
    type: number
    sql: ${TABLE}.DaysSinceLastLogIn ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.DisplayName ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.Email ;;
    link: {label:"Exlpore audit Log"
      url: "https://commercedevncr.cloud.looker.com/looks/1107?fields=audit_log.ps_user_name,audit_log.email,audit_log.time_time,audit_log.action&f[fact_user_attributes_view.email]={{ value }}" }
  }

  dimension: group_id {
    type: number
    sql: ${TABLE}.GroupId ;;
  }

  dimension_group: last_log_in {
    label: "Last Login"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.LastLogIn ;;
    html: {{ rendered_value | date: "%m/%d/%G" }} ;;
  }

  dimension: role_id {
    type: number
    sql: ${TABLE}.RoleId ;;
  }



  measure: count {
    type: count
    drill_fields: [id, display_name]
  }

  dimension: name {
    label: "Attribute Name"
    type: string
    sql: ${TABLE}.Attributes.Name ;;
  }

  dimension: source {
    label: "Attribute Source"
    type: string
    sql: ${TABLE}.Attributes.Source ;;
  }

  dimension: value {
    label: "Attribute Value"
    type: string
    sql: ${TABLE}.Attributes.Value ;;
  }

  dimension: role_names {
    label: "Roles"
    type: string
    sql: ${TABLE}.RoleNames ;;
  }
  dimension: updateddate {
    label: "Last Updated Date"
    type: date_time
    sql: ${TABLE}.UpdatedDate ;;
    html: {{ rendered_value | date: "%m/%d/%G %r" }} ;;
    link: {label:"Exlpore ETL data from Looker audit log"
    url: "https://commercedevncr.cloud.looker.com/looks/1108?fields=etl_audit_log.phase,etl_audit_log.time_time,etl_audit_log.message" }
  }
  dimension: account {
    label: "Status"
    type: string
    sql: ${TABLE}.Account ;;
  }
  dimension: user_key {
    label: "User Key"
    type: string
    sql: ${TABLE}.UserKey ;;
    hidden: yes
  }
  dimension: tenant_id {
    label: "Tenant"
    type: string
    sql: ${TABLE}.TenantId ;;
    }
  dimension: tenant_id_new {
    label: "Tenant Combined"
    type: string
    sql: CASE WHEN ${tenant_id} != "No Value"  and ${user_key} != "No Value" and ${customer_source}="NCR" Then concat( ${tenant_id},"~~~",Cast(${id} as STRING),"~~~",${user_key})   ELSE "No Value~~~-2~~~No Value" END;;
    hidden: yes
 }

  dimension: update_tenant {
    sql: ${tenant_id_new} ;;
    label: "Update Tenant"

    action: {
      label: "Update Tenant"
      url: "https://us-central1-com-centralreports-cug01-dev.cloudfunctions.net/Change_User_Tenant"
      param: {
        name:"tenant_id"
        value: "{{value}}"
      }
      user_attribute_param: {
        user_attribute: email
        name: "ps_email"
      }
      form_param: {
        name: "change_tenant"
        type: string
        label: "Tenant"
        description: "Enter new tenant."
        required: yes
      }
     }

    html:
      {% if  {{value}} =="No Value~~~-2~~~No Value" %}
         <p><img src="http://findicons.com/files/icons/719/crystal_clear_actions/64/cancel.png" height=20 width=20></p>
      {% else %}
        <p><img src="http://findicons.com/files/icons/573/must_have/48/check.png" height=20 width=20></p>
      {% endif %};;
      }

  dimension: role_id_new {
    label: "Role Id Combined"
    type: string
    sql: CASE WHEN ${user_key} != "No Value"  Then concat( ${tenant_id},"~~~",Cast(${id} as STRING),"~~~",${user_key})   ELSE "No Value~~~-2~~~No Value" END;;
    hidden: yes
  }
  dimension: update_role {
    sql: ${role_id_new} ;;
    label: "Update Role"
    action: {
      label: "Update Role"
      url: "https://us-central1-com-centralreports-cug01-dev.cloudfunctions.net/Change_User_Role"
      param: {
        name:"tenant_id"
        value: "{{value}}"
      }
      user_attribute_param: {
        user_attribute: email
        name: "ps_email"
      }
      form_param: {
        name: "change_role"
        type: select
        label: "Pick Role"
        option: {
          name: "CR_REPORTS_VIEWER"
          label: "CR_REPORTS_VIEWER"
        }
        option: {
          name: "CR_REPORTS_USER"
          label: "CR_REPORTS_USER"
        }
        required: yes
        description: "Pick User or Viewer"
        default: "viewer"
      }
    }
    html:
      {% if  {{value}} =="No Value~~~-2~~~No Value" %}
         <p><img src="http://findicons.com/files/icons/719/crystal_clear_actions/64/cancel.png" height=20 width=20></p>
      {% else %}
       <p><img src="http://findicons.com/files/icons/573/must_have/48/check.png" height=20 width=20></p>
      {% endif %};;
  }

  dimension: audit {
    label: "Audit"
    type: string
    sql: ${TABLE}.Audit ;;
    link: {label:"Exlpore audit Log"
    url: "https://commercedevncr.cloud.looker.com/looks/1107?fields=audit_log.ps_user_name,audit_log.email,audit_log.time_time,audit_log.action" }

  }
}
