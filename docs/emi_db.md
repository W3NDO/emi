# emi_db

*Documentation for the DB app*

For simplicity, we use sqllite by default since this is also what Jellyfin uses. If it breaks we will update it. 


## Models
1. User Accounts
    - Name
    - Password
    - is_admin (or some version of it)

2. Visual Media Metadata
   ```
    VisualMedia
        ├── Movie
        └── Episode ──┬── Season
            └── Show (Series)
    ```

    #### Fields
    - title
    - imdb-id (unique, null: false)
    - type (Movie, Episode)
    - original title
    - synopsis
    - release_date
    - language
    - country
    - status
    - slug
    - cast (many 2 many)
    - directors ( many to many )
    - writers ( many to many )
    - producers ( many to many)
    - crew ( many to many )
    - poster_url
    - backdrop_url
    - trailer_url
    - gallery
    - video_files
    - genres ( many to many )
    - keywords
    - certification/rating
    - tags
    - video_codec
    - audio_codec
    - resolution
    - bitrate
    - subtitles

3. Song Metadata
    - title
    - artist
    - album name
    - album_id (one to many)
    - audio_codec
    - bitrate
    - genres
    - song_writers
    - poster_url
    - backdrop_url
    - producing studio
    - musicbrainz-id (unique, null: false)

4. Album Metadata
    - title
    - artist
    - featured_artists
    - poster_url
    - backdrop_url
    - song_writers
    - producing_studio
    - songs (many-to-one)
    - musicbrainz-id (unique, null: false)

5. Person Info
    - name
    - date of birth
    - nationality
    - bio
    - role
    - aliases
    - gender
    - image_url
    - imdb_id (Unique, null: false)
    - social_links
    - awards
