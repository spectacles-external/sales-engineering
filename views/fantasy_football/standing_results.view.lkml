view: standing_results {
  derived_table: {
    sql:  select *, row_number() over (partition by season order by wins desc, points desc) as position from fantasy_football.results_week_14 ;;
    persist_for: "24 hours"
  }

  dimension: points {
    type: number
    description: "The number of points a person finished with in a simulation."
    sql: ${TABLE}.points ;;
  }

  dimension: season {

    type: number
    description: "The ID for a simulation."
    sql: ${TABLE}.season ;;
  }

  dimension: team {
    type: string
    description: "The team name."
    sql: ${TABLE}.season ;;
  }

  dimension: wins {
    type: number
    description: "The number of wins a person finished with in a simulation."
    sql: ${TABLE}.wins ;;
  }

  dimension: position {
    type: number
    description: "The position a person finished in a simulation."
    sql: ${TABLE}.position ;;
  }

  measure: number_of_seasons {
    type: count
    description: "Total count of simulation seasons."
    drill_fields: []
  }

  measure: percentage_of_total_season {
    type: percent_of_total
    description: "The percentage of total seasons."
    sql: ${number_of_seasons} ;;
  }

  measure: median_position {
    type: median
    description: "The median position a person finished in."
    sql:  ${position};;
  }

  measure: mean_position {
    type: average
    description: "The mean position a person finished in."
    sql:  ${position};;
  }
}
