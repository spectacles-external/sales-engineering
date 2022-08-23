include: "/_base/frankenmovies/imdb/basics.view.lkml"

view: +basics {
  label: "Titles"

  dimension: id {
    type: string
    primary_key: yes
    sql: ${tconst} ;;
  }
}
