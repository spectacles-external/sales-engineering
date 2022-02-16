view: titles {
  sql_table_name: frankenmovies.{{_user_attributes['dataset_location']}}.basics ;;
  label: "Titles"

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.tconst ;;
  }

  dimension: title_type {
    type: string
    sql: ${TABLE}.titleType ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.primaryTitle ;;
  }

  dimension: originalTible {
    type: string
    sql: ${TABLE}.originalTitle ;;
  }

  dimension: is_adult {
    label: "Is Adult?"
    type: yesno
    sql:
        case
          when ${TABLE}.isAdult = '0' then false
          when ${TABLE}.isAdult = '1' then true
        end
    ;;
  }

  dimension: start_year {
    type: number
    value_format: "####"
    sql: cast(nullif(${TABLE}.startYear,'\\N') as int64) ;;
  }

  dimension: end_year {
    type: number
    value_format: "####"
    sql: cast(nullif(${TABLE}.endYear,'\\N') as int64) ;;
  }

  dimension: runtime_minutes {
    type: number
    label: "Runtime (minutes)"
    sql: cast(nullif(${TABLE}.runtimeMinutes,'\\N') as int64) ;;
  }

  dimension: genres {
    type: string
    description: "This is a comma separated list of genres. You need to therefore use a 'contains' filter."
    sql: ${TABLE}.genres ;;
  }

  measure: count_titles {
    type: count_distinct
    label: "Count of Titles"
    sql: ${id} ;;
  }

}
