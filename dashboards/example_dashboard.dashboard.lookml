- dashboard: example_dashboard
  title: Example Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  preferred_slug: jdwYir0eKKitp95OeWTuaV
  elements:
  - title: Example Dashboard
    name: Example Dashboard
    model: imdb
    explore: frankenmovies_pdt
    type: looker_grid
    fields: [frankenmovies_pdt.frankenmovie_name, frankenmovies_pdt.frankenmovie_score,
      first_movie.title, first_movie.start_year, second_movie.title, second_movie.start_year]
    sorts: [frankenmovies_pdt.frankenmovie_score desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 12
