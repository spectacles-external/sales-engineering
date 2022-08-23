include: "/_base/frankenmovies/imdb/ratings.view.lkml"

view: +ratings {
  label: "Ratings"

  dimension: title_id {
    primary_key: yes
    sql: ${tconst} ;;
  }

  dimension: title_average_rating {
    label: "Rating"
    sql: ${average_rating} ;;
  }

  dimension: title_number_of_votes {
    hidden: yes
    sql: ${num_votes} ;;
  }

  measure: number_of_votes {
    type: sum
    sql: ${title_number_of_votes} ;;
  }

  measure: overall_average_rating {
    type: number
    value_format_name: decimal_1
    sql: sum(${title_average_rating} * ${title_number_of_votes}) / ${number_of_votes} ;;
  }
}
