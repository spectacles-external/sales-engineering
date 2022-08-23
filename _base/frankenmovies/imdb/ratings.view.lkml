view: ratings {
  sql_table_name: frankenmovies.imdb.ratings ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: tconst {
    type: string
    sql: ${TABLE}.tconst ;;
  }

  dimension: average_rating {
    type: number
    sql: ${TABLE}.averageRating ;;
  }

  dimension: num_votes {
    type: number
    sql: ${TABLE}.numVotes ;;
  }

  set: detail {
    fields: [tconst, average_rating, num_votes]
  }
}
