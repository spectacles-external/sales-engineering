view: titles {
  sql_table_name: frankenmovies.{{_user_attributes['dataset_location']}}.basics ;;
  label: "Titles"

  dimension: id {
    type: string
    description: "Id of the movie or tv show."
    primary_key: yes
    sql: ${TABLE}.tconst ;;
  }

#### ⚠️ STEP 1

#### Rename 'title_type' to 'title_category'.

  dimension: title_category {
    type: string
    description: "The type of title, i.e. movie or tv show."
    sql: ${TABLE}.titleType ;;
  }

  dimension: title {
    type: string
    description: "The name of the movie or tv show."
    sql: ${TABLE}.primaryTitle ;;
  }

#### ⚠️ STEP 2

#### Add this new field by uncommenting this code!

  dimension: original_title {
    type: string
    sql: ${TABLE}.original_title ;;
  }

  dimension: is_adult {
    label: "Is Adult?"
    description: "Whether it is an adult title or not."
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
    description: "The year the movie or tv show started."
    value_format: "####"
    sql: cast(nullif(${TABLE}.startYear,'\\N') as int64) ;;
  }

  dimension: end_year {
    type: number
    description: "The year the movie or tv show ended."
    value_format: "####"
    sql: cast(nullif(${TABLE}.endYear,'\\N') as int64) ;;
  }

  dimension: runtime_minutes {
    type: number
    description: "The runtime of the title in minutes."
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
    description: "The count of unique movies or tv shows."
    label: "Count of Titles"
    sql: ${id} ;;
  }

}
