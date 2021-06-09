connection: "spectacles_learn_bigquery"

include: "/views/imdb/*.view.lkml"

label: "IMDB"

explore: titles {}

explore: ratings {
  join: titles {
    relationship: one_to_one
    sql_on: ${ratings.title_id} = ${titles.id} ;;
  }
}

explore: frankenmovies_pdt {
  label: "Frankenmovies"
  view_label: "Frankenmovies"
  join: first_movie {
    from: titles
    view_label: "First Movie"
    relationship: many_to_one
    sql_on: ${frankenmovies_pdt.first_movie_id} = ${first_movie.id} ;;
  }
  join: second_movie {
    from: titles
    view_label: "Second Movie"
    relationship: many_to_one
    sql_on: ${frankenmovies_pdt.second_movie_id} = ${second_movie.id} ;;
  }
}
