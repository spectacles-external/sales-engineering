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

  join: first_movie_ratings {
    from: ratings
    view_label: "First Movie"
    relationship: one_to_one
    sql_on: ${first_movie.id} = ${first_movie_ratings.title_id} ;;
  }

  join: second_movie {
    from: titles
    view_label: "Second Movie"
    relationship: many_to_one
    sql_on: ${frankenmovies_pdt.second_movie_id} = ${second_movie.id} ;;
  }

  join: second_movie_ratings {
    from: ratings
    view_label: "Second Movie"
    relationship: one_to_one
    sql_on: ${second_movie.id} = ${second_movie_ratings.title_id} ;;
  }
}
