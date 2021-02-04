#connection: "centralreports"
connection: "master"

include: "*.view"
# include: "*.dashboard.lookml"


datagroup: no_cache {
  max_cache_age: "1 second"
}
