view: fact_user_attributes_view {
  sql_table_name: `master.Fact_UserAttributes_view`
    ;;
  drill_fields: [id]
label: "Activity & Attributes"
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: attributes {
    hidden: yes
    sql: ${TABLE}.Attributes ;;
  }

  dimension_group: crreated {
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
    sql: ${TABLE}.CrreatedDate ;;
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
    sql: ${TABLE}.display_name ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: group_id {
    type: number
    sql: ${TABLE}.groupId ;;
  }

  dimension_group: last_log_in {
    label: "Last Login Date"
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
  }

  dimension: role_id {
    type: number
    sql: ${TABLE}.roleId ;;
  }



  measure: count {
    type: count
    drill_fields: [id, display_name]
  }

  dimension: name {
    label: "Attribute Name"
    type: string
    sql: ${TABLE}.Attributes.name ;;
  }

  dimension: source {
    label: "Attribute Source"
    type: string
    sql: ${TABLE}.Attributes.source ;;
  }

  dimension: value {
    label: "Attribute Value"
    type: string
    sql: ${TABLE}.Attributes.value ;;
  }

  dimension: role_names {
    label: "Roles"
    type: string
    sql: ${TABLE}.role_names ;;
  }
  dimension: updateddate {
    label: "Lasr Updated Date"
    type: date_time
    sql: ${TABLE}.updateddate ;;
  }
  dimension: account {
    label: "Status"
    type: string
    sql: ${TABLE}.account ;;
  }
  dimension: user_key {
    label: "User Key"
    type: string
    sql: ${TABLE}.user_key ;;
    hidden: yes
  }
  dimension: tenant_id_new {
    label: "Tenant"
    type: string
    sql: ${TABLE}.tenant_id ;;
    }
  dimension: tenant_id {
    label: "Tenant Combined"
    type: string
    sql: CASE WHEN ${tenant_id_new} != "No Value"  and ${user_key} != "No Value" and ${customer_source}="NCR" Then concat( ${tenant_id_new},"~~~",Cast(${id} as STRING),"~~~",${user_key})   ELSE "No Value~~~-2~~~No Value" END;;
    hidden: yes
 }

  dimension: update_tenant {
    sql: ${tenant_id} ;;
    label: "Update Action"

    action: {
      label: "Update Tenant"
      url: "https://us-central1-com-centralreports-cug01-dev.cloudfunctions.net/Change_UserTenant"
      param: {
        name:"tenant_id"
        value: "{{value}}"
      }
      user_attribute_param: {
        user_attribute: email
        name: "ps_email"
      }
      form_param: {
        name: "changetenant"
        type: string
        label: "Tenant"
        description: "Enter new tenant."
        required: yes
      }
     }
     action: {
      label: "Update Role"
      url: "https://us-central1-com-centralreports-cug01-dev.cloudfunctions.net/Change_UserRole"
      param: {
        name:"tenant_id"
        value: "{{value}}"
      }
      user_attribute_param: {
        user_attribute: email
        name: "ps_email"
      }
      form_param: {
        name: "changerole"
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
    sql: ${TABLE}.audit ;;
  }
}
