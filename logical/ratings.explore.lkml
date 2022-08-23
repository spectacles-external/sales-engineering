# logical/ratings.explore.lkml
include: "/_standard/frankenmovies/imdb/basics.layer.lkml"
include: "/_standard/frankenmovies/imdb/ratings.layer.lkml"

view: fov_example {
  measure: avg_votes_per_title {
    sql: ${ratings.number_of_votes} / ${basics.count} ;;
    type: number
  }
}

explore: ratings {
  join: basics {
    relationship: one_to_one
    sql_on: ${ratings.title_id} = ${basics.id} ;;
    type: left_outer
  }

  join: fov_example  {
    relationship: one_to_one
    sql:  ;;
    type: left_outer
  }
}
