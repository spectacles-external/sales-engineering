view: standing_results {
  derived_table: {
    sql:  select *, row_number() over (partition by season order by wins desc, points desc) as position from fantasy_football.results_week_14 ;;
    persist_for: "24 hours"
  }

  dimension: points {
    type: number
    sql: ${TABLE}.points ;;
  }

  dimension: season {
    type: number
    sql: ${TABLE}.seson ;;
  }

  dimension: team {
    type: string
    sql: ${TABLE}.team ;;
  }

  dimension: wins {
    type: number
    sql: ${TABLE}.wins ;;
  }

  dimension: position {
    type: number
    sql: ${TABLE}.position ;;
  }

  measure: number_of_seasons {
    type: count
    drill_fields: []
  }

  measure: percentage_of_total_season {
    type: percent_of_total
    sql: ${number_of_seasons} ;;
  }

  measure: median_position {
    type: median
    sql:  ${position};;
  }

  measure: mean_position {
    type: average
    sql:  ${position};;
  }
}
