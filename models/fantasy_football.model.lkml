connection: "spectacles_learn_bigquery"

include: "/views/fantasy_football/*.view.lkml"

label: "Fantasy Football"

explore: standing_results {}

test: standings_in_range {
  explore_source: standing_results {
    column: team {
      field: standing_results.team
    }
    column: mean {
      field: standing_results.mean_position
    }
    column: median {
      field: standing_results.median_position
    }
  }
  assert: mean_in_range {
    expression: ${standing_results.mean_position} < 10 AND ${standing_results.mean_position} > 0 ;;
  }
  assert: median_in_range {
    expression: ${standing_results.median_position} < 10 AND ${standing_results.median_position} > 0 ;;
  }
}
