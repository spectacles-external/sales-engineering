include: "/logical/ratings.explore.lkml"
# logical/frankenmovies.layer.lkml
view: frankenmovies_pdt {
  derived_table: {
    persist_for: "24 hours"
    sql:

      with joined as (

        select
          basics.tconst,
          basics.primaryTitle,
          ratings.averageRating,
          ratings.numVotes,
          row_number() over (order by ratings.numVotes desc) as vote_rank
        from frankenmovies.{{_user_attributes['dataset_location']}}.basics
        inner join frankenmovies.{{_user_attributes['dataset_location']}}.ratings
          on basics.tconst = ratings.tconst
        where basics.titleType = 'movie'
          and length(basics.primaryTitle) != length(replace(basics.primaryTitle,' ',''))

      ), splitting as (

        select
          *,
          split(primaryTitle, ' ') as words,
        from joined

      ), words_split as (

        select
          *,
          words[offset(0)] as first_word,
          words[offset(array_length(words)-1)] as last_word
        from splitting

      ), unnested as (

        select
          * except (words),
          row_number() over (partition by tconst) as r
        from words_split, unnest(words) as word

      ), remove_word as (

        select
          tconst,
          primaryTitle,
          averageRating,
          numVotes,
          first_word,
          last_word,
          string_agg(word, ' ') as missing_first_word
        from unnested
        where r > 1
        group by 1,2,3,4,5,6

      ), self_joined as (

        select
          case when a.last_word = b.first_word then a.primaryTitle else b.primaryTitle end as first_movie_name,
          case when b.last_word = a.first_word then a.primaryTitle else b.primaryTitle end as second_movie_name,
          case when a.last_word = b.first_word then a.tconst else b.tconst end as first_movie_id,
          case when b.last_word = a.first_word then a.tconst else b.tconst end as second_movie_id,
          a.numVotes * b.numVotes as frankenmovie_score,
          case
            when a.first_word = b.last_word then b.primaryTitle || ' ' || a.missing_first_word
            when b.first_word = a.last_word then a.primaryTitle || ' ' || b.missing_first_word
          end as frankenmovie_name
        from remove_word a
        inner join remove_word b
          on (a.first_word = b.last_word
          or b.first_word = a.last_word)
          and a.primaryTitle != b.primaryTitle

      )

      select distinct *
      from self_joined
       ;;
  }

  dimension: first_movie_id {
    type: string
    hidden: yes
    sql: ${TABLE}.first_movie_id ;;
  }
  dimension: second_movie_id {
    type: string
    hidden: yes
    sql: ${TABLE}.second_movie_id ;;
  }
  dimension: frankenmovie_score {
    type: number
    sql: ${TABLE}.frankenmovie_score ;;
  }
  dimension: frankenmovie_name {
    type: string
    sql: ${TABLE}.frankenmovie_name ;;
  }
}

view: ratings_entity {
  derived_table: {
    explore_source: ratings {
      column: id { field: basics.id }
      column: title_average_rating {}
    }
  }
  dimension: id {
    description: ""
  }
  dimension: title_average_rating {
    description: ""
    type: number
  }
}

explore: frankenmovies_pdt {
  label: "Frankenmovies"
  view_label: "Frankenmovies"

  join: first_movie {
    from: ratings_entity
    view_label: "First Movie"
    relationship: many_to_one
    sql_on: ${frankenmovies_pdt.first_movie_id} = ${first_movie.id} ;;
  }

  join: second_movie {
    from: ratings_entity
    view_label: "Second Movie"
    relationship: many_to_one
    sql_on: ${frankenmovies_pdt.second_movie_id} = ${second_movie.id} ;;
  }
}
