view: basics {
  sql_table_name: frankenmovies.imdb.basics ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: index {
    type: string
    sql: ${TABLE}.index ;;
  }

  dimension: tconst {
    type: string
    sql: ${TABLE}.tconst ;;
  }

  dimension: title_type {
    type: string
    sql: ${TABLE}.titleType ;;
  }

  dimension: primary_title {
    type: string
    sql: ${TABLE}.primaryTitle ;;
  }

  dimension: original_title {
    type: string
    sql: ${TABLE}.originalTitle ;;
  }

  dimension: is_adult {
    type: string
    sql: ${TABLE}.isAdult ;;
  }

  dimension: start_year {
    type: string
    sql: ${TABLE}.startYear ;;
  }

  dimension: end_year {
    type: string
    sql: ${TABLE}.endYear ;;
  }

  dimension: runtime_minutes {
    type: string
    sql: ${TABLE}.runtimeMinutes ;;
  }

  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
  }

  set: detail {
    fields: [
      index,
      tconst,
      title_type,
      primary_title,
      original_title,
      is_adult,
      start_year,
      end_year,
      runtime_minutes,
      genres
    ]
  }
}
