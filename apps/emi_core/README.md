# EmiCore

## Media
Provides elixir structs for manipulating and working with scanned media directories.


## Scanner
Scans provided directories and uses the media API to build elixir structs of media.
Forwards the data to the metadata fetcher in order to fetch metadata from IMDB, Musicbrainz etc

## Metadata Fetcher
Manages a queue of data requests to TMDB and others. TMDB is cheaper than IMDB so, we use that instead. 

### TMDB
[TMDB API Docs](https://developer.themoviedb.org/docs/getting-started)

#### [ GET request ](https://developer.themoviedb.org/reference/search-movie)
- Requires bearer authorization header 
- Of importance here is that the search term from the TMDB API will be a query param
- Other importanat query params
    - include_adult?            : boolean
    - language                  : string(default to en-US)
    - primary_release_year      : string
    - page                      : integer
    - region                    : string
    - year                      : string
- Returns a body with keys, `page, results` where results will be an array of objects. Each object will have these keys 
```
{
    adult: boolean (Defaults to true )
    backdrop_path: string
    id: integer ( Defaults to 0 )
    title: string
    original_language: string
    original_title: string
    overview: string
    poster_path: string
    media_type: string
    genre_ids: array of integers
    popularity: number ( Defaults to 0)
    release_date: string
    video: boolean, ( Defaults to true )
    vote_average: number (Defaults to 0)
    vote_count: integer ( Defaults to 0 )
}
```

## Query
Persists the info from MetadataFetcher and Scanner.

