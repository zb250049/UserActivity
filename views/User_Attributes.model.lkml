#connection: "centralreports"
connection: "master"

include: "*.view"
# include: "*.dashboard.lookml"


datagroup: no_cache {
  max_cache_age: "1 second"
}


access_grant: allow_explore_loss_prevention {
  user_attribute: cr_explore_loss_prevention
  allowed_values: ["allow"]
}

access_grant: allow_explore_risk_scoring {
  user_attribute: cr_explore_risk_scoring
  allowed_values: ["allow"]
}

access_grant: allow_explore_sales {
  user_attribute: cr_explore_sales
  allowed_values: ["allow"]
}

access_grant: allow_explore_fuel {
  user_attribute: cr_explore_fuel
  allowed_values: ["allow"]
}

access_grant: allow_explore_cash_office {
  user_attribute: cr_explore_cash_office
  allowed_values: ["allow"]
}

access_grant: allow_explore_support {
  user_attribute: cr_explore_support
  allowed_values: ["allow"]
}


access_grant: allow_explore_productivity {
  user_attribute: cr_explore_productivity
  allowed_values: ["allow"]
}

access_grant: allow_explore_support_multitenants {
  user_attribute: cr_explore_support_multitenants
  allowed_values: ["allow"]
}

access_grant: allow_explore_transaction_search {
  user_attribute: cr_explore_transaction_search
  allowed_values: ["allow"]
}
#persist_for: "0 seconds" # Cache expiration time for all the Reports data coming from db



#          ------------------------------------    SALES BY DEPARTMENT REPORT    --------------------------------

explore: fact_user_attributes_view {
  label: "Activity & Attributes"
  persist_for: "0 seconds"

  join: dim_tenants {
    view_label: "Tenants"
    relationship: many_to_one
    type: left_outer
    sql_on: ${fact_user_attributes_view.tenant_id} = ${dim_tenants.tenant_id};;
  }
  join: dim_user_attributes {
    view_label: "attributes"
    relationship: many_to_one
    type: left_outer
    sql_on: ${fact_user_attributes_view.name} = ${dim_user_attributes.name};;
  }
  join: dim_user_roles {
    view_label: "Roles"
    relationship: many_to_one
    type: left_outer
    sql_on: ${fact_user_attributes_view.role_id} = ${dim_user_roles.id};;
  }
  join: dim_user_groups {
    view_label: "Groups"
    relationship: many_to_one
    type: left_outer
    sql_on: ${fact_user_attributes_view.group_id} = ${dim_user_groups.id};;
  }
  join: dim_looker_customers {
    view_label: "Groups"
    relationship: many_to_one
    type: left_outer
    sql_on: ${fact_user_attributes_view.customer_source} = ${dim_looker_customers.customer_source};;
  }
  join: audit_log {
    view_label: "Audit Log"
    relationship: many_to_one
    type: full_outer
    sql_on:${audit_log.id}= ${fact_user_attributes_view.id}  ;;
  }
}
