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
