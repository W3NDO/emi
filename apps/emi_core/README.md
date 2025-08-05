# EmiCore

## Media
Provides elixir structs for manipulating and working with scanned media directories.


## Scanner
Scans provided directories and uses the media API to build elixir structs of media.
Forwards the data to the metadata fetcher in order to fetch metadata from IMDB, Musicbrainz etc

## Metadata Fetcher
Manages a queue of data requests to TMDB and others. TMDB is cheaper than IMDB so, we use that instead. 

[TMDB API Docs](https://developer.themoviedb.org/docs/getting-started)

## Query
Persists the info from MetadataFetcher and Scanner.

