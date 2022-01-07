view: ratings {
  sql_table_name: frankenmovies.{{_user_attributes['dataset_location']}}.ratings ;;
  label: "Ratings"


  dimension: title_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.tconst ;;
  }

  dimension: title_average_rating {
    type: number
    label: "Rating"
    sql: ${TABLE}.averageRating ;;
  }

  dimension: title_number_of_votes {
    type: number
    hidden: yes
    sql: ${TABLE}.numVotes ;;
  }

  measure: number_of_votes {
    type: sum
    sql: ${title_number_of_votes} ;;
  }

  measure: average_rating {
    type: number
    value_format_name: decimal_1
    sql: sum(${title_average_rating} * ${title_number_of_votes}) / ${number_of_votes} ;;
  }

}
