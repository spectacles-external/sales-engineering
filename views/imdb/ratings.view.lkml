view: ratings {
  sql_table_name: frankenmovies.{{_user_attributes['dataset_location']}}.ratings ;;
  label: "Ratings"

  dimension: title_id {
    type: string
    description: "The ID of the movie or tv show."
    primary_key: yes
    sql: ${TABLE}.tconst ;;
  }

  dimension: title_average_rating {
    type: number
    label: "Rating"
    hidden: yes
    sql: ${TABLE}.averageRating ;;
  }

  dimension: title_number_of_votes {
    type: number
    hidden: yes
    sql: ${TABLE}.numVotes ;;
  }

  measure: number_of_votes {
    type: sum
    description: "Total number of rating votes the movie or tv show received."
    sql: ${title_number_of_votes} ;;
  }

  measure: average_rating {
    type: number
    description: "Average rating of the movie or tv show."
    value_format_name: decimal_1
    sql: sum(${title_average_rating} * ${title_number_of_votes}) / ${number_of_votes} ;;
  }

}
