# logical/ratings.explore.lkml
include: "/_standard/frankenmovies/imdb/basics.layer.lkml"
include: "/_standard/frankenmovies/imdb/ratings.layer.lkml"
explore: ratings {
  join: basics {
    relationship: one_to_one
    sql_on: ${ratings.title_id} = ${basics.id} ;;
    type: left_outer
  }
}
